import 'package:flutter/material.dart';
import 'package:wca_app/core/theme/app_theme.dart';
import 'package:wca_app/features/splash/screens/splash_screen.dart';

/// Widget raíz de la aplicación World Coffee Atlas.
///
/// Se separa de [main.dart] siguiendo la convención de Flutter.
class WcaApp extends StatelessWidget {
  const WcaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Coffee Atlas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
