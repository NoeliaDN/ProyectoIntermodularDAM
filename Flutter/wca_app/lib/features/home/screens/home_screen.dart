import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wca_app/core/constants/app_constants.dart';

// Importamos WebView solo en móvil (Android/iOS).
// En web usamos HtmlElementView con un iframe.
import 'home_screen_mobile.dart' if (dart.library.html) 'home_screen_web.dart'
    as platform;

/// Pantalla principal: Mapa global de Power BI.
///
/// Delega la construcción del body a ficheros específicos de plataforma:
/// - [home_screen_mobile.dart] → usa WebView (Android/iOS).
/// - [home_screen_web.dart]    → usa un iframe HTML nativo (Chrome/Edge).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Global'),
        centerTitle: true,
      ),
      body: const platform.PowerBiDashboard(),
    );
  }
}
