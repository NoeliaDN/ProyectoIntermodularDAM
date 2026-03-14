import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wca_app/core/theme/app_theme.dart';
import 'package:wca_app/shared/widgets/main_scaffold.dart';

/// SPLASH SCREEN con el logo de la app
///
/// Se usa un [StatefulWidget] porque necesitamos ejecutar lógica
/// en [initState] (el temporizador) y limpiarla si el widget se
/// desmonta antes de que termine.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

     Future<void> _navigateToHome() async { /// Espera 6 segundos y navega a [MainScaffold]
    await Future.delayed(const Duration(seconds: 6));

    // mounted verifica que el widget sigue en el árbol antes de navegar.
    // Es obligatorio comprobarlo tras un await (regla de Flutter).
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const MainScaffold(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Logo ─────────────────────────────────────────────
            Image.asset('assets/images/WCA_logo.png', width: 180),
           
            const SizedBox(height: 24),

            // ── Nombre de la app ─────────────────────────────────
            Text(
              'World Coffee Atlas',
              style: GoogleFonts.bonaNovaSc(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Specialty coffee around the world',
              style: GoogleFonts.lora(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: AppTheme.onSurface.withAlpha(153),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
