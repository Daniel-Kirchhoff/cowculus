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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.resultsTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: kPaddingMedium),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: kDataTableColumnSpacing,
            decoration: BoxDecoration(
              border: Border.all(color: kDataTableBorderColor),
              borderRadius: BorderRadius.circular(kAppBorderRadius),
            ),
            columns: [
              DataColumn(
                  label: Text(l10n.columnHeaderParameter,
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text(l10n.columnHeaderAktuell,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  numeric: true),
              DataColumn(
                  label: Text(l10n.columnHeaderRealistisch,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  numeric: true),
              DataColumn(
                  label: Text(l10n.columnHeaderEmpfehlung,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  numeric: true),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(l10n.rowLabelBullenkaelber)),
                DataCell(Text(
                    _formatiereDouble(aktuellErgebnis?.bullenkaelberPlaetze))),
                DataCell(Text(_formatiereDouble(
                    realistischErgebnis?.bullenkaelberPlaetze))),
                DataCell(Text(_formatiereDouble(
                    empfehlungErgebnis?.bullenkaelberPlaetze))),
              ]),
              DataRow(cells: [
                DataCell(Text(l10n.rowLabelFaersenkaelber)),
                DataCell(Text(
                    _formatiereDouble(aktuellErgebnis?.faersenkaelberPlaetze))),
                DataCell(Text(_formatiereDouble(
                    realistischErgebnis?.faersenkaelberPlaetze))),
                DataCell(Text(_formatiereDouble(
                    empfehlungErgebnis?.faersenkaelberPlaetze))),
              ]),
              DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>(
                      (states) => kTotalRowHighlightColor),
                  cells: [
                    DataCell(Text(l10n.rowLabelGesamtPlaetze,
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(
                        _formatiereDouble(aktuellErgebnis?.gesamtPlaetze),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(
                        _formatiereDouble(realistischErgebnis?.gesamtPlaetze),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(
                        _formatiereDouble(empfehlungErgebnis?.gesamtPlaetze),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                  ]),
            ],
          ),
        ),
        const SizedBox(height: kPaddingSmall + 2),
        Text(
          l10n.hinweisTextTabelle,
          style: TextStyle(
              fontSize: kHintTextFontSize,
              fontStyle: FontStyle.italic,
              color: kHintTextColor),
        ),
      ],
    );
  }
}
