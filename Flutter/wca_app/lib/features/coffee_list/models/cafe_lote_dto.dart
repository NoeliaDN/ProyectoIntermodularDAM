/// DTO con la información completa de un lote de café.
/// Muestra toda la info del café en la pantalla de cafés.
class CafeLoteDto {
  final int id;
  final String nombre;
  final String? descripcion;
  final String? notasCata;
  final double? altitudMin;
  final double? altitudMax;
  final double? altitudMedia;
  final String? descripcionExtendida;
  // Campos resueltos desde las relaciones de la BD:
  final String? region;
  final String? pais;
  final String? productor;
  final String? proceso;
  final String? variedad;
  final String? tueste;

  CafeLoteDto({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.notasCata,
    this.altitudMin,
    this.altitudMax,
    this.altitudMedia,
    this.descripcionExtendida,
    this.region,
    this.pais,
    this.productor,
    this.proceso,
    this.variedad,
    this.tueste,
  });

  // Aseguramos las conversiones a decimales:
  factory CafeLoteDto.fromJson(Map<String, dynamic> json) {
    return CafeLoteDto(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      notasCata: json['notasCata'] as String?,
      altitudMin: (json['altitudMin'] as num?)?.toDouble(),
      altitudMax: (json['altitudMax'] as num?)?.toDouble(),
      altitudMedia: (json['altitudMedia'] as num?)?.toDouble(),
      descripcionExtendida: json['descripcionExtendida'] as String?,
      region: json['region'] as String?,
      pais: json['pais'] as String?,
      productor: json['productor'] as String?,
      proceso: json['proceso'] as String?,
      variedad: json['variedad'] as String?,
      tueste: json['tueste'] as String?,
    );
  }
}
