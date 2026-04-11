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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    // Ejecutamos tras el primer frame para tener acceso a context.
    WidgetsBinding.instance.addPostFrameCallback((_) => _initAndNavigate());
  }

  Future<void> _initAndNavigate() async {
    // Precarga la imagen y da tiempo a las fuentes de Google Fonts a cachearse.
    await Future.wait([
      precacheImage(
        const AssetImage('assets/images/WCA_logo.png'),
        context,
      ),
      Future.delayed(const Duration(milliseconds: 80)),
    ]);

    if (!mounted) return;

    // Inicia el fade-in (900 ms).
    _fadeController.forward();

    // Espera el tiempo restante hasta llegar a ~6 s totales y navega.
    await Future.delayed(const Duration(milliseconds: 4950));

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MainScaffold()),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
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
      ),
    );
  }
}
