import 'package:flutter/foundation.dart';

/// Devuelve true si la app está corriendo en un escritorio nativo
/// (Windows, Linux, macOS) — es decir, no es web ni móvil.
bool get isDesktopPlatform =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS);
