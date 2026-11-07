# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders-service/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders-service/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders-service/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/policies/iam.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd api && mvn clean compile` — componente `api` (chapter, support).

### Contratos entre componentes

- `api` expone http (api: http://localhost:8080):
  - `POST /api/orders`
  - `GET /api/orders/{id}`
  - `GET /api/orders`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).
- **Java**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `infra/modules/orders-service/outputs.tf`
- `infra/policies/iam.tf`

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderEntityMapper.java` — `com.pragma.orders.application.dto.OrderItemRequestDTO`: El import com.pragma.orders.application.dto.OrderItemRequestDTO usa un paquete propio del proyecto pero ningun archivo generado declara ese tipo. Falta generar la clase/interfaz, o el import esta mal escrito.
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderEntityMapper.java` — `com.pragma.orders.application.dto.OrderItemResponseDTO`: El import com.pragma.orders.application.dto.OrderItemResponseDTO usa un paquete propio del proyecto pero ningun archivo generado declara ese tipo. Falta generar la clase/interfaz, o el import esta mal escrito.
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderEntityMapper.java` — `com.pragma.orders.application.dto.OrderRequestDTO`: El import com.pragma.orders.application.dto.OrderRequestDTO usa un paquete propio del proyecto pero ningun archivo generado declara ese tipo. Falta generar la clase/interfaz, o el import esta mal escrito.
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderEntityMapper.java` — `com.pragma.orders.application.dto.OrderResponseDTO`: El import com.pragma.orders.application.dto.OrderResponseDTO usa un paquete propio del proyecto pero ningun archivo generado declara ese tipo. Falta generar la clase/interfaz, o el import esta mal escrito.
- `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `com.pragma.orders.application.dto.OrderRequestDTO`: El import com.pragma.orders.application.dto.OrderRequestDTO usa un paquete propio del proyecto pero ningun archivo generado declara ese tipo. Falta generar la clase/interfaz, o el import esta mal escrito.
- `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `com.pragma.orders.application.dto.OrderResponseDTO`: El import com.pragma.orders.application.dto.OrderResponseDTO usa un paquete propio del proyecto pero ningun archivo generado declara ese tipo. Falta generar la clase/interfaz, o el import esta mal escrito.
- `api/src/main/java/com/pragma/orders/infrastructure/rest/OrderController.java` — `com.pragma.orders.application.dto.OrderRequestDTO`: El import com.pragma.orders.application.dto.OrderRequestDTO usa un paquete propio del proyecto pero ningun archivo generado declara ese tipo. Falta generar la clase/interfaz, o el import esta mal escrito.
- `api/src/main/java/com/pragma/orders/infrastructure/rest/OrderController.java` — `com.pragma.orders.application.dto.OrderResponseDTO`: El import com.pragma.orders.application.dto.OrderResponseDTO usa un paquete propio del proyecto pero ningun archivo generado declara ese tipo. Falta generar la clase/interfaz, o el import esta mal escrito.
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderEntityMapper.java` — `OrderItem`: OrderItem se usa en el cuerpo del archivo pero no esta importado. El proyecto lo declara en com.pragma.orders.domain.model.OrderItem.
- `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `OrderEntityMapper`: OrderEntityMapper se usa en el cuerpo del archivo pero no esta importado. El proyecto lo declara en com.pragma.orders.infrastructure.adapter.OrderEntityMapper.
- `api/src/main/java/com/pragma/orders/application/service/OrderService.java` — `OrderStatus`: OrderStatus se usa en el cuerpo del archivo pero no esta importado. El proyecto lo declara en com.pragma.orders.domain.model.OrderStatus (hay mas de un tipo con ese nombre en el proyecto).
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderJpaRepository.java` — `OrderEntityMapper.toEntity`: Se invoca `toEntity` sobre `OrderEntityMapper`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderJpaRepository.java` — `SpringDataOrderRepository.save`: Se invoca `save` sobre `SpringDataOrderRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderJpaRepository.java` — `SpringDataOrderRepository.findById`: Se invoca `findById` sobre `SpringDataOrderRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderJpaRepository.java` — `SpringDataOrderRepository.findAll`: Se invoca `findAll` sobre `SpringDataOrderRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderJpaRepository.java` — `SpringDataOrderRepository.deleteById`: Se invoca `deleteById` sobre `SpringDataOrderRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform (corrida e2e 20261106194239047), Aprovisiona con Terraform la infraestructura AWS que necesita el servicio de ordenes

### Misión / candidato
Versionar la infraestructura del servicio

### Reto
- Tema: Infraestructura como codigo para el servicio de ordenes
- Seniority: senior-l2
- Tipo: practical
- Título: Aprovisionamiento de Infraestructura con Terraform para el Servicio de Ordenes
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Exploración y Configuración Inicial — objetivo: Configurar el entorno de desarrollo para utilizar Terraform y comprender las necesidades de infraestructura del servicio de ordenes. — entregable (NO resolver): Entorno de desarrollo configurado y repositorio de versionamiento creado.
- Fase 2: Definición y Aprovisionamiento de la Infraestructura — objetivo: Definir y aprovisionar la infraestructura AWS necesaria para el servicio de ordenes utilizando Terraform. — entregable (NO resolver): Infraestructura AWS aprovisionada y configurada utilizando Terraform.
- Fase 3: Versionado y Optimización de la Infraestructura — objetivo: Versionar la configuración de la infraestructura y optimizar su gestión. — entregable (NO resolver): Configuración de Terraform versionada y documentada.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
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

// === ARCHIVO: infra/variables.tf ===
# Variables globales para la configuración de la infraestructura
# Estas variables son utilizadas por los módulos y configuraciones principales

variable "aws_region" {
  description = "Región de AWS donde se aprovisionará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
}

variable "public_subnets" {
  description = "Lista de CIDRs para subredes públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDRs para subredes privadas"
  type        = list(string)
}

variable "database_subnets" {
  description = "Lista de CIDRs para subredes de base de datos"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar un único NAT Gateway para todas las subredes privadas"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags adicionales para los recursos"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: infra/modules/orders-service/variables.tf ===
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

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65"
    }
  }
}

// === ARCHIVO: infra/main.tf ===
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

// === ARCHIVO: infra/outputs.tf ===
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

// === ARCHIVO: infra/README.md ===
# Infraestructura como Código - Servicio de Órdenes

Este repositorio contiene la configuración de infraestructura como código utilizando Terraform para el servicio de órdenes de AWS. La infraestructura está diseñada para ser modular, reutilizable y adherida a las mejores prácticas de IaC.

## Descripción del Proyecto

El objetivo de este proyecto es aprovisionar y versionar la infraestructura necesaria para que el servicio de órdenes opere de manera eficiente y escalable en AWS. La configuración utiliza módulos reutilizables que encapsulan recursos relacionados y promueven la reutilización entre diferentes entornos.

## Estructura del Proyecto

```
.
├── environments/              # Configuraciones específicas por entorno
│   ├── dev/                   # Entorno de desarrollo
│   │   ├── main.tf            # Configuración del entorno de desarrollo
│   │   └── terraform.tfvars   # Variables específicas del entorno dev
│   └── prod/                  # Entorno de producción
│       └── main.tf            # Configuración del entorno de producción
├── modules/                   # Módulos reutilizables
│   └── orders-service/        # Módulo del servicio de órdenes
│       ├── main.tf            # Recursos del módulo
│       ├── outputs.tf         # Salidas del módulo
│       └── variables.tf       # Variables del módulo
├── policies/                  # Políticas IAM
│   └── iam.tf                 # Definición de políticas de acceso
├── providers.tf               # Configuración de proveedores
├── variables.tf               # Variables globales del proyecto
├── versions.tf                # Versiones de Terraform y proveedores
├── main.tf                    # Archivo principal que orquestra los módulos
└── outputs.tf                 # Outputs globales del proyecto
```

## Requisitos Previos

Para utilizar esta configuración de Terraform, necesitas tener instalados los siguientes componentes:

- **Terraform** versión 1.9.5 o superior. La instalación se puede realizar mediante tfenv, Homebrew (macOS), chocolatey (Windows) o descargando el binario directamente desde el sitio oficial de HashiCorp.
- **AWS CLI** configurado con credenciales válidas. Las credenciales deben tener permisos suficientes para crear los recursos definidos en los módulos.
- **Cuenta de AWS** con acceso programático configurado.

## Configuración Inicial

### Configuración de Credenciales AWS

Antes de aplicar la infraestructura, asegúrate de tener configuradas tus credenciales de AWS. Puedes hacerlo de varias formas:

Usando variables de entorno:

```bash
export AWS_ACCESS_KEY_ID="tu-access-key-id"
export AWS_SECRET_ACCESS_KEY="tu-secret-access-key"
export AWS_REGION="us-east-1"
```

O utilizando el archivo de credenciales de AWS CLI en ~/.aws/credentials y el archivo de configuración en ~/.aws/config.

### Configuración de Variables

Las variables del proyecto se definen en el archivo `variables.tf` en la raíz del proyecto. Para personalizar la configuración, puedes:

1. Modificar los valores por defecto directamente en `variables.tf`.
2. Crear un archivo `terraform.tfvars` en la raíz con valores personalizados.
3. Utilizar archivos de vars específicos por entorno en la carpeta `environments/`.

Para el entorno de desarrollo, edita el archivo `environments/dev/terraform.tfvars` con los valores deseados.

## Uso de Terraform

### Inicialización

El primer paso es inicializar Terraform, lo que descargará los proveedores necesarios y preparará el backend:

```bash
terraform init
```

Este comando leerá el archivo `versions.tf` para determinar qué versiones de proveedores utilizar y configurará el backend para almacenar el estado de la infraestructura.

### Validación de la Configuración

Antes de aplicar cualquier cambio, es recomendable validar que la configuración no tenga errores de sintaxis:

```bash
terraform validate
```

Este comando verifica que todos los archivos de configuración sean sintácticamente válidos y que las referencias entre recursos sean coherentes.

### Planificación de Cambios

Para ver qué cambios se aplicarán a la infraestructura sin realizarlos efectivamente, ejecuta:

```bash
terraform plan
```

Este comando mostrará un resumen de los recursos que se crearán, modificarán o destruirán. Es una buena práctica revisar siempre este output antes de aplicar cambios.

### Aplicación de la Infraestructura

Para crear o actualizar la infraestructura, utiliza el comando:

```bash
terraform apply
```

Terraform mostrará el plan de cambios y solicitará confirmación. Para aplicar sin necesidad de confirmación, puedes usar:

```bash
terraform apply -auto-approve
```

### Destrucción de la Infraestructura

Cuando ya no necesites la infraestructura, puedes destruir todos los recursos creados:

```bash
terraform destroy
```

Al igual que con apply, puedes usar `-auto-approve` para destruir sin confirmación:

```bash
terraform destroy -auto-approve
```

**Advertencia**: La destrucción de recursos es irreversible. Asegúrate de tener backups de cualquier dato importante antes de ejecutar este comando.

## Entornos

El proyecto soporta múltiples entornos mediante la分离ón de configuraciones en la carpeta `environments/`.

### Entorno de Desarrollo

El entorno de desarrollo está configurado en `environments/dev/`. Este entorno utiliza recursos de menor tamaño y está optimizado para pruebas rápidas y desarrollo continuo. Para aplicar este entorno:

```bash
cd environments/dev
terraform init
terraform apply
```

### Entorno de Producción

El entorno de producción está configurado en `environments/prod/`. Este entorno utiliza recursos de mayor capacidad y tiene configuraciones de alta disponibilidad. Para aplicar este entorno:

```bash
cd environments/prod
terraform init
terraform apply
```

## Módulos

### Módulo orders-service

El módulo `orders-service` encapsula todos los recursos necesarios para el servicio de órdenes, incluyendo compute, almacenamiento, base de datos, red y seguridad. Los parámetros configurables incluyen el entorno, la región de AWS, el CIDR de la VPC, el tamaño de la base de datos y el tipo de instancia.

Para utilizar el módulo en tu propia configuración:

```hcl
module "orders-service" {
  source = "./modules/orders-service"
  
