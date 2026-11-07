# Aprovisionamiento de Infraestructura con Terraform para el Servicio de Ordenes

El servicio de ordenes necesita una infraestructura AWS versionada y gestionada a través de Terraform. El objetivo es aprovisionar y versionar la infraestructura necesaria para que el servicio de ordenes opere de manera eficiente y escalable. Los actores involucrados son el equipo de desarrollo, el equipo de operaciones y los usuarios del servicio de ordenes.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el servicio de ordenes |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: JDK 17+, Maven 3.9+, IDE con soporte Java.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `mvn compile` en la raíz. Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Exploración y Configuración Inicial

**Objetivo:** Configurar el entorno de desarrollo para utilizar Terraform y comprender las necesidades de infraestructura del servicio de ordenes.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar las necesidades de infraestructura del servicio de ordenes.
- Configurar el entorno de desarrollo para utilizar Terraform.
- Crear un repositorio de versionamiento para la configuración de Terraform.

**Entregable:** Entorno de desarrollo configurado y repositorio de versionamiento creado.

<details>
<summary>Pistas de conocimiento</summary>

- Configuración de Terraform.
- Creación de repositorios de versionamiento.

</details>

### Fase 2: Definición y Aprovisionamiento de la Infraestructura

**Objetivo:** Definir y aprovisionar la infraestructura AWS necesaria para el servicio de ordenes utilizando Terraform.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Definir la configuración de la infraestructura AWS en archivos de Terraform.
- Aprovisionar la infraestructura utilizando Terraform.
- Verificar que la infraestructura se ha aprovisionado correctamente.

**Entregable:** Infraestructura AWS aprovisionada y configurada utilizando Terraform.

<details>
<summary>Pistas de conocimiento</summary>

- Definición de recursos en Terraform.
- Aprovisionamiento de recursos en AWS.

</details>

### Fase 3: Versionado y Optimización de la Infraestructura

**Objetivo:** Versionar la configuración de la infraestructura y optimizar su gestión.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Versionar los cambios en la configuración de Terraform.
- Optimizar la gestión de la infraestructura utilizando buenas prácticas de Terraform.
- Documentar el proceso de aprovisionamiento y versionado.

**Entregable:** Configuración de Terraform versionada y documentada.

<details>
<summary>Pistas de conocimiento</summary>

- Versionado de configuraciones en Terraform.
- Buenas prácticas de gestión de infraestructura.
- Java: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y para qué se utiliza en el aprovisionamiento de infraestructura?
- **paraQueSirve**: ¿Para qué sirve versionar la configuración de la infraestructura utilizando Terraform?
- **comoSeUsa**: ¿Cómo se utiliza Terraform para aprovisionar la infraestructura AWS?
- **erroresComunes**: ¿Cuáles son los errores comunes que pueden ocurrir durante el aprovisionamiento de la infraestructura con Terraform y cómo se resuelven?
- **queDecisionesImplica**: ¿Qué decisiones implica el versionado y la optimización de la configuración de la infraestructura con Terraform?

## Criterios de Evaluacion

- Configuración inicial del entorno de desarrollo para Terraform.
- Definición y aprovisionamiento de la infraestructura AWS utilizando Terraform.
- Versionado y documentación de la configuración de Terraform.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
