import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wca_app/core/constants/app_constants.dart';

/// Implementación móvil (Android/iOS) del dashboard de Power BI.
///
/// Usa [WebViewWidget] del paquete `webview_flutter`.
class PowerBiDashboard extends StatefulWidget {
  const PowerBiDashboard({super.key});

  @override
  State<PowerBiDashboard> createState() => _PowerBiDashboardState();
}

class _PowerBiDashboardState extends State<PowerBiDashboard> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(AppConstants.powerBiMobileUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
