import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/szenario_ergebnis.dart';
import '../config/app_constants.dart';

class ErgebnisTabelleWidget extends StatelessWidget {
  final SzenarioErgebnis? aktuellErgebnis;
  final SzenarioErgebnis? realistischErgebnis;
  final SzenarioErgebnis? empfehlungErgebnis;

  const ErgebnisTabelleWidget({
    super.key,
    required this.aktuellErgebnis,
    required this.realistischErgebnis,
    required this.empfehlungErgebnis,
  });

  String _formatiereDouble(double? val) {
    if (val == null) return '-';
    return val.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (aktuellErgebnis == null ||
        realistischErgebnis == null ||
        empfehlungErgebnis == null) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < kDesktopBreakpoint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.resultsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: kPaddingMedium),
        if (isMobile) ...[
          _buildMobileCards(context, l10n),
        ] else ...[
          _buildDesktopTable(context, l10n),
        ],
        const SizedBox(height: kPaddingSmall + 2),
        Text(
          l10n.hinweisTextTabelle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildMobileCards(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        _buildResultCard(
          context,
          title: l10n.rowLabelBullenkaelber,
          aktuell: _formatiereDouble(aktuellErgebnis?.bullenkaelberPlaetze),
          realistisch:
              _formatiereDouble(realistischErgebnis?.bullenkaelberPlaetze),
          empfehlung:
              _formatiereDouble(empfehlungErgebnis?.bullenkaelberPlaetze),
          l10n: l10n,
        ),
        const SizedBox(height: kPaddingSmall),
        _buildResultCard(
          context,
          title: l10n.rowLabelFaersenkaelber,
          aktuell: _formatiereDouble(aktuellErgebnis?.faersenkaelberPlaetze),
          realistisch:
              _formatiereDouble(realistischErgebnis?.faersenkaelberPlaetze),
          empfehlung:
              _formatiereDouble(empfehlungErgebnis?.faersenkaelberPlaetze),
          l10n: l10n,
        ),
        const SizedBox(height: kPaddingSmall),
        _buildResultCard(
          context,
          title: l10n.rowLabelGesamtPlaetze,
          aktuell: _formatiereDouble(aktuellErgebnis?.gesamtPlaetze),
          realistisch: _formatiereDouble(realistischErgebnis?.gesamtPlaetze),
          empfehlung: _formatiereDouble(empfehlungErgebnis?.gesamtPlaetze),
          isTotal: true,
          l10n: l10n,
        ),
      ],
    );
  }

  Widget _buildResultCard(
    BuildContext context, {
    required String title,
    required String aktuell,
    required String realistisch,
    required String empfehlung,
    required AppLocalizations l10n,
    bool isTotal = false,
  }) {
    return Card(
      elevation: isTotal ? 4 : 2,
      color: isTotal && Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
          : null,
      child: Padding(
        padding: const EdgeInsets.all(kPaddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                  ),
            ),
            const SizedBox(height: kPaddingSmall),
            Row(
              children: [
                Expanded(
                  child: _buildValueColumn(
                    context,
                    label: l10n.columnHeaderAktuell,
                    value: aktuell,
                    color: Theme.of(context).colorScheme.primary,
                    isTotal: isTotal,
                  ),
                ),
                Expanded(
                  child: _buildValueColumn(
                    context,
                    label: l10n.columnHeaderRealistisch,
                    value: realistisch,
                    color: Theme.of(context).colorScheme.secondary,
                    isTotal: isTotal,
                  ),
                ),
                Expanded(
                  child: _buildValueColumn(
                    context,
                    label: l10n.columnHeaderEmpfehlung,
                    value: empfehlung,
                    color: Theme.of(context).colorScheme.tertiary,
                    isTotal: isTotal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueColumn(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
    bool isTotal = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
                color: color,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDesktopTable(BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text(l10n.columnHeaderParameter)),
          DataColumn(label: Text(l10n.columnHeaderAktuell), numeric: true),
          DataColumn(label: Text(l10n.columnHeaderRealistisch), numeric: true),
          DataColumn(label: Text(l10n.columnHeaderEmpfehlung), numeric: true),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(l10n.rowLabelBullenkaelber)),
            DataCell(
                Text(_formatiereDouble(aktuellErgebnis?.bullenkaelberPlaetze))),
            DataCell(Text(
                _formatiereDouble(realistischErgebnis?.bullenkaelberPlaetze))),
            DataCell(Text(
                _formatiereDouble(empfehlungErgebnis?.bullenkaelberPlaetze))),
          ]),
          DataRow(cells: [
            DataCell(Text(l10n.rowLabelFaersenkaelber)),
            DataCell(Text(
                _formatiereDouble(aktuellErgebnis?.faersenkaelberPlaetze))),
            DataCell(Text(
                _formatiereDouble(realistischErgebnis?.faersenkaelberPlaetze))),
            DataCell(Text(
                _formatiereDouble(empfehlungErgebnis?.faersenkaelberPlaetze))),
          ]),
          DataRow(
            color: MaterialStateProperty.resolveWith<Color?>((states) =>
                Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
            cells: [
              DataCell(Text(l10n.rowLabelGesamtPlaetze,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(_formatiereDouble(aktuellErgebnis?.gesamtPlaetze),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(
                  _formatiereDouble(realistischErgebnis?.gesamtPlaetze),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(
                  _formatiereDouble(empfehlungErgebnis?.gesamtPlaetze),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }
}
