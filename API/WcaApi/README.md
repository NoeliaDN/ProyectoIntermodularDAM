# World Coffee App – Backend (.NET 8)

API REST en .NET 8 para la consulta y trazabilidad de cafés de especialidad, consumida por una aplicación cliente multiplataforma Flutter (móvil/web).

## 1. Descripción del proyecto

World Coffee App es una solución MVP orientada al **café de especialidad** que combina una aplicación Flutter multiplataforma (móvil/web) con un **backend REST en .NET 8** y una base de datos SQL Server.  

El backend expone una API que permite:
- Consultar la lista de cafés disponibles.
- Obtener la **ficha técnica** de un lote (descripción, notas de cata, altitudes, etc.).
- Visualizar el **perfil SCA** (parámetros sensoriales) para representar gráficos radiales.
- Explorar la **trazabilidad** del café: variedad, productor, tipo de productor, región y país de origen.

Este proyecto forma parte de un **proyecto intermodular** del Ciclo Formativo de Grado Superior en **Desarrollo de Aplicaciones Multiplataforma (DAM)**.

---

## 2. Arquitectura

La solución sigue una **arquitectura en capas** inspirada en las recomendaciones de Microsoft para arquitectura DDD:

- Arquitectura DDD (Microsoft Learn):  
https://learn.microsoft.com/es-es/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/ddd-oriented-microservice

### 2.1. Capas principales

1. **Capa de Presentación (cliente móvil/web)**  
   - App multiplataforma (Flutter).  
   - Consume la API vía **HTTP/JSON**.  
   - Implementa la navegación, la lógica de interfaz y componentes visuales (lista de cafés, detalle, gráfico radial para SCA, etc.).

2. **Capa de Aplicación – API Web** (`WcaApi`)  
   - Proyecto **ASP.NET Core Web API (.NET 8)**.  
   - Controladores REST (por ejemplo, `CafesController`), que organizan casos de uso y devuelven DTOs.  
   - Usa servicios de aplicación (`ICafeLoteService`, `IPerfilSCAService`) para separar la lógica de orquestación del controlador.  

3. **Capa de Dominio** (`WCA.Domain`)  
   - Contiene el **modelo de dominio** del café de especialidad:  
     - Entidades: `CafeLote`, `SCA`, `Region`, `Pais`, `Productor`, `TipoProductor`, `Variedad`, `Tueste`, `Proceso`, etc.  
     - Interfaces de repositorio: `ICafeLoteRepository`, `ISCARepository`.  
   - Agrupa las **reglas de negocio** y el conocimiento del dominio, sin depender de frameworks.

4. **Capa de Infraestructura** (`WCA.Infrastructure`)  
   - Implementa el acceso a datos con **Entity Framework Core 8**:  
     - `WCADbContext`.  
     - Configuraciones de entidades (`CafeLoteConfiguration`, etc.).  
     - Repositorios concretos (`CafeLoteRepository`, `SCARepository`).  
   - Gestiona la conexión con SQL Server y las migraciones.  
   - Sigue las guías de EF Core para modelado y tipos generados:  
     https://learn.microsoft.com/ef/core/

5. **Capa de Datos – Base de Datos** (`WorldCoffeeDB`)  
   - Base de datos **SQL Server** estructurada en varios esquemas:  
     - `cafe` (por ejemplo, `cafe.LoteCafe`).  
     - `origen` (por ejemplo, `origen.Region`, `origen.Productor`).  
     - `maestra` (por ejemplo, `maestra.Variedad`, `maestra.Tueste`, `maestra.Proceso`).  
   - Usa **claves foráneas** e integridad referencial, y 2 columnas computadas `AltitudMedia` en `cafe.LoteCafe` y `PuntuacionSCA` en `cafe.SCA` para encapsular lógica de cálculo.

---

## 3. Tecnologías principales

- **Backend**
  - .NET 8
  - ASP.NET Core Web API
  - Entity Framework Core 8 (SqlServer, Tools, Design)
  - Inyección de dependencias integrada en ASP.NET Core

- **Base de datos**
  - SQL Server (2019/2022 o Express)
  - Scripts y proyecto de BD (`WCADBProject`) para creación, seed y copias de seguridad

- **Herramientas**
  - Visual Studio 2022
  - SQL Server Management Studio (SSMS)
  - Power BI (visualización de datos y mapas)
  - Git y GitHub

---

## 4. Requisitos del entorno

Para compilar y ejecutar el backend:

- **Visual Studio 2022** con el workload de desarrollo .NET.
- **.NET 8 SDK** instalado.
- **SQL Server Express 2025** 
- Acceso a Internet para restaurar paquetes NuGet.

Paquetes EF en la capa `WCA.Infrastructure`:

- `Microsoft.EntityFrameworkCore.SqlServer` (8.0.x)
- `Microsoft.EntityFrameworkCore.Tools` (8.0.x)
- `Microsoft.EntityFrameworkCore.Design` (8.0.x)

---

## 5. Estructura de la solución

Estructura lógica de los proyectos:

- `WCA.Domain`  
  - Entidades del dominio: `CafeLote`, `SCA`, `Region`, `Productor`, `Variedad`, `Tueste`, etc.  
  - Interfaces de repositorios: `ICafeLoteRepository`, `ISCARepository`.

