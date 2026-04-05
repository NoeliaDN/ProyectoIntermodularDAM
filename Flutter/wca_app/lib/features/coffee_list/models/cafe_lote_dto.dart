/// DTO con la información completa de un lote de café.
/// Muestra toda la info del café en la pantalla de cafés.
class CafeLoteDto {
  final int id;
  final String nombre;
  final String? descripcion;
  final String? notasCata;
  final double? altitudMin;
  final double? altitudMax;
  final int? regionId;
  final int? productorId;
  final int? procesoId;
  final int? variedadId;
  final int? tuesteId;
  final double? altitudMedia;
  final String? descripcionExtendida;

  CafeLoteDto({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.notasCata,
    this.altitudMin,
    this.altitudMax,
    this.regionId,
    this.productorId,
    this.procesoId,
    this.variedadId,
    this.tuesteId,
    this.altitudMedia,
    this.descripcionExtendida,
  });

  //Aseguramos las conversiones a decimales:
  factory CafeLoteDto.fromJson(Map<String, dynamic> json) {
    return CafeLoteDto(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      notasCata: json['notasCata'] as String?,
      altitudMin: (json['altitudMin'] as num?)?.toDouble(),
      altitudMax: (json['altitudMax'] as num?)?.toDouble(),
      regionId: json['regionId'] as int?,
      productorId: json['productorId'] as int?,
      procesoId: json['procesoId'] as int?,
      variedadId: json['variedadId'] as int?,
      tuesteId: json['tuesteId'] as int?,
      altitudMedia: (json['altitudMedia'] as num?)?.toDouble(),
      descripcionExtendida: json['descripcionExtendida'] as String?,
    );
  }
}
