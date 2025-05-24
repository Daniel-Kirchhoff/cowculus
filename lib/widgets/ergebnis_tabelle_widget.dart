import 'package:flutter/material.dart';
import '../models/szenario_ergebnis.dart';

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
    if (aktuellErgebnis == null ||
        realistischErgebnis == null ||
        empfehlungErgebnis == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ergebnisse der Kälberplatzberechnung:",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 20,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            columns: const [
              DataColumn(
                  label: Text('Parameter',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Aktuell\n(betriebsspez.)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  numeric: true),
              DataColumn(
                  label: Text('Realistisch\n(Ø NRW/DE, +25% Res.)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  numeric: true),
              DataColumn(
                  label: Text('Empfehlung\n(Beratung)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  numeric: true),
            ],
            rows: [
              DataRow(cells: [
                const DataCell(Text('Bullenkälber-Plätze')),
                DataCell(Text(
                    _formatiereDouble(aktuellErgebnis?.bullenkaelberPlaetze))),
                DataCell(Text(_formatiereDouble(
                    realistischErgebnis?.bullenkaelberPlaetze))),
                DataCell(Text(_formatiereDouble(
                    empfehlungErgebnis?.bullenkaelberPlaetze))),
              ]),
              DataRow(cells: [
                const DataCell(Text('Färsenkälber-Plätze')),
                DataCell(Text(
                    _formatiereDouble(aktuellErgebnis?.faersenkaelberPlaetze))),
                DataCell(Text(_formatiereDouble(
                    realistischErgebnis?.faersenkaelberPlaetze))),
                DataCell(Text(_formatiereDouble(
                    empfehlungErgebnis?.faersenkaelberPlaetze))),
              ]),
              DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    return Colors.green.shade50;
                  }),
                  cells: [
                    const DataCell(Text('Gesamt-Plätze',
                        style: TextStyle(fontWeight: FontWeight.bold))),
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
        const SizedBox(height: 10),
        const Text(
          "* Hinweis: 'Realistisch' beinhaltet 25% Reserve auf die Gesamtplätze. 'Bullenkälber-' und 'Färsenkälber-Plätze' werden ohne diese szenariospezifische Reserve ausgewiesen.",
          style: TextStyle(
              fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
        ),
      ],
    );
  }
}
