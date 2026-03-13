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

  // ── URL del dashboard de Power BI ──────────────────────────────
  // TOD0: Meter la URL de Power BI:
  static const String powerBiDashboardUrl = '';
}
