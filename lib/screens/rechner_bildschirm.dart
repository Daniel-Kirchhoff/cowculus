import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import '../models/berechnungs_eingabe.dart';
import '../models/szenario_ergebnis.dart';
import '../services/berechnungs_service.dart';

class RechnerBildschirm extends StatefulWidget {
  const RechnerBildschirm({super.key});

  @override
  State<RechnerBildschirm> createState() => _RechnerBildschirmState();
}

class _RechnerBildschirmState extends State<RechnerBildschirm> {
  final _formKey = GlobalKey<FormState>();
  BerechnungsEingabe _aktuelleEingabe = BerechnungsEingabe();
  final BerechnungsService _berechnungsService = BerechnungsService();

  SzenarioErgebnis? _aktuellErgebnis;
  SzenarioErgebnis? _realistischErgebnis;
  SzenarioErgebnis? _empfehlungErgebnis;

  // Text-Bearbeitungs-Controller für Formularfelder
  final Map<String, TextEditingController> _controllers = {};

  // Zustände der Ausklapp-Panels, um zu steuern, welches Panel geöffnet ist
  final List<bool> _isExpanded = [
    true, // Tierzahlen
    false, // Geschlecht
    false, // Zeit
    false // Reproduktion
  ];

  @override
  void initState() {
    super.initState();
    // Initialisiere Controller mit Standardwerten von der initialen _aktuelleEingabe
    _controllers['anzahlMilchkuehe'] = TextEditingController(
        text: _aktuelleEingabe.anzahlMilchkuehe.toString());
    _controllers['anzahlFaersenZurAbkalbung'] = TextEditingController(
        text: _aktuelleEingabe.anzahlFaersenZurAbkalbung.toString());
    _controllers['anteilMaennlicherKaelberProzent'] = TextEditingController(
        text: _aktuelleEingabe.anteilMaennlicherKaelberProzent.toString());
    _controllers['zwischenkalbezeitTage'] = TextEditingController(
        text: _aktuelleEingabe.zwischenkalbezeitTage.toString());
    _controllers['haltedauerBullenkaelberTage'] = TextEditingController(
        text: _aktuelleEingabe.haltedauerBullenkaelberTage.toString());
    _controllers['haltedauerFaersenkaelberTage'] = TextEditingController(
        text: _aktuelleEingabe.haltedauerFaersenkaelberTage.toString());
    _controllers['leerstandszeitTage'] = TextEditingController(
        text: _aktuelleEingabe.leerstandszeitTage.toString());
    _controllers['abkalberateProzent'] = TextEditingController(
        text: _aktuelleEingabe.abkalberateProzent.toString());
    _controllers['fruehmortalitaetProzent'] = TextEditingController(
        text: _aktuelleEingabe.fruehmortalitaetProzent.toString());
    _controllers['totgeburtenrateProzent'] = TextEditingController(
        text: _aktuelleEingabe.totgeburtenrateProzent.toString());
    _controllers['anteilZwillingstraechtigkeitenProzent'] =
        TextEditingController(
            text: _aktuelleEingabe.anteilZwillingstraechtigkeitenProzent
                .toString());
  }

