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