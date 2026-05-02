/// DTO con los detalles completos de una variedad + sus cafés asociados.
///
/// Viene del endpoint GET /api/Variedades/detalles/{id}.
/// Una variedad puede tener 0, 1 o varios cafés asociados, por eso
/// [cafes] es una lista y puede estar vacía --> controlado con código en la UI.
/// 
class VariedadDetalleDto {
  final int variedadId;
  final String variedadNombre;
  final String? especie;
  final String? variedadDescripcion;
  final List<VariedadCafeDto> cafes;

  VariedadDetalleDto({
    required this.variedadId,
    required this.variedadNombre,
    this.especie,
    this.variedadDescripcion,
    required this.cafes,
  });

  /// Deserializamos el JSON del endpoint:
  factory VariedadDetalleDto.fromJson(Map<String, dynamic> json) {
    return VariedadDetalleDto(
      variedadId: json['variedadId'] as int,
      variedadNombre: json['variedadNombre'] as String,
      especie: json['especie'] as String?,
      variedadDescripcion: json['variedadDescripcion'] as String?,
      cafes: (json['cafes'] as List<dynamic>?)
              ?.map((c) => VariedadCafeDto.fromJson(c))
              .toList() ??
          [],
    );
  }
}

/// DTO de cada café asociado a la variedad.
///
/// Cada variedad puede cultivarse en varios cafés/fincas, y cada uno
/// tiene su propio productor, región y país.
/// 
class VariedadCafeDto {
  final int cafeId;
  final String cafeNombre;
  final String? productor;
  final String? productorDescripcion;
  final String? tipoProductor;
  final String? region;
  final String? pais;

  VariedadCafeDto({
    required this.cafeId,
    required this.cafeNombre,
    this.productor,
    this.productorDescripcion,
    this.tipoProductor,
    this.region,
    this.pais,
  });

  factory VariedadCafeDto.fromJson(Map<String, dynamic> json) {
    return VariedadCafeDto(
      cafeId: json['cafeId'] as int,
      cafeNombre: json['cafeNombre'] as String,
      productor: json['productor'] as String?,
      productorDescripcion: json['productorDescripcion'] as String?,
      tipoProductor: json['tipoProductor'] as String?,
      region: json['region'] as String?,
      pais: json['pais'] as String?,
    );
  }
}
