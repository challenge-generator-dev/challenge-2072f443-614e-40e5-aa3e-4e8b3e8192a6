# Configuración específica para el entorno de desarrollo
# Este archivo define los valores de las variables para el ambiente de desarrollo

# Configuración regional de AWS
aws_region = "us-east-1"

# Nombre del entorno
environment = "dev"

# Configuración del servicio de órdenes
orders_service = {
  name           = "orders-service"
  instance_type  = "t3.micro"
  instance_count = 1
  min_size       = 1
  max_size       = 2
  desired_size   = 1
}

# Configuración de base de datos RDS
rds_config = {
  identifier     = "orders-dev-db"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  multi_az             = false
  skip_final_snapshot  = true
}

# Configuración de ElastiCache Redis
redis_config = {
  node_type       = "cache.t3.micro"
  num_cache_nodes = 1
  engine_version  = "7.0"
  port            = 6379
}

# Configuración de VPC y networking
vpc_config = {
  cidr_block           = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.10.0/24", "10.0.11.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

# Configuración de seguridad
security_config = {
  enable_deletion_protection = false
  enable_encryption          = true
  allowed_cidr_blocks        = ["0.0.0.0/0"]
}

# Configuración de logs y monitoring
monitoring_config = {
  enable_detailed_monitoring = true
  enable_alarms              = false
  log_retention_days         = 7
}

# Tags comunes para todos los recursos
common_tags = {
  Environment = "dev"
  Project     = "orders-platform"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
}