/// Constantes globales de la aplicación World Coffee Atlas.
///
/// Centralizar las constantes en un solo archivo facilita:
/// - Cambiar URLs al pasar de desarrollo local a producción (Azure).
/// - Evitar "magic strings" dispersas por el código.
/// - Documentar qué valores usa la app y por qué.
class AppConstants {
  AppConstants._(); // No instanciable.

  /// Nombre de la aplicación:
  static const String appName = 'World Coffee Atlas';

  // ── URLs de la API REST (ASP.NET Core) ─────────────────────────
  // TOD0: Actualizar con la URL real de la API local: 
  
  //Ej.: static const String apiBaseUrl = 'https://localhost:7001/api';

  // ── URLs del dashboard de Power BI ─────────────────────────────
  // Dashboard de escritorio (layout horizontal, para web y desktop):
  static const String powerBiDesktopUrl =
      'https://app.powerbi.com/view?r=eyJrIjoiMmMwODRhMGUtZTQ1ZC00ZWQxLTkxNDQtYzk1MGEzZjY5NDYwIiwidCI6IjY4NTE5ZTQ4LTgzZjMtNDM1Zi1hMzhhLTFhN2FhNzdiYTk4NyIsImMiOjh9&pageName=f1b3b895ca4a54abef98';

  // TOD0: publicar el dashboard móvil y actualizar URL:
  static const String powerBiMobileUrl =
      'https://app.powerbi.com/view?r=eyJrIjoiMmMwODRhMGUtZTQ1ZC00ZWQxLTkxNDQtYzk1MGEzZjY5NDYwIiwidCI6IjY4NTE5ZTQ4LTgzZjMtNDM1Zi1hMzhhLTFhN2FhNzdiYTk4NyIsImMiOjh9&pageName=f1b3b895ca4a54abef98';
}
