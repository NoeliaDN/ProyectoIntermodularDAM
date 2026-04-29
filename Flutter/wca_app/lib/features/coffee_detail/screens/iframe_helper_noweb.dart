/// Implementación vacía para plataformas no-web (Android, iOS, desktop).
/// El compilador la usa en lugar de iframe_helper_web.dart en esas plataformas.
class IframeRef {
  void setVisibility(bool visible) {}
}

IframeRef createAndRegisterIframe(String viewType, String url) => IframeRef();
