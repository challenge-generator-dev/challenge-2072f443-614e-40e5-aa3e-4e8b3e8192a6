# Configuracion principal de infraestructura para el servicio de ordenes
# Este archivo define los providers y la estructura base de recursos

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "orders-service"
      ManagedBy   = "terraform"
    }
  }
}

# Modulo del servicio de ordenes
module "orders_service" {
  source = "../modules/orders-service"

  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  db_instance_class     = var.db_instance_class
  db_allocated_storage  = var.db_allocated_storage
  ecs_cluster_name      = var.ecs_cluster_name
  ecs_service_name      = var.ecs_service_name
  container_image       = var.container_image
  container_port        = var.container_port
  desired_count         = var.desired_count
  min_capacity          = var.min_capacity
  max_capacity          = var.max_capacity
  alb_name              = var.alb_name
  alb_port              = var.alb_port
  alb_protocol          = var.alb_protocol
  certificate_arn       = var.certificate_arn

  tags = {
    Environment = var.environment
    Project     = "orders-service"
  }
}