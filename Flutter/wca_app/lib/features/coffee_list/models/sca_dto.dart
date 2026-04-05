/// DTO con el perfil sensorial SCA de un café para el gráfico radial.

class ScaDto {
  final double acidez;
  final double cuerpo;
  final double dulzor;
  final double aroma;
  final double retrogusto;
  final double balance;
  final double puntuacionSCA;

  ScaDto({
    required this.acidez,
    required this.cuerpo,
    required this.dulzor,
    required this.aroma,
    required this.retrogusto,
    required this.balance,
    required this.puntuacionSCA,
  });

  //Convertimos a double por si acaso los JSON dan problemas:
  factory ScaDto.fromJson(Map<String, dynamic> json) {
    return ScaDto(
      acidez: (json['acidez'] as num).toDouble(),
      cuerpo: (json['cuerpo'] as num).toDouble(),
      dulzor: (json['dulzor'] as num).toDouble(),
      aroma: (json['aroma'] as num).toDouble(),
      retrogusto: (json['retrogusto'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      puntuacionSCA: (json['puntuacionSCA'] as num).toDouble(),
    );
  }
}
