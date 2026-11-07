# Módulo de Terraform para el servicio de órdenes
# Este módulo aprovisiona los recursos AWS necesarios: ECS, RDS, SQS, etc.

# ============================================
# ECS Service - Contenedor del servicio
# ============================================
resource "aws_ecs_cluster" "orders_cluster" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "orders_task" {
  family                   = "orders-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "orders-service"
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "ENV", value = var.environment },
        { name = "LOG_LEVEL", value = var.log_level }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/orders-service"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "orders_ecs_service" {
  name            = "orders-service"
  cluster         = aws_ecs_cluster.orders_cluster.id
  task_definition = aws_ecs_task_definition.orders_task.arn
  desired_count   = var.service_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orders_tg.arn
    container_name   = "orders-service"
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.orders_listener]

  lifecycle {
    ignore_changes = [desired_count]
  }
}

# ============================================
# RDS - Base de datos PostgreSQL
# ============================================
resource "aws_db_subnet_group" "orders_db_subnet" {
  name       = "orders-db-subnet-group"
  subnet_ids = var.db_subnet_ids
  tags = {
    Name = "orders-db-subnet-group"
  }
}

resource "aws_db_instance" "orders_database" {
  identifier             = "orders-db-${var.environment}"
  engine                 = "postgres"
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  storage_encrypted      = true
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.orders_db_subnet.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  multi_az               = var.environment == "prod" ? true : false
  backup_retention_period = var.db_backup_retention
  skip_final_snapshot    = var.environment != "prod"
  final_snapshot_identifier = var.environment == "prod" ? "orders-db-final-snapshot" : null

  lifecycle {
    prevent_destroy = true
  }
}

# ============================================
# SQS - Cola de mensajes para procesamiento asíncrono
# ============================================
resource "aws_sqs_queue" "orders_queue" {
  name                       = "orders-queue-${var.environment}"
  fifo_queue                 = false
  message_retention_seconds  = 345600
  max_message_size           = 262144
  delay_seconds              = 0
  receive_wait_time_seconds  = 20

  tags = {
    Environment = var.environment
    Service     = "orders"
  }
}

resource "aws_sqs_queue" "orders_dlq" {
  name                       = "orders-queue-${var.environment}-dlq"
  fifo_queue                 = false
  message_retention_seconds  = 1209600
  max_message_size           = 262144

  tags = {
    Environment = var.environment
    Service     = "orders"
    Type        = "dead-letter"
  }
}

# ============================================
# Application Load Balancer
# ============================================
resource "aws_lb" "orders_alb" {
  name               = "orders-alb-${var.environment}"
  internal           = var.environment == "prod"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnet_ids
  enable_deletion_protection = var.environment == "prod"

  tags = {
    Environment = var.environment
    Service     = "orders"
  }
}

resource "aws_lb_target_group" "orders_tg" {
  name     = "orders-tg-${var.environment}"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "orders_listener" {
  load_balancer_arn = aws_lb.orders_alb.arn
  port              = var.alb_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orders_tg.arn
  }
}

# ============================================
# Security Groups
# ============================================
resource "aws_security_group" "alb" {
  name        = "orders-alb-sg-${var.environment}"
  description = "Security group para el ALB del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.alb_port
    to_port     = var.alb_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "HTTP traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "orders-alb-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "orders-ecs-tasks-sg-${var.environment}"
  description = "Security group para las tareas ECS del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
    description     = "Allow traffic from ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "orders-ecs-tasks-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds" {
  name        = "orders-rds-sg-${var.environment}"
  description = "Security group para RDS del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_tasks.id]
    description     = "Allow PostgreSQL from ECS tasks"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "orders-rds-sg"
    Environment = var.environment
  }
}

# ============================================
# IAM Roles para ECS
# ============================================
resource "aws_iam_role" "ecs_execution_role" {
  name = "orders-ecs-execution-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "orders-ecs-task-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task_sqs_policy" {
  name = "orders-ecs-sqs-policy"
  role = aws_iam_role.ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.orders_queue.arn
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.orders_dlq.arn
      }
    ]
  })
}