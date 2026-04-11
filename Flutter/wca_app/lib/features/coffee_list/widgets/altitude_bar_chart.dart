import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/cafe_altitudes_dto.dart';

/// Gráfico de barras comparativo de altitudes de cultivo para todos los cafés.
///
/// Cada barra = un café. El café seleccionado se muestra con el color primario
/// con un topTitle fijo arriba; el resto aparece en un color más light.
/// El eje X muestra el código ISO del país y el eje Y la altitud media en metros sobre el nivel del mar.
class AltitudeBarChart extends StatefulWidget {
  final List<CafeAltitudesDto> altitudes;

  /// ID del café actualmente seleccionado (para resaltar su barra).
  final int? selectedId;

  const AltitudeBarChart({
    super.key,
    required this.altitudes,
    this.selectedId,
  });

  @override
  State<AltitudeBarChart> createState() => _AltitudeBarChartState();
}

class _AltitudeBarChartState extends State<AltitudeBarChart> {
  final ScrollController _scrollController = ScrollController();  // Necesario para que el Scrollbar funcione en web con el ratón


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Solo mostramos los cafés con altitudMedia (aunque todos deberían tener siempre):
    final data = widget.altitudes.where((a) => a.altitudMedia != null).toList();
    if (data.isEmpty) return const SizedBox.shrink();

    final maxAlt = data.map((a) => a.altitudMedia!).reduce((a, b) => a > b ? a : b);
    
    final maxY = (maxAlt * 1.55).ceilToDouble(); // aumento hasta 55 % la altura, espacio suficiente para el tooltip de la barra más alta ( si no se corta)

    return LayoutBuilder(
      builder: (context, constraints) {
        final minWidth = data.length * 52.0; // Mínimo 52px por barra, si la pantalla es ancha se reparte el espacio
        final chartWidth = constraints.maxWidth > minWidth ? constraints.maxWidth : minWidth;

        return Scrollbar(
          controller: _scrollController,
          // thumbVisibility: siempre visible → el usuario sabe que puede scrollear
          thumbVisibility: chartWidth > constraints.maxWidth,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: chartWidth,
              height: 240,
              child: BarChart(
                BarChartData(
                  maxY: maxY,
                  minY: 0,

                  // ── Tooltip al tocar ─────────────────────────────────
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => theme.colorScheme.primaryContainer,
                      getTooltipItem: (group, _, rod, __) {
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
                    // Eje Y (altitud en metros):
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
                    // Eje X (código ISO del país):
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= data.length) return const SizedBox.shrink();
                          final coffee = data[index];
                          final iso = coffee.paisISO ?? '?';
                          final isSelected = coffee.cafeId == widget.selectedId;
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
                    // Tooltip constante del café seleccionado implementado como
                    // widget Flutter (topTitles), no como canvas, así siempre se renderiza encima del canvas del
                    // gráfico y no se tapan los hover entre ellos.
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= data.length) return const SizedBox.shrink();
                          final coffee = data[index];
                          if (coffee.cafeId != widget.selectedId) return const SizedBox.shrink();
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${coffee.altitudMedia!.toStringAsFixed(0)} m',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                            ),
                          ));
                        },
                      ),
                    ),
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
                    final isSelected = coffee.cafeId == widget.selectedId;
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
                      
                      showingTooltipIndicators: const [],
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

