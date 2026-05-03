# World Coffee Atlas

Aplicación para el Proyecto Intermodular del **CFGS Desarrollo de Aplicaciones Multiplataforma** que combina una **API REST** en **ASP.NET Core**, dashboards de **Power BI** y una app multiplataforma en **Flutter** para explorar, a modo de Wiki, las diversas características de los cafés de especialidad, sus variedades y productores a nivel mundial, con un enfoque fácilmente accesible y predominantemente visual.

**Autor**: Noelia Delgado Noguerales (**_NoeliaDN_**) [![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?logo=linkedin&style=flat-square)](https://www.linkedin.com/in/noelia-delgado-1b9426193/)


## Estructura del repositorio

```
ProyectoIntermodularDAM/
├── API/          # Backend ASP.NET Core
├── Flutter/      # App Flutter (wca_app)
├── PowerBI/      # Archivos .pbix de los dashboards
└── ScriptsBD/    # Scripts SQL para crear y poblar la base de datos
```



## Requisitos técnicos

| Herramienta | Versión mínima |
|---|---|
| Flutter SDK | 3.41.x |
| Dart SDK | 3.11.x |
| Visual Studio 2022 Community | 17.x |
| .NET SDK | 8.0 |
| SQL Server Express | 2025 |
| VS Code + extensiones Flutter/Dart | última estable |
| Google Chrome o Microsoft Edge | última estable |

> **Opcional**: Sql Server Management Studio 2022 (SSMS) como SGBD.

## Puesta en marcha

### 1. Base de datos

Tienes 2 opciones:

- Con el **Proyecto de BD** en Visual Studio:
1. Abre la solución del proyecto API en `API/WcaApi`
2.  Dentro del explorador de archivos, haz clic derecho en el **Proyecto de BD** `API/WCADBProject/` y dale a _Publicar_.
3.  Selecciona la instancia local de **SQL Server Express** como **base de datos de destino** (`Editar>Examinar>Local`). Escoge:
      - _Autenticación de Windows_
      - _Confiar en el Certificado del Servidor_ = true
4. Dale a _Publicar_:
   - La creación de tablas se hace automáticamente.
   - El script de datos iniciales (`SeedData.sql`), se ejecuta tras el CREATE de las tablas.
5. Anota el nombre de tu instancia (ej. `localhost\SQLEXPRESS`). 

- Con **SSMS**:
1. Abre SSMS y conéctate a tu instancia local de SQL Server:
      - _Autenticación de Windows_
      - _Confiar en el Certificado del Servidor_ = true
3. Ejecuta el script de la carpeta `ScriptsBD/`   
4. Anota el nombre de tu instancia (ej. `localhost\SQLEXPRESS`). 
     
### 2. API (ASP.NET Core)

1. Abre `API/` con Visual Studio 2022.
2. En `WcaApi/appsettings.json`, actualiza la cadena de conexión con tu instancia:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=WCA;Trusted_Connection=True;"
   }
   ```
   > Si sale un _warning_ en tu cadena de conexión, prueba a poner `\\SQLEXPRESS` en vez de `\SQLEXPRESS`
3. Ejecuta el proyecto (`F5`). La API arrancará en `https://localhost:7082`.

> **Emulador Android:** la app usa `https://10.0.2.2:7082` automáticamente. No hace falta cambiar nada en Flutter.

### 3. App Flutter

```bash
cd Flutter/wca_app
flutter pub get
```

**Web (Chrome o Edge):**
```bash
flutter run -d chrome
# o bien:
flutter run -d edge
```

**Emulador Android:**
```bash
flutter emulators --launch <nombre_emulador>
flutter run -d emulator-5554
```

> El certificado TLS de desarrollo de ASP.NET Core es auto-firmado. En Android el cliente HTTP lo acepta automáticamente (solo en desarrollo, para agilizar).

### 4. Power BI

Abre los archivos `.pbix` de la carpeta `PowerBI/` con Power BI Desktop para ver o editar los dashboards. Las URLs públicas ya están configuradas en la app (dashboards originales publicados).



## Dependencias Flutter principales

| Paquete | Uso |
|---|---|
| `google_fonts` | Tipografías (Lora, Bona Nova SC) |
| `http` | Llamadas a la API REST |
| `webview_flutter` | Mapas Power BI en Android/iOS |
| `web` | Iframe Power BI en Chrome/Edge |
| `fl_chart` | Gráficos radial y de barras |

