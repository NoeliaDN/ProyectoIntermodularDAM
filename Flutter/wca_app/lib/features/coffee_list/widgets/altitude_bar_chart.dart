import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/cafe_altitudes_dto.dart';

/// Gráfico de barras comparativo de altitudes de cultivo para todos los cafés.
///
/// Cada barra = un café. El café seleccionado se muestra con el color primario
/// completo y siempre enseña su tooltip; el resto aparece en gris suave.
/// El eje X muestra el código ISO del país y el eje Y la altitud en metros.
class AltitudeBarChart extends StatelessWidget {
  final List<CafeAltitudesDto> altitudes;

  /// ID del café actualmente seleccionado (para resaltar su barra).
  final int? selectedId;

  const AltitudeBarChart({
    super.key,
    required this.altitudes,
    this.selectedId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Solo mostramos cafés con altitudMedia disponible
    final data = altitudes.where((a) => a.altitudMedia != null).toList();
    if (data.isEmpty) return const SizedBox.shrink();

    final maxAlt = data.map((a) => a.altitudMedia!).reduce((a, b) => a > b ? a : b);
    final maxY = (maxAlt * 1.20).ceilToDouble(); // 20 % de margen arriba para la etiqueta

    return LayoutBuilder(
      builder: (context, constraints) {
        // Mínimo 48px por barra; si hay espacio de sobra se reparte entre todas
        final minWidth = data.length * 52.0;
        final chartWidth = constraints.maxWidth > minWidth ? constraints.maxWidth : minWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: chartWidth,
            height: 220,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                minY: 0,

                // ── Tooltip al tocar ─────────────────────────────────
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => theme.colorScheme.primaryContainer,
                    getTooltipItem: (group, _, rod, _) {
                      final coffee = data[group.x];
                      return BarTooltipItem(
                        '${coffee.cafeNombre}\n${coffee.altitudMedia!.toStringAsFixed(0)} m',
                        TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      );
                    },
                  ),
                ),

                // ── Ejes ─────────────────────────────────────────────
                titlesData: FlTitlesData(
                  // Eje izquierdo: altitud en metros
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        if (value == 0 || value == maxY) return const SizedBox.shrink();
                        return Text(
                          '${value.toInt()} m',
                          style: TextStyle(
                            fontSize: 10,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ),
                  // Eje inferior: código ISO del país
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= data.length) return const SizedBox.shrink();
                        final coffee = data[index];
                        final iso = coffee.paisISO ?? '?';
                        final isSelected = coffee.cafeId == selectedId;
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            iso,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),

                // ── Cuadrícula ───────────────────────────────────────
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: theme.colorScheme.outlineVariant.withAlpha(80),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),

                // ── Barras ───────────────────────────────────────────
                barGroups: List.generate(data.length, (i) {
                  final coffee = data[i];
                  final isSelected = coffee.cafeId == selectedId;
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: coffee.altitudMedia!,
                        width: 20,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.primary.withAlpha(55),
                      ),
                    ],
                    // El café seleccionado siempre muestra su tooltip
                    showingTooltipIndicators: isSelected ? [0] : [],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
