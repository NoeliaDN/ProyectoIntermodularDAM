import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:wca_app/core/constants/app_constants.dart';

/// Implementación web (Chrome/Edge) del dashboard de Power BI.
///
/// Usa un iframe HTML nativo a través de [HtmlElementView], que es la
/// forma oficial de embeber elementos HTML en Flutter Web.
class PowerBiDashboard extends StatefulWidget {
  const PowerBiDashboard({super.key});

  @override
  State<PowerBiDashboard> createState() => _PowerBiDashboardState();
}

class _PowerBiDashboardState extends State<PowerBiDashboard> {
  final String _viewType = 'power-bi-iframe';

  @override
  void initState() {
    super.initState();
    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final iframe = web.HTMLIFrameElement()
          ..src = AppConstants.powerBiGlobalUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allow = 'fullscreen';
        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
