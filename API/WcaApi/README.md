# Requisitos

- **Visual Studio 2019** o superior
- **.NET Framework 4.7.2** o superior
- **SQL Server 2016** o superior
- Acceso a Internet para descargar dependencias
- Permisos de administrador para instalar software
- Paquetes a instalar en la capa de __Infrastructure__ para el acceso a datos con **Entity Framework**:
	- **Microsoft.EntityFrameworkCore.SqlServer** versión 9.0.14 para usar **SQL Server** como proveedor de base de datos
	- **Microsoft.EntityFrameworkCore.Tools** versión 9.0.14 para usar los comandos de __Package Manager Console__
	- **Microsoft.EntityFrameworkCore.Design** versión 9.0.14 para migraciones, scaffolding y reverse‑engineering.