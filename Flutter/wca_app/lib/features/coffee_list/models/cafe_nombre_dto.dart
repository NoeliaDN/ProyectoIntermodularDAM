/// DTO para el café con su id y nombre.
/// Para el selector (DropdownMenu) de la pantalla de cafés.
class CafeNombreDto {
  final int id;
  final String nombre;

  CafeNombreDto({required this.id, required this.nombre});

  /// Factoría que crea una instancia desde el JSON de la API.
  factory CafeNombreDto.fromJson(Map<String, dynamic> json) {
    return CafeNombreDto(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
    );
  }
}