- `WCA.Application`  
  - DTOs: `CafeNombreDto`, `CafeLoteDto`, `CafeDetalleDto`, `SCADto`.  
  - Interfaces de los servicios de aplicación: `ICafeLoteService`, `IPerfilSCAService`.

- `WCA.Infrastructure`  
  - `WCADbContext` y configuraciones EF Core (`CafeLoteConfiguration`, ...)  
  - Repositorios: `CafeLoteRepository`, `SCARepository`.  
  - Servicios de aplicación concretos: `CafeLoteService`, `PerfilSCAService`.
  - Migraciones EF Core.

- `WcaApi`  
  - Proyecto ASP.NET Core Web API.  
  - Controlador principal: `CafesController`.  
  - Configuración de servicios en `Program.cs` (DI, Swagger, etc.).

- `WCADBProject`- Proyecto de base de datos SQL Server (scripts y backups no mapeados)
  - Scripts SQL para creación de la BD (`_bkp_CREATE_WorldCoffeeDB_1.sql`).  
  - Scripts de seed y backups (`_bkp_SeedData_WorldCoffeeDB.sql`, `_bkp_fullDB_*.sql`).  
  - Scripts de seguridad (por ejemplo, `Security\cafe.sql`).

---

## 6. Configuración y ejecución

### 6.1. Cadena de conexión

En el proyecto `WcaApi`:

1. Definir la cadena de conexión en `appsettings.json` o mediante **User Secrets** (_dot-net secrets_). Ejemplo en `appsettings.example.json`

### 6.2. Creación de la base de datos

Opciones:

- **Usar los scripts SQL** del proyecto `WCADBProject`:
  - Ejecutar `_bkp_CREATE_WorldCoffeeDB_1.sql` para crear la base.
  - Ejecutar `_bkp_SeedData_WorldCoffeeDB.sql` para datos de ejemplo.

- **Usar EF Core (migraciones)**:
  - Crear migración con _Infrastructure_ siempre como proyecto por defecto:  
    `dotnet ef migrations add InitialCreate -p WCA.Infrastructure -s WcaApi`
  - Actualizar BD:  
    `dotnet ef database update -p WCA.Infrastructure -s WcaApi`

(Ver guía EF Core: https://learn.microsoft.com/ef/core/managing-schemas/migrations/)

### 6.3. Ejecutar la API

1. Establecer `WcaApi` como proyecto de inicio en Visual Studio.  
2. Ejecutar con F5 o Ctrl+F5.  
3. Abrir Swagger en:  
   `https://localhost:<puerto>/swagger`

---

## 7. Endpoints principales

Controlador `CafesController`:

- `GET /api/cafes/nombres`  
  - Devuelve: `IReadOnlyList<CafeNombreDto>` (Id y Nombre de cada café).  
  - Uso: rellenar el selector de cafés en la app cliente.

- `GET /api/cafes/info/{id}`  
  - Devuelve: `CafeLoteDto` (ficha técnica sin perfil SCA).  
  - Datos: descripción, notas de cata, altitudes (`AltitudMin`, `AltitudMax`, `AltitudMedia`), relaciones por Id, etc.  
  - 404 si el café no existe.

- `GET /api/cafes/{id}/sca`  
  - Devuelve: `SCADto` (perfil sensorial SCA).  
  - Datos: Acidez, Cuerpo, Dulzor, Aroma, Retrogusto, Balance, PuntuacionSCA.  
  - 404 si no existe perfil SCA para ese café.

- `GET /api/cafes/{id}/detalle`  
  - Devuelve: `CafeDetalleDto` (detalle de variedad, productor y origen).  
  - Datos: nombre del café, variedad, especie, descripción de variedad, productor, tipo de productor, región y país.  
  - Uso: página de detalle y mapas (Power BI).

---

## 8. Modelo de datos y BD

La BD `WorldCoffeeDB` organiza la información en varios esquemas:

- `cafe.LoteCafe`  
  - Lote de café con: `AltitudMin`, `AltitudMax`, `AltitudMedia` (columna computada), `RegionId`, `ProductorId`, `ProcesoId`, `VariedadId`, `TuesteId`, etc.
- `origen.Region`, `origen.Pais`, `origen.Productor`  
  - Información de origen geográfico y productores.
- `maestra.Variedad`, `maestra.Tueste`, `maestra.Proceso`, `maestra.TipoProductor`  
  - Tablas maestras para clasificar variedades, procesos, tuestes y tipos de productor.

**Ventajas:**

- Integridad referencial (claves foráneas).
- Trazabilidad completa desde un lote hasta su productor, región y país.
- Facilidad de **backup** y restauración completa de la BD.
- Diseño pensado para integraciones con visualizaciones de Power BI.

---


## 9. Autoría

Proyecto desarrollado como parte del **Proyecto Intermodular** del Ciclo Formativo de Grado Superior en **Desarrollo de Aplicaciones Multiplataforma (DAM)**.

- Autora: Noelia Delgado Noguerales
- Centro: ThePower
- Curso académico: 2025/2026
