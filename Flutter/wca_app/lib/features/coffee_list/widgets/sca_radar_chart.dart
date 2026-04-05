import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/sca_dto.dart';

/// Widget que muestra el perfil sensorial SCA en un gráfico radar (araña).
///
/// Recibe un [ScaDto] y representa 6 ejes:
/// Acidez, Cuerpo, Dulzor, Aroma, Retrogusto, Balance.
/// Arriba del gráfico se muestra la puntuación SCA media.
///
/// Usa el paquete fl_chart → RadarChart.
class ScaRadarChart extends StatelessWidget {
  final ScaDto sca;

  const ScaRadarChart({super.key, required this.sca});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Lista de atributos para los 6 ejes del radar.
    // Cada uno tiene nombre (para la etiqueta) y valor (para el punto).
    final attributes = [
      _ScaAttribute('Acidez', sca.acidez),
      _ScaAttribute('Cuerpo', sca.cuerpo),
      _ScaAttribute('Dulzor', sca.dulzor),
      _ScaAttribute('Aroma', sca.aroma),
      _ScaAttribute('Retrogusto', sca.retrogusto),
      _ScaAttribute('Balance', sca.balance),
    ];

    return Column(
      children: [
        // ── Puntuación SCA total (arriba del gráfico) ──────────────
        Text(
          sca.puntuacionSCA.toStringAsFixed(1),
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          'Puntuación SCA',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),

        // ── Gráfico radar ──────────────────────────────────────────
        SizedBox(
          height: 280,
          child: RadarChart(
            RadarChartData(
              // Datos: un solo dataset (el perfil del café)
              dataSets: [
                RadarDataSet(
                  dataEntries: attributes
                      .map((a) => RadarEntry(value: a.value))
                      .toList(),
                  borderColor: theme.colorScheme.primary,
                  fillColor: theme.colorScheme.primary.withAlpha(40),
                  borderWidth: 2.5,
                  entryRadius: 3,
                ),
              ],
              // Forma poligonal (hexagonal con 6 ejes)
              radarShape: RadarShape.polygon,
              // 4 niveles de cuadrícula (ticks)
              tickCount: 4,
              // Ocultar los números de los ticks
              ticksTextStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
              tickBorderData: BorderSide(
                color: theme.colorScheme.outlineVariant.withAlpha(80),
              ),
              // Estilo de la cuadrícula
              gridBorderData: BorderSide(
                color: theme.colorScheme.outlineVariant.withAlpha(120),
                width: 1,
              ),
              // Borde exterior
              radarBorderData: BorderSide(
                color: theme.colorScheme.outlineVariant.withAlpha(150),
                width: 1.5,
              ),
              // Estilo de las etiquetas de cada eje
              titleTextStyle: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
              // Callback que devuelve el texto de cada eje
              getTitle: (index, angle) {
                final attr = attributes[index];
                return RadarChartTitle(
                  text: '${attr.name}\n${attr.value.toStringAsFixed(1)}',
                );
              },
              titlePositionPercentageOffset: 0.22,
              // Desactivar interacción táctil por ahora
              radarTouchData: RadarTouchData(enabled: false),
            ),
          ),
        ),
      ],
    );
  }
}

/// Clase auxiliar para emparejar nombre ↔ valor de cada atributo SCA.
class _ScaAttribute {
  final String name;
  final double value;
  _ScaAttribute(this.name, this.value);
}
