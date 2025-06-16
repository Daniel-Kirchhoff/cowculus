import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/szenario_ergebnis.dart';

class ErgebnisChartWidget extends StatelessWidget {
  final SzenarioErgebnis aktuellErgebnis;
  final SzenarioErgebnis realistischErgebnis;
  final SzenarioErgebnis empfehlungErgebnis;

  const ErgebnisChartWidget({
    super.key,
    required this.aktuellErgebnis,
    required this.realistischErgebnis,
    required this.empfehlungErgebnis,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bullenColor = theme.colorScheme.primary;
    final faersenColor = theme.colorScheme.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.chartTitle,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _calculateMaxY(),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (BarChartGroupData group) {
                    return theme.colorScheme.surface.withOpacity(0.9);
                  },
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final szenario = switch (group.x) {
                      0 => l10n.columnHeaderAktuell.replaceAll('\n', ' '),
                      1 => l10n.columnHeaderRealistisch.replaceAll('\n', ' '),
                      _ => l10n.columnHeaderEmpfehlung.replaceAll('\n', ' '),
                    };

                    final bullenWert = rod.rodStackItems[0].toY;
                    final faersenWert =
                        rod.rodStackItems[1].toY - rod.rodStackItems[1].fromY;
                    final gesamtWert = rod.toY;

                    final tooltipTextStyle = theme.textTheme.bodyMedium!
                        .copyWith(
                            color: theme.tooltipTheme.textStyle?.color ??
                                theme.colorScheme.onSurface);

                    return BarTooltipItem(
                      '$szenario - ${l10n.rowLabelGesamtPlaetze}: ${gesamtWert.toStringAsFixed(1)}\n',
                      theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.tooltipTheme.textStyle?.color ??
                              theme.colorScheme.onSurface),
                      children: [
                        TextSpan(
                          text:
                              '${l10n.rowLabelBullenkaelber}: ${bullenWert.toStringAsFixed(1)}\n',
                          style: tooltipTextStyle,
                        ),
                        TextSpan(
                          text:
                              '${l10n.rowLabelFaersenkaelber}: ${faersenWert.toStringAsFixed(1)}',
                          style: tooltipTextStyle,
                        ),
                      ],
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      final style = theme.textTheme.bodySmall;
                      final text = switch (value.toInt()) {
                        0 => l10n.columnHeaderAktuell.split('\n').first,
                        1 => l10n.columnHeaderRealistisch.split('\n').first,
                        2 => l10n.columnHeaderEmpfehlung.split('\n').first,
                        _ => '',
                      };
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 4,
                          child: Text(text, style: style));
                    },
                    reservedSize: 30,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.left),
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                    color: theme.dividerColor.withOpacity(0.1), strokeWidth: 1),
              ),
              barGroups: [
                _createBarGroup(0, aktuellErgebnis, bullenColor, faersenColor),
                _createBarGroup(
                    1, realistischErgebnis, bullenColor, faersenColor),
                _createBarGroup(
                    2, empfehlungErgebnis, bullenColor, faersenColor),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildLegend(context, bullenColor, faersenColor),
      ],
    );
  }

  BarChartGroupData _createBarGroup(
      int x, SzenarioErgebnis ergebnis, Color bullenColor, Color faersenColor) {
    final bullenPlaetze = ergebnis.bullenkaelberPlaetze;
    final faersenPlaetze = ergebnis.faersenkaelberPlaetze;
    final totalPlaetze = ergebnis.gesamtPlaetze;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: totalPlaetze,
          width: 25,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          rodStackItems: [
            BarChartRodStackItem(0, bullenPlaetze, bullenColor),
            BarChartRodStackItem(bullenPlaetze, totalPlaetze, faersenColor),
          ],
        ),
      ],
    );
  }

  Widget _buildLegend(
      BuildContext context, Color bullenColor, Color faersenColor) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(context, bullenColor, l10n.rowLabelBullenkaelber),
        const SizedBox(width: 16),
        _legendItem(context, faersenColor, l10n.rowLabelFaersenkaelber),
      ],
    );
  }

  Widget _legendItem(BuildContext context, Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  double _calculateMaxY() {
    final maxGesamt = [
      aktuellErgebnis.gesamtPlaetze,
      realistischErgebnis.gesamtPlaetze,
      empfehlungErgebnis.gesamtPlaetze
    ].reduce((a, b) => a > b ? a : b);

    if (maxGesamt == 0) return 10;

    return (maxGesamt * 1.2 / 10).ceil() * 10.0;
  }
}
