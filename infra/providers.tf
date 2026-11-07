terraform {
  required_version = "1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "orders-service"
      ManagedBy   = "Terraform"
    }
  }
}

# Configuración para el backend de Terraform (S3)
terraform {
  backend "s3" {
    bucket         = "orders-service-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "orders-service-terraform-locks"
    encrypt        = true
  }
}

# Validación de variables requeridas
variable "aws_region" {
  description = "Región de AWS donde se aprovisionará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser uno de: dev, staging, prod."
  }
}

# Configuración de provider para múltiples regiones si es necesario
provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}

# Configuración para habilitar AWS CloudTrail si el entorno es producción
resource "aws_cloudtrail" "orders_service_trail" {
  count          = var.environment == "prod" ? 1 : 0
  name           = "orders-service-trail"
  s3_bucket_name = aws_s3_bucket.cloudtrail_logs[0].bucket
  enable_logging = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }
}

resource "aws_s3_bucket" "cloudtrail_logs" {
  count  = var.environment == "prod" ? 1 : 0
  bucket = "orders-service-cloudtrail-logs-${var.environment}"
  policy = data.aws_iam_policy_document.cloudtrail_bucket_policy[0].json
}

data "aws_iam_policy_document" "cloudtrail_bucket_policy" {
  count = var.environment == "prod" ? 1 : 0

  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.cloudtrail_logs[0].bucket}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

# Configuración para habilitar AWS Config en producción
resource "aws_config_configuration_recorder" "orders_service_config" {
  count    = var.environment == "prod" ? 1 : 0
  name     = "orders-service-config-recorder"
  role_arn = aws_iam_role.config_role[0].arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_iam_role" "config_role" {
  count = var.environment == "prod" ? 1 : 0
  name  = "orders-service-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "config_role_attachment" {
  count      = var.environment == "prod" ? 1 : 0
  role       = aws_iam_role.config_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}