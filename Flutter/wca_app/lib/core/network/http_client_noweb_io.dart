import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http;

/// Cliente HTTP para Android (dart:io disponible).
///
/// ⚠️ SOLO PARA DESARROLLO: el callback ignora el certificado TLS
/// del servidor local de ASP.NET Core (autofirmado).
http.Client createHttpClient() {
  final ioClient = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  return http.IOClient(ioClient);
}
