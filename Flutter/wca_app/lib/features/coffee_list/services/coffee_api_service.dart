import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_constants.dart';
import '../models/cafe_nombre_dto.dart';
import '../models/cafe_lote_dto.dart';
import '../models/sca_dto.dart';
import '../models/cafe_altitudes_dto.dart';

/// Servicio que encapsula las llamadas HTTP a la API de cafés.
///
/// Equivale a la capa de servicio/repositorio del lado cliente.
/// Centraliza todas las peticiones para que la UI no tenga que conocer
/// URLs ni lógica de deserialización.
class CoffeeApiService {
  /// Cliente HTTP inyectable (útil para tests con mocks).
  final http.Client _client;

  CoffeeApiService({http.Client? client}) : _client = client ?? http.Client();

  // ── GET /api/cafes/nombres ───────────────────────────────────────
  /// Obtiene la lista de todos los cafés (solo id + nombre) para el selector.
  Future<List<CafeNombreDto>> fetchCoffeeNames() async {
    final uri = Uri.parse('${AppConstants.apiBaseUrl}/cafes/nombres');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      // Decodificamos el JSON (viene como array []) y mapeamos cada
      // elemento a un CafeNombreDto. Igual que .Select() en LINQ.
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => CafeNombreDto.fromJson(item)).toList();
    } else {
      throw Exception('Error ${response.statusCode} al cargar nombres de cafés');
    }
  }

  // ── GET /api/cafes/info/{id} ─────────────────────────────────────
  /// Obtiene la información completa de un café por su ID.
  /// Devuelve null si el café no existe (404).
  Future<CafeLoteDto?> fetchCoffeeInfo(int id) async {
    final uri = Uri.parse('${AppConstants.apiBaseUrl}/cafes/info/$id');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return CafeLoteDto.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null; // Café no encontrado — gestionamos en la UI
    } else {
      throw Exception('Error ${response.statusCode} al cargar info del café');
    }
  }

  // ── GET /api/SCA/perfilLote/{id} ────────────────────────────────
  /// Obtiene el perfil sensorial SCA de un café por su ID.
  /// Devuelve null si no tiene perfil SCA (404).
  Future<ScaDto?> fetchCoffeeSca(int id) async {
    final uri = Uri.parse('${AppConstants.apiBaseUrl}/SCA/perfilLote/$id');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return ScaDto.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null; // Sin perfil SCA — gestionamos en la UI
    } else {
      throw Exception('Error ${response.statusCode} al cargar perfil SCA');
    }
  }

  // ── GET /api/cafes/altitud ───────────────────────────────────────
  /// Obtiene la altitud (mín, máx, media) de todos los cafés para el gráfico comparativo.
  Future<List<CafeAltitudesDto>> fetchCoffeeAltitudes() async {
    final uri = Uri.parse('${AppConstants.apiBaseUrl}/cafes/altitud');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => CafeAltitudesDto.fromJson(item)).toList();
    } else {
      throw Exception('Error ${response.statusCode} al cargar altitudes');
    }
  }
}
