/// Implementación web real: registra el iframe en platformViewRegistry
/// y permite ocultar/mostrar su elemento HTML vía CSS.
library;
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;

class IframeRef {
  web.HTMLIFrameElement? _element;

  void _setElement(web.HTMLIFrameElement el) => _element = el;

  void setVisibility(bool visible) {
    if (_element == null) return;
    _element!.style.visibility = visible ? 'visible' : 'hidden';
    _element!.style.pointerEvents = visible ? 'auto' : 'none';
  }
}

IframeRef createAndRegisterIframe(String viewType, String url) {
  final ref = IframeRef();
  ui_web.platformViewRegistry.registerViewFactory(
    viewType,
    (int viewId) {
      final iframe = web.HTMLIFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'fullscreen';
      ref._setElement(iframe);
      return iframe;
    },
  );
  return ref;
}
