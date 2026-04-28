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
  // Para emulador Android, usa 10.0.2.2 en vez de localhost.
  // Para dispositivo físico, usa la IP de tu PC (ej: 192.168.1.X).
  static const String apiBaseUrl = 'https://localhost:7082/api'; // para web local

  // ── URLs del dashboard de Power BI ─────────────────────────────
  // Dashboard de web:
  static const String powerBiGlobalUrl =
      'https://app.powerbi.com/view?r=eyJrIjoiMmMwODRhMGUtZTQ1ZC00ZWQxLTkxNDQtYzk1MGEzZjY5NDYwIiwidCI6IjY4NTE5ZTQ4LTgzZjMtNDM1Zi1hMzhhLTFhN2FhNzdiYTk4NyIsImMiOjh9&pageName=f1b3b895ca4a54abef98';

  // TOD0: publicar el dashboard móvil y actualizar URL:
  static const String powerBiMobileUrl =
      'https://app.powerbi.com/view?r=eyJrIjoiMmMwODRhMGUtZTQ1ZC00ZWQxLTkxNDQtYzk1MGEzZjY5NDYwIiwidCI6IjY4NTE5ZTQ4LTgzZjMtNDM1Zi1hMzhhLTFhN2FhNzdiYTk4NyIsImMiOjh9&pageName=f1b3b895ca4a54abef98';

  // Dashboard de variedades y productores:
  static const String powerBiVariedadesUrl =
      'https://app.powerbi.com/view?r=eyJrIjoiMzVjODIyNzItOTBlOS00YmUxLWJkNTgtNTBlMTJjZDgxNGY0IiwidCI6IjY4NTE5ZTQ4LTgzZjMtNDM1Zi1hMzhhLTFhN2FhNzdiYTk4NyIsImMiOjh9&pageName=6389bee9860b8cd09808';
}
