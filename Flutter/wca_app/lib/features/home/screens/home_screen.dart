import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Importamos WebView solo en móvil (Android/iOS).
// En web usamos HtmlElementView con un iframe.
import 'home_screen_mobile.dart' if (dart.library.html) 'home_screen_web.dart'
    as platform;

/// Pantalla principal: Mapa global de Power BI.
///
/// Delega la construcción del body a ficheros específicos de plataforma:
/// - [home_screen_mobile.dart] → usa WebView (Android/iOS).
/// - [home_screen_web.dart]    → usa un iframe HTML nativo (Chrome/Edge).
/// - En Windows/Linux/macOS    → muestra un aviso (no soportado en la MVP).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  bool get _isDesktop =>//en apps de escritorio ponemos un mensaje de momento
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Global'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Icon(Icons.map_outlined,
                        size: 20, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Mapa Global de Cafés',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _isDesktop
                    ? Center(
                        child: Text(
                          'Abre la app en Chrome o en el móvil para ver el mapa.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : const platform.PowerBiDashboard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
