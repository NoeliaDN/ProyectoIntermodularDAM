/// DTO con los datos de altitud de todos los cafés para el gráfico comparativo.
/// Incluye el código ISO del país como etiqueta del eje X.
class CafeAltitudesDto {
  final int cafeId;
  final String cafeNombre;
  final double? altitudMin;
  final double? altitudMax;
  final double? altitudMedia;
  final String? paisISO;

  CafeAltitudesDto({
    required this.cafeId,
    required this.cafeNombre,
    this.altitudMin,
    this.altitudMax,
    this.altitudMedia,
    this.paisISO,
  });

  factory CafeAltitudesDto.fromJson(Map<String, dynamic> json) {
    return CafeAltitudesDto(
      cafeId: json['cafeId'] as int,
      cafeNombre: json['cafeNombre'] as String,
      altitudMin: (json['altitudMin'] as num?)?.toDouble(),
      altitudMax: (json['altitudMax'] as num?)?.toDouble(),
      altitudMedia: (json['altitudMedia'] as num?)?.toDouble(),
      paisISO: json['paisISO'] as String?,
    );
  }
}
