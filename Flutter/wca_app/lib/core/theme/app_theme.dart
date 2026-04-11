import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tema visual de World Coffee Atlas (Usando Material 3 (useMaterial3: true)).

/// Colores, tipografías y estilos de la app.

class AppTheme {
  AppTheme._();

  // ── Colores principales ──────────────────────────────────────────
  static const Color seedColor = Color(0xFF6F4E37); // seed color
  static const Color surface = Color(0xFFFFF8F0); // fondo
  static const Color onSurface = Color(0xFF3E2723); // texto

  // ── Tema claro ───────────────────────────────────────────────────
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // ColorScheme generado:
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      surface: surface,
    ),

    // ── Tipografía ─────────────────────────────────────────────────
    // De momento usamos la fuente por defecto de Material 3 (Roboto en Android,
    // San Francisco en iOS). Ya miraré Google Fonts más tarde con textTheme.

    // ── AppBar ─────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: GoogleFonts.lora(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
    ),

    // ── NavigationBar (barra inferior) ─────────────────────────────
    navigationBarTheme: NavigationBarThemeData(// TOD0: revisar diseño si hay tiempo
      height: 70,
      indicatorColor: const Color(0xFF6F4E37).withAlpha(30),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
  );
}
