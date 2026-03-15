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
  // TOD0: Actualizar con la URL real de tu API local o de Azure.
  // - En desarrollo local con emulador Android, usar 10.0.2.2 en vez
  // de localhost (el emulador redirige esa IP al host).
  // - En Windows/escritorio, se puede usar localhost directamente.
  static const String apiBaseUrl = 'https://localhost:7001/api';

  // ── URLs del dashboard de Power BI ─────────────────────────────
  // Dashboard de escritorio (layout horizontal, para web y desktop).
  static const String powerBiDesktopUrl =
      'https://app.powerbi.com/view?r=eyJrIjoiMmMwODRhMGUtZTQ1ZC00ZWQxLTkxNDQtYzk1MGEzZjY5NDYwIiwidCI6IjY4NTE5ZTQ4LTgzZjMtNDM1Zi1hMzhhLTFhN2FhNzdiYTk4NyIsImMiOjh9&pageName=f1b3b895ca4a54abef98';

  // TODO: Cuando publiques el dashboard móvil, pega aquí su URL.
  // De momento usa la misma URL que escritorio.
  static const String powerBiMobileUrl =
      'https://app.powerbi.com/view?r=eyJrIjoiMmMwODRhMGUtZTQ1ZC00ZWQxLTkxNDQtYzk1MGEzZjY5NDYwIiwidCI6IjY4NTE5ZTQ4LTgzZjMtNDM1Zi1hMzhhLTFhN2FhNzdiYTk4NyIsImMiOjh9&pageName=f1b3b895ca4a54abef98';
}
