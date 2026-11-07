# Variables específicas para el módulo del servicio de órdenes
# Estas variables permiten personalizar el despliegue del servicio en diferentes entornos

variable "service_name" {
  description = "Nombre del servicio de órdenes"
  type        = string
  default     = "orders-service"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "container_port" {
  description = "Puerto expuesto por el contenedor"
  type        = number
  default     = 8080
}

variable "desired_count" {
  description = "Número deseado de tareas de ECS"
  type        = number
  default     = 2
}

variable "cpu" {
  description = "CPU asignada a la tarea de ECS"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memoria asignada a la tarea de ECS"
  type        = number
  default     = 512
}

variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "ordersdb"
}

variable "database_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "database_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}

variable "database_instance_class" {
  description = "Clase de instancia de la base de datos"
  type        = string
  default     = "db.t3.micro"
}

variable "database_allocated_storage" {
  description = "Almacenamiento asignado a la base de datos (GB)"
  type        = number
  default     = 20
}

variable "database_max_allocated_storage" {
  description = "Almacenamiento máximo asignado a la base de datos (GB)"
  type        = number
  default     = 100
}

variable "enable_auto_scaling" {
  description = "Habilitar auto escalado para el servicio ECS"
  type        = bool
  default     = false
}

variable "min_capacity" {
  description = "Capacidad mínima para auto escalado"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Capacidad máxima para auto escalado"
  type        = number
  default     = 10
}

variable "alb_ingress_ports" {
  description = "Puertos de entrada para el Application Load Balancer"
  type        = list(number)
  default     = [80, 443]
}

variable "enable_https" {
  description = "Habilitar HTTPS en el ALB"
  type        = bool
  default     = false
}

variable "ssl_certificate_arn" {
  description = "ARN del certificado SSL para HTTPS"
  type        = string
  default     = ""
}

variable "health_check_path" {
  description = "Ruta para el health check del servicio"
  type        = string
  default     = "/health"
}

variable "logs_retention_in_days" {
  description = "Días de retención para los logs de CloudWatch"
  type        = number
  default     = 7
}