  environment = "production"
  aws_region  = "us-east-1"
  vpc_cidr    = "10.0.0.0/16"
  
  db_instance_class = "db.t3.medium"
  db_allocated_storage = 100
  
  ecs_cluster_instance_type = "t3.medium"
  ecs_clusterDesiredCapacity = 2
}
```

## Políticas IAM

Las políticas IAM se definen en `policies/iam.tf` y siguen el principio de mínimo privilegio. Cada rol tiene únicamente los permisos necesarios para operar los recursos asignados. Los comentarios en cada política explican el propósito y la necesidad de cada permiso.

## Outputs

Los outputs del proyecto exponen información crítica sobre los recursos aprovisionados, como endpoints de servicios, ARNs de recursos y URLs de acceso. Consulta el archivo `outputs.tf` para ver todos los outputs disponibles.

Para consultar un output específico después de aplicar la infraestructura:

```bash
terraform output <nombre_del_output>
```

## Mejores Prácticas Utilizadas

Este proyecto sigue las mejores prácticas de infraestructura como código:

- **Módulos reutilizables**: Los recursos relacionados están encapsulados en módulos para promover la reutilización y reducir la duplicación de código.
- **Separación de entornos**: Cada entorno tiene su propia configuración, permitiendo despliegues independientes y controlados.
- **Variables con valores por defecto**: Las variables tienen descripciones claras y valores por defecto sensatos para facilitar la adopción.
- **State management**: El estado de Terraform se gestiona de forma remota (configurable) para permitir colaboración entre equipos.
- **Versionado**: Las versiones de Terraform y proveedores están explícitamente controladas para garantizar reproducibilidad.
- **Documentación inline**: Cada recurso y variable tiene comentarios que explican su propósito y uso.

## Contribución

Para contribuir a este proyecto, asegúrate de seguir las convenciones establecidas en la propuesta arquitectónica. Los cambios deben ser probados en el entorno de desarrollo antes de ser aplicados a producción.

## Licencia

Este proyecto está bajo la licencia especificada en el repositorio.

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/environments/dev/main.tf ===
# Configuración específica para el entorno de desarrollo
# ESTA ES SUPERFICIE DE PRACTICA - Stub para que el estudiante implemente

// === ARCHIVO: infra/environments/prod/main.tf ===
# Configuración específica para el entorno de producción
# ESTA ES SUPERFICIE DE PRACTICA - Stub para que el estudiante implemente

// === ARCHIVO: infra/modules/orders-service/main.tf ===
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

// === ARCHIVO: api/pom.xml ===
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.5.6</version>
        <relativePath/>
    </parent>

    <groupId>com.pragma</groupId>
    <artifactId>orders</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>orders</name>
    <description>Servicio de órdenes para gestión de pedidos</description>

    <properties>
        <java.version>21</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>io.github.resilience4j</groupId>
            <artifactId>resilience4j-spring-boot3</artifactId>
            <version>2.2.0</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>42.7.3</version>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-core</artifactId>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.30</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>

// === ARCHIVO: api/src/main/java/com/pragma/orders/OrdersApplication.java ===
package com.pragma.orders;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class OrdersApplication {

    public static void main(String[] args) {
        SpringApplication.run(OrdersApplication.class, args);
    }

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import lombok.Data;

@Data
@Configuration
@ConfigurationProperties(prefix = "orders")
class OrdersProperties {
    private String apiBaseUrl;
    private int maxRetries;
    private long retryDelayMillis;
}

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.github.resilience4j.circuitbreaker.CircuitBreaker;
import io.github.resilience4j.circuitbreaker.CircuitBreakerConfig;
import java.time.Duration;

@Configuration
class ResilienceConfig {

    @Bean
    public CircuitBreaker orderCircuitBreaker() {
        CircuitBreakerConfig config = CircuitBreakerConfig.custom()
                .failureRateThreshold(50)
                .waitDurationInOpenState(Duration.ofMillis(1000))
                .permittedNumberOfCallsInHalfOpenState(3)
                .slidingWindowSize(10)
                .build();
        return CircuitBreaker.of("orderService", config);
    }
}

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
class ApplicationStartup {

    @EventListener(ApplicationReadyEvent.class)
    public void onApplicationReady() {
        log.info("Orders Application is ready!");
    }
}

// === ARCHIVO: api/src/main/resources/application.yml ===
spring:
  application:
    name: orders-service
  datasource:
    url: jdbc:postgresql://localhost:5432/orders_db
    username: ${DB_USERNAME:orders_user}
    password: ${DB_PASSWORD:orders_pass}
    driver-class-name: org.postgresql.Driver
  jpa:
    hibernate:
      ddl-auto: validate
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
    show-sql: true
  flyway:
    enabled: true
    locations: classpath:db/migration
    baseline-on-migrate: true

orders:
  api-base-url: http://localhost:8080
  max-retries: 3
  retry-delay-millis: 1000

server:
  port: 8080
  servlet:
    context-path: /api

logging:
  level:
    root: INFO
    com.pragma.orders: DEBUG
    org.hibernate.SQL: DEBUG
    org.hibernate.type.descriptor.sql.BasicBinder: TRACE

// === ARCHIVO: api/src/main/java/com/pragma/orders/domain/model/Order.java ===
package com.pragma.orders.domain.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    private UUID id;
    private UUID customerId;
    private LocalDateTime orderDate;
    private OrderStatus status;
    private List<OrderItem> items;
    private BigDecimal totalAmount;
    private String shippingAddress;
    private String paymentMethod;
    private String notes;

    public enum OrderStatus {
        PENDING,
        PROCESSING,
        SHIPPED,
        DELIVERED,
        CANCELLED
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class OrderItem {
        private UUID productId;
        private String productName;
        private int quantity;
        private BigDecimal unitPrice;
        private BigDecimal totalPrice;
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/domain/port/OrderRepository.java ===
package com.pragma.orders.domain.port;

import com.pragma.orders.domain.model.Order;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface OrderRepository {
    Order save(Order order);
    Optional<Order> findById(UUID id);
    List<Order> findAll();
    List<Order> findByCustomerId(UUID customerId);
    void deleteById(UUID id);
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderJpaRepository.java ===
package com.pragma.orders.infrastructure.adapter;

import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.port.OrderRepository;
import com.pragma.orders.infrastructure.entity.OrderEntity;
import com.pragma.orders.infrastructure.jpa.SpringDataOrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class OrderJpaRepository implements OrderRepository {
    private final SpringDataOrderRepository springDataOrderRepository;
    private final OrderEntityMapper orderEntityMapper;

    @Override
    public Order save(Order order) {
        OrderEntity entity = orderEntityMapper.toEntity(order);
        OrderEntity savedEntity = springDataOrderRepository.save(entity);
        return orderEntityMapper.toDomain(savedEntity);
    }

    @Override
    public Optional<Order> findById(UUID id) {
        return springDataOrderRepository.findById(id)
                .map(orderEntityMapper::toDomain);
    }

    @Override
    public List<Order> findAll() {
        return springDataOrderRepository.findAll().stream()
                .map(orderEntityMapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<Order> findByCustomerId(UUID customerId) {
        return springDataOrderRepository.findByCustomerId(customerId).stream()
                .map(orderEntityMapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteById(UUID id) {
        springDataOrderRepository.deleteById(id);
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/adapter/OrderEntityMapper.java ===
package com.pragma.orders.infrastructure.adapter;

import com.pragma.orders.application.dto.OrderItemRequestDTO;
import com.pragma.orders.application.dto.OrderItemResponseDTO;
import com.pragma.orders.application.dto.OrderRequestDTO;
import com.pragma.orders.application.dto.OrderResponseDTO;
import com.pragma.orders.domain.model.Order;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class OrderEntityMapper {

    public Order toDomain(OrderRequestDTO dto) {
        if (dto == null) {
            return null;
        }

        Order order = new Order();
        order.setCustomerId(dto.getCustomerId());
        order.setShippingAddress(dto.getShippingAddress());
        order.setPaymentMethod(dto.getPaymentMethod());
        order.setNotes(dto.getNotes());

        List<Order.OrderItem> items = dto.getItems().stream()
                .map(this::toDomainItem)
                .collect(Collectors.toList());
        order.setItems(items);

        return order;
    }

    private Order.OrderItem toDomainItem(OrderItemRequestDTO dto) {
        Order.OrderItem item = new Order.OrderItem();
        item.setId(UUID.randomUUID());
        item.setProductId(dto.getProductId());
        item.setProductName(dto.getProductName());
        item.setQuantity(dto.getQuantity());
        item.setUnitPrice(dto.getUnitPrice());
        item.setTotalPrice(dto.getTotalPrice());
        return item;
    }

    public OrderResponseDTO toResponse(Order order) {
        if (order == null) {
            return null;
        }

        OrderResponseDTO dto = new OrderResponseDTO();
        dto.setId(order.getId());
        dto.setCustomerId(order.getCustomerId());
        dto.setOrderDate(order.getOrderDate());
        dto.setStatus(order.getStatus());
        dto.setTotalAmount(order.getTotalAmount());
        dto.setShippingAddress(order.getShippingAddress());
        dto.setPaymentMethod(order.getPaymentMethod());
        dto.setNotes(order.getNotes());

        List<OrderItemResponseDTO> items = order.getItems().stream()
                .map(this::toResponseItem)
                .collect(Collectors.toList());
        dto.setItems(items);

        return dto;
    }

    private OrderItemResponseDTO toResponseItem(Order.OrderItem item) {
        return new OrderItemResponseDTO(
                item.getId(),
                item.getProductId(),
                item.getProductName(),
                item.getQuantity(),
                item.getUnitPrice(),
                item.getTotalPrice()
        );
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/entity/OrderEntity.java ===
package com.pragma.orders.infrastructure.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "orders")
public class OrderEntity {
    @Id
    private UUID id;

    @Column(nullable = false)
    private UUID customerId;

    @Column(nullable = false)
    private LocalDateTime orderDate;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItemEntity> items;

    @Column(nullable = false)
    private BigDecimal totalAmount;

    @Column(nullable = false)
    private String shippingAddress;

    @Column(nullable = false)
    private String paymentMethod;

    private String notes;

    public enum OrderStatus {
        PENDING,
        PROCESSING,
        SHIPPED,
        DELIVERED,
        CANCELLED
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/entity/OrderItemEntity.java ===
package com.pragma.orders.infrastructure.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "order_items")
public class OrderItemEntity {
    @Id
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private OrderEntity order;

    @Column(nullable = false)
    private UUID productId;

    @Column(nullable = false)
    private String productName;

    @Column(nullable = false)
    private int quantity;

    @Column(nullable = false)
    private BigDecimal unitPrice;

    @Column(nullable = false)
    private BigDecimal totalPrice;
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/jpa/SpringDataOrderRepository.java ===
package com.pragma.orders.infrastructure.jpa;

import com.pragma.orders.infrastructure.entity.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SpringDataOrderRepository extends JpaRepository<OrderEntity, UUID> {
    List<OrderEntity> findByCustomerId(UUID customerId);
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/config/MapStructConfig.java ===
package com.pragma.orders.infrastructure.config;

import org.springframework.context.annotation.Configuration;

/**
 * Configuración centralizada para mapeos de entidades.
 * Proporciona beans de configuración para los mapeadores del proyecto.
 * Esta implementación utiliza mapeos manuales a través de la interfaz OrderEntityMapper
 * definida en el dominio, evitando dependencias externas de bibliotecas de mapeo automático.
 */
@Configuration
public class MapStructConfig {

    public MapStructConfig() {
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/application/service/OrderService.java ===
package com.pragma.orders.application.service;

import com.pragma.orders.application.dto.OrderRequestDTO;
import com.pragma.orders.application.dto.OrderResponseDTO;
import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.port.OrderRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderEntityMapper orderEntityMapper;

    public OrderService(OrderRepository orderRepository, OrderEntityMapper orderEntityMapper) {
        this.orderRepository = orderRepository;
        this.orderEntityMapper = orderEntityMapper;
    }

    @Transactional
    public OrderResponseDTO createOrder(OrderRequestDTO request) {
        Order order = orderEntityMapper.toDomain(request);
        order.setId(UUID.randomUUID());
        order.setOrderDate(LocalDateTime.now());
        order.setStatus(Order.OrderStatus.PENDING.name());
        order.setTotalAmount(calculateTotal(order));

        Order savedOrder = orderRepository.save(order);
        return orderEntityMapper.toResponse(savedOrder);
    }

    @Transactional(readOnly = true)
    public OrderResponseDTO getOrder(UUID id) {
        return orderRepository.findById(id)
                .map(orderEntityMapper::toResponse)
                .orElseThrow(() -> new OrderNotFoundException("Orden no encontrada: " + id));
    }

    @Transactional(readOnly = true)
    public List<OrderResponseDTO> listOrders() {
        return orderRepository.findAll().stream()
                .map(orderEntityMapper::toResponse)
                .collect(Collectors.toList());
    }

    private BigDecimal calculateTotal(Order order) {
        return order.getItems().stream()
                .map(item -> item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public static class OrderNotFoundException extends RuntimeException {
        public OrderNotFoundException(String message) {
            super(message);
        }
    }
}

// === ARCHIVO: api/src/main/java/com/pragma/orders/infrastructure/rest/OrderController.java ===
package com.pragma.orders.infrastructure.rest;

import com.pragma.orders.application.dto.OrderRequestDTO;
import com.pragma.orders.application.dto.OrderResponseDTO;
import com.pragma.orders.application.service.OrderService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponseDTO> createOrder(@Valid @RequestBody OrderRequestDTO request) {
        OrderResponseDTO response = orderService.createOrder(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponseDTO> getOrder(@PathVariable UUID id) {
        OrderResponseDTO response = orderService.getOrder(id);
        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<List<OrderResponseDTO>> listOrders() {
        List<OrderResponseDTO> orders = orderService.listOrders();
        return ResponseEntity.ok(orders);
    }
}

// === ARCHIVO: api/src/main/resources/db/migration/V1__initial_schema.sql ===
-- Script de migración inicial para el esquema de la base de datos del servicio de órdenes
-- Versión: V1
-- Objetivo: Crear las tablas necesarias para almacenar información de órdenes y sus elementos

-- Tabla de órdenes
CREATE TABLE orders (
    id UUID PRIMARY KEY,
    customer_id UUID NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    total_amount DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
    shipping_address VARCHAR(500) NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de elementos de orden
CREATE TABLE order_items (
    id UUID PRIMARY KEY,
    order_id UUID NOT NULL,
    product_id UUID NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(19, 2) NOT NULL CHECK (unit_price >= 0),
    total_price DECIMAL(19, 2) NOT NULL CHECK (total_price >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE
);

-- Índices para optimizar consultas frecuentes
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_order_date ON orders(order_date DESC);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Comentarios para documentación del esquema
COMMENT ON TABLE orders IS 'Almacena las órdenes realizadas por los clientes';
COMMENT ON TABLE order_items IS 'Contiene los elementos individuales de cada orden';
COMMENT ON COLUMN orders.status IS 'Estados posibles: PENDING, CONFIRMED, PREPARING, READY, DELIVERED, CANCELLED';
COMMENT ON COLUMN orders.total_amount IS 'Monto total de la orden incluyendo todos los elementos';
COMMENT ON COLUMN order_items.total_price IS 'Precio unitario multiplicado por la cantidad';

-- Función para actualizar automáticamente la columna updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger para actualizar updated_at en la tabla orders
CREATE TRIGGER update_orders_updated_at
    BEFORE UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Restricciones adicionales a nivel de base de datos
ALTER TABLE orders ADD CONSTRAINT chk_orders_total_amount_positive
    CHECK (total_amount >= 0);

ALTER TABLE orders ADD CONSTRAINT chk_orders_status_valid
    CHECK (status IN ('PENDING', 'CONFIRMED', 'PREPARING', 'READY', 'DELIVERED', 'CANCELLED'));

ALTER TABLE order_items ADD CONSTRAINT chk_order_items_quantity_positive
    CHECK (quantity > 0);

ALTER TABLE order_items ADD CONSTRAINT chk_order_items_unit_price_positive
    CHECK (unit_price >= 0);

ALTER TABLE order_items ADD CONSTRAINT chk_order_items_total_price_positive
    CHECK (total_price >= 0);
```