  // Methode zum Auslösen der Berechnungen für alle Szenarien
  void _berechneAlleSzenarien() {
    // Formular vor dem Fortfahren validieren
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // Ruft onSaved für alle Felder auf, _aktuelleEingabe wird aktualisiert

      // "Aktuell" (betriebsspezifisches) Szenario berechnen
      setState(() {
        // UI wird basierend auf der (möglicherweise neuen) _aktuelleEingabe aktualisiert
        _aktuellErgebnis = _berechnungsService.berechne(_aktuelleEingabe);

        // Eingabe für "Realistisch" (realistischer Durchschnitt) Szenario vorbereiten
        BerechnungsEingabe realistischEingabe = _aktuelleEingabe.copyWith(
          // Betriebsspezifische Eingaben (vom Benutzer): anzahlMilchkuehe, anzahlFaersenZurAbkalbung, anteilMaennlicherKaelberProzent
          // Feste Durchschnittswerte für "Realistisch" Szenario:
          zwischenkalbezeitTage: 401,
          haltedauerBullenkaelberTage: 28,
          haltedauerFaersenkaelberTage: 14,
          leerstandszeitTage: 7,
          abkalberateProzent: 95,
          fruehmortalitaetProzent: 5,
          totgeburtenrateProzent:
              3.95, // Durchschnitt (5% für Färsen, 2.9% für Kühe)
          anteilZwillingstraechtigkeitenProzent: 2.9,
        );
        // "Realistisch" Szenario mit 25% Reserve berechnen
        _realistischErgebnis = _berechnungsService.berechne(realistischEingabe,
            reserveProzent: 25);

        // Eingabe für "Empfehlung" (Beratung) Szenario vorbereiten
        // ZKZ des Betriebs verwenden, falls länger als 410, ansonsten 410 verwenden
        double empfZKZ = _aktuelleEingabe.zwischenkalbezeitTage > 410
            ? _aktuelleEingabe.zwischenkalbezeitTage
            : 410;

        BerechnungsEingabe empfehlungEingabe = _aktuelleEingabe.copyWith(
          // Betriebsspezifische Eingaben (vom Benutzer): anzahlMilchkuehe, anzahlFaersenZurAbkalbung, anteilMaennlicherKaelberProzent,
          // abkalberateProzent, fruehmortalitaetProzent, totgeburtenrateProzent, anteilZwillingstraechtigkeitenProzent
          // Angepasste Werte für "Empfehlung" Szenario:
          zwischenkalbezeitTage: empfZKZ,
          haltedauerBullenkaelberTage:
              28, // Gesetzlich vorgeschriebenes Minimum
          haltedauerFaersenkaelberTage: 14, // Empfohlen
          leerstandszeitTage: 7, // Empfohlen
        );
        // "Empfehlung" Szenario berechnen (keine explizite Reserve für dieses Szenario hinzugefügt)
        _empfehlungErgebnis = _berechnungsService.berechne(empfehlungEingabe);
      });
    }
  }

  // Hilfs-Widget zum Erstellen eines TextFormField
  Widget _erstelleTextFeld(
      String schluessel, String bezeichnung, String einheit,
      {bool istProzent = false, bool erlaubeDezimal = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _controllers[schluessel],
        decoration: InputDecoration(
          labelText: bezeichnung,
          hintText: 'Wert eingeben',
          suffixText: einheit,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: erlaubeDezimal),
        inputFormatters: [
          // Nur Zahlen und optional einen Dezimalpunkt zulassen
          FilteringTextInputFormatter.allow(
              RegExp(erlaubeDezimal ? r'^\d*\.?\d*' : r'^\d*')),
        ],
        validator: (wert) {
          if (wert == null || wert.isEmpty) {
            return 'Bitte Wert eingeben';
          }
          final val = double.tryParse(wert);
          if (val == null) {
            return 'Ungültige Zahl';
          }
          // Grundlegende Validierung für Prozentsätze
          if (istProzent && (val < 0 /*|| val > 100*/)) {
            // Vorübergehend >100 für Raten wie Abkalberate erlauben
          }
          if (val < 0) return 'Wert muss positiv sein';
          return null;
        },
        onSaved: (wert) {
          // Den geparsten Double-Wert holen
          final val = double.tryParse(wert ?? "0") ?? 0;
          // _aktuelleEingabe mit der neuen Instanz überschreiben,
          // die von der aktualisiereFeld-Methode zurückgegeben wird.
          _aktuelleEingabe = _aktuelleEingabe.aktualisiereFeld(schluessel, val);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Grundlegende responsive Layout-Anpassungen basierend auf der Bildschirmbreite
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('cowculus'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen
            ? 12.0
            : 24.0), // Padding für kleine Bildschirme anpassen
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Betriebsindividuelle Parameter eingeben:",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Eingabeabschnitte mit ExpansionPanelList
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded[index] = !_isExpanded[index];
                  });
                },
                elevation: 2,
                expandedHeaderPadding: EdgeInsets.zero,
                children: [
                  _erstelleAusklappPanel(
                    titel: "Tierzahlen",
                    isExpanded: _isExpanded[0],
                    children: [
                      _erstelleTextFeld(
                          'anzahlMilchkuehe', 'Anzahl Milchkühe', 'Stk.',
                          erlaubeDezimal: false),
                      _erstelleTextFeld('anzahlFaersenZurAbkalbung',
                          'Anzahl Färsen zur Abkalbung (pro Jahr)', 'Stk.',
                          erlaubeDezimal: false),
                    ],
                  ),
                  _erstelleAusklappPanel(
                    titel: "Geschlechterverteilung",
                    isExpanded: _isExpanded[1],
                    children: [
                      _erstelleTextFeld('anteilMaennlicherKaelberProzent',
                          'Anteil männlicher Kälber', '%',
                          istProzent: true),
                    ],
                  ),
                  _erstelleAusklappPanel(
                    titel: "Zeitparameter",
                    isExpanded: _isExpanded[2],
                    children: [
                      _erstelleTextFeld(
                          'zwischenkalbezeitTage', 'Zwischenkalbezeit', 'Tage'),
                      _erstelleTextFeld('haltedauerBullenkaelberTage',
                          'Haltedauer Bullenkälber (Einzelhaltung)', 'Tage'),
                      _erstelleTextFeld('haltedauerFaersenkaelberTage',
                          'Haltedauer Färsenkälber (Einzelhaltung)', 'Tage'),
                      _erstelleTextFeld('leerstandszeitTage',
                          'Leerstandszeit zwischen Belegungen', 'Tage'),
                    ],
                  ),
                  _erstelleAusklappPanel(
                    titel: "Reproduktions- & Gesundheitsparameter",
                    isExpanded: _isExpanded[3],
                    children: [
                      _erstelleTextFeld(
                          'abkalberateProzent', 'Abkalberate', '%',
                          istProzent: true),
                      _erstelleTextFeld('fruehmortalitaetProzent',
                          'Frühmortalität (Kälber bis 28 Tage)', '%',
                          istProzent: true),
                      _erstelleTextFeld('totgeburtenrateProzent',
                          'Totgeburtenrate (optional)', '%',
                          istProzent: true),
                      _erstelleTextFeld('anteilZwillingstraechtigkeitenProzent',
                          'Anteil Zwillingsträchtigkeiten', '%',
                          istProzent: true),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.calculate),
                  onPressed: _berechneAlleSzenarien,
                  label: const Text('Berechnen'),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    minimumSize: const Size(200,
                        50), // Sicherstellen, dass der Button eine angemessene Größe hat
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Ergebnistabelle anzeigen, wenn Berechnungen durchgeführt wurden
              if (_aktuellErgebnis != null &&
                  _realistischErgebnis != null &&
                  _empfehlungErgebnis != null)
                _erstelleErgebnisTabelle(),
            ],
          ),
        ),
      ),
    );
  }

  // Hilfsmethode zum Erstellen eines ExpansionPanel
  ExpansionPanel _erstelleAusklappPanel(
      {required String titel,
      required bool isExpanded,
      required List<Widget> children}) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(titel,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
        );
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(children: children),
      ),
      isExpanded: isExpanded,
      canTapOnHeader: true,
    );
  }

  // Hilfsmethode zum Erstellen der DataTable für Ergebnisse
  Widget _erstelleErgebnisTabelle() {
    // Formatiert einen Double-Wert auf eine Dezimalstelle für die Anzeige
    String formatiereDouble(double? val) {
      if (val == null) return '-';
      // Auf 1 Dezimalstelle runden und als String mit einer Nachkommastelle formatieren
      return val.toStringAsFixed(1);
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
          // Tabelle auf kleinen Bildschirmen horizontal scrollbar machen
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
                    formatiereDouble(_aktuellErgebnis?.bullenkaelberPlaetze))),
                DataCell(Text(formatiereDouble(
                    _realistischErgebnis?.bullenkaelberPlaetze))),
                DataCell(Text(formatiereDouble(
                    _empfehlungErgebnis?.bullenkaelberPlaetze))),
              ]),
              DataRow(cells: [
                const DataCell(Text('Färsenkälber-Plätze')),
                DataCell(Text(
                    formatiereDouble(_aktuellErgebnis?.faersenkaelberPlaetze))),
                DataCell(Text(formatiereDouble(
                    _realistischErgebnis?.faersenkaelberPlaetze))),
                DataCell(Text(formatiereDouble(
                    _empfehlungErgebnis?.faersenkaelberPlaetze))),
              ]),
              DataRow(
                  // Gesamtsummenzeile hervorheben
                  color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    return Colors.green.shade50;
                  }),
                  cells: [
                    const DataCell(Text('Gesamt-Plätze',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(
                        formatiereDouble(_aktuellErgebnis?.gesamtPlaetze),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(
                        formatiereDouble(_realistischErgebnis?.gesamtPlaetze),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(
                        formatiereDouble(_empfehlungErgebnis?.gesamtPlaetze),
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
