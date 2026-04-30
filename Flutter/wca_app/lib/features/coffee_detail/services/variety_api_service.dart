import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_constants.dart';
import '../../../core/network/http_client_web.dart'
    if (dart.library.io) '../../../core/network/http_client_noweb_io.dart';
import '../models/variedad_nombre_dto.dart';
import '../models/variedad_detalle_dto.dart';

/// Servicio HTTP para la API de variedades.
///
/// Mismo patrón que [CoffeeApiService]: encapsula URLs y deserialización.
/// La UI solo llama a métodos con tipos Dart, sin saber nada de HTTP.
class VarietyApiService {
  /// Cliente HTTP inyectable (futuros tests?).
  final http.Client _client;

  VarietyApiService({http.Client? client}) : _client = client ?? createHttpClient();

  // ── GET /api/Variedades/nombres ──────────────────────────────────
  /// Obtiene la lista de todas las variedades (solo id + nombre).
  Future<List<VariedadNombreDto>> fetchVarietyNames() async {
    final uri = Uri.parse('${AppConstants.apiBaseUrl}/Variedades/nombres');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((item) => VariedadNombreDto.fromJson(item))
          .toList();
    } else {
      throw Exception(
          'Error ${response.statusCode} al cargar nombres de variedades');
    }
  }

  // ── GET /api/Variedades/detalles/{id} ────────────────────────────
  /// Obtiene los detalles de una variedad + sus cafés asociados.
  /// Devuelve null si la variedad no existe (404).
  Future<VariedadDetalleDto?> fetchVarietyDetails(int id) async {
    final uri =
        Uri.parse('${AppConstants.apiBaseUrl}/Variedades/detalles/$id');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return VariedadDetalleDto.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception(
          'Error ${response.statusCode} al cargar detalles de variedad');
    }
  }
}
