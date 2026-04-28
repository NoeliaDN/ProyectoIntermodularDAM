/// DTO id + nombre de la variedad.
///
/// Para rellenar el selector (DropdownMenu) sin traer
/// toda la información de la variedad.
///
class VariedadNombreDto {
  final int variedadId;
  final String variedadNombre;

  VariedadNombreDto({
    required this.variedadId,
    required this.variedadNombre,
  });

  /// Deserializamos el JSON del endpoint GET /api/Variedades/nombres:

  factory VariedadNombreDto.fromJson(Map<String, dynamic> json) {
    return VariedadNombreDto(
      variedadId: json['variedadId'] as int,
      variedadNombre: json['variedadNombre'] as String,
    );
  }
}
