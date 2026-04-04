import 'package:flutter/material.dart';
import 'package:wca_app/app.dart';

/// Punto de entrada de la aplicación:
///
/// Siguiendo la convención de Flutter, main.dart solo se encarga de
/// llamar a [runApp] con el widget raíz. Toda la configuración de
/// MaterialApp se define en [WcaApp]
void main() {
  runApp(const WcaApp());
}
