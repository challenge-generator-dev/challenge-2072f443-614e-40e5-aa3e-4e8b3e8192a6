# Outputs de la infraestructura principal
# Expone informacion critica para consumo por otros componentes

output "orders_service_endpoint" {
  description = "Endpoint del Application Load Balancer para el servicio de ordenes"
  value       = module.orders_service.alb_dns_name
}

output "orders_service_arn" {
  description = "ARN del servicio ECS"
  value       = module.orders_service.ecs_service_arn
}

output "orders_service_security_group_id" {
  description = "ID del security group del servicio de ordenes"
  value       = module.orders_service.service_security_group_id
}

output "database_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.orders_service.db_endpoint
}

output "database_name" {
  description = "Nombre de la base de datos"
  value       = module.orders_service.db_name
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.orders_service.vpc_id
}

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = module.orders_service.ecs_cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN del cluster ECS"
  value       = module.orders_service.ecs_cluster_arn
}