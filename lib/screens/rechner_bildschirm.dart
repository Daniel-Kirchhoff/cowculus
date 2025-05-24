import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/berechnungs_eingabe.dart';
import '../models/szenario_ergebnis.dart';
import '../services/berechnungs_service.dart';
import '../widgets/ergebnis_tabelle_widget.dart';

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

  final Map<String, TextEditingController> _controllers = {};
  final List<bool> _isExpanded = [true, false, false, false];

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _berechneAlleSzenarien() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _aktuellErgebnis = _berechnungsService.berechne(_aktuelleEingabe);
        BerechnungsEingabe realistischEingabe = _aktuelleEingabe.copyWith(
          zwischenkalbezeitTage: 401,
          haltedauerBullenkaelberTage: 28,
          haltedauerFaersenkaelberTage: 14,
          leerstandszeitTage: 7,
          abkalberateProzent: 95,
          fruehmortalitaetProzent: 5,
          totgeburtenrateProzent: 3.95,
          anteilZwillingstraechtigkeitenProzent: 2.9,
        );
        _realistischErgebnis = _berechnungsService.berechne(realistischEingabe,
            reserveProzent: 25);

        double empfZKZ = _aktuelleEingabe.zwischenkalbezeitTage > 410
            ? _aktuelleEingabe.zwischenkalbezeitTage
            : 410;
        BerechnungsEingabe empfehlungEingabe = _aktuelleEingabe.copyWith(
          zwischenkalbezeitTage: empfZKZ,
          haltedauerBullenkaelberTage: 28,
          haltedauerFaersenkaelberTage: 14,
          leerstandszeitTage: 7,
        );
        _empfehlungErgebnis = _berechnungsService.berechne(empfehlungEingabe);
      });
    }
  }

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
          if (istProzent && (val < 0)) {/* Ggf. weitere Validierung */}
          if (val < 0) return 'Wert muss positiv sein';
          return null;
        },
        onSaved: (wert) {
          final val = double.tryParse(wert ?? "0") ?? 0;
          _aktuelleEingabe = _aktuelleEingabe.aktualisiereFeld(schluessel, val);
        },
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kälberplatz Kalkulator'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 24.0),
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
                    minimumSize: const Size(200, 50),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_aktuellErgebnis != null &&
                  _realistischErgebnis != null &&
                  _empfehlungErgebnis != null)
                ErgebnisTabelleWidget(
                  aktuellErgebnis: _aktuellErgebnis,
                  realistischErgebnis: _realistischErgebnis,
                  empfehlungErgebnis: _empfehlungErgebnis,
                )
            ],
          ),
        ),
      ),
    );
  }
}
