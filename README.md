# World Coffee Atlas

Aplicación para el Proyecto Intermodular del CFGS Desarrollo de Aplicaciones Multiplataforma que combina una **API REST** en **ASP.NET Core**, dashboards de **Power BI** y una app multiplataforma en **Flutter** para explorar, a modo de Wiki, las diversas características de los cafés de especialidad, sus variedades y productores a nivel mundial, con un enfoque fácilmente accesible y predominantemente visual.


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
| SQL Server Express | 2022 / 2025 |
| VS Code + extensiones Flutter/Dart | última estable |
| Google Chrome o Microsoft Edge | última estable |



## Puesta en marcha

### 1. Base de datos

1. Abre SSMS y conéctate a tu instancia local de SQL Server.
2. Ejecuta en orden los scripts de la carpeta `ScriptsBD/`, también disponibles en `API/WCADBProject/scripts` (ejecutables en VS y ocultas con .gitignore hasta el día de la entrega):
   - Script de creación de tablas
   - Script de datos iniciales (población)
3. Anota el nombre de tu instancia (ej. `localhost\SQLEXPRESS`).

### 2. API (ASP.NET Core)

1. Abre `API/` con Visual Studio 2022.
2. En `WcaApi/appsettings.json`, actualiza la cadena de conexión con tu instancia:
   ```json
   "ConnectionStrings": {
     "DefaultConnection": "Server=localhost\\SQLEXPRESS;Database=WCA;Trusted_Connection=True;"
   }
   ```
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
| `webview_flutter` | Mapa Power BI en Android/iOS |
| `web` | Iframe Power BI en Chrome/Edge |
| `fl_chart` | Gráficos radiales SCA |

