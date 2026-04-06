# Proyecto: carros_usados (DB Admin)

Este repositorio contiene la configuración de **Docker** para desplegar una base de datos PostgreSQL diseñada para la gestión de un concesionario de compraventa de vehículos.

## Guía de Inicio Rápido

Sigue estos pasos para tener el sistema funcionando.

### 1. Requisitos
Asegúrate de tener instalado [Docker Desktop](https://www.docker.com/products/docker-desktop/).

### 2. Preparación
Clona este repositorio y asegúrate de que la estructura sea la siguiente:
- `docker-compose.yml`
- `sql_scripts/` (Contiene `01_schema.sql` y `02_seed.sql`)

### 3. Despliegue Inicial (Primera vez)
Abre una terminal en la carpeta raíz del proyecto y ejecuta:
```bash
docker-compose up -d