import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/berechnungs_eingabe.dart';
import '../models/szenario_ergebnis.dart';
import '../services/berechnungs_service.dart';
import '../widgets/ergebnis_tabelle_widget.dart';
import '../config/app_constants.dart';

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
    _controllers.forEach((key, controller) => controller.dispose());
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

  Widget _erstelleTextFeld(BuildContext context, String schluessel,
      String bezeichnung, String einheit,
      {bool istProzent = false, bool erlaubeDezimal = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPaddingSmall),
      child: TextFormField(
        controller: _controllers[schluessel],
        decoration: InputDecoration(
          labelText: bezeichnung,
          hintText: AppLocalizations.of(context)!.textFieldHint,
          suffixText: einheit,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: erlaubeDezimal),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(erlaubeDezimal ? r'^\d*\.?\d*' : r'^\d*')),
        ],
        validator: (wert) {
          if (wert == null || wert.isEmpty) {
            return AppLocalizations.of(context)!.validatorMsgBitteWertEingeben;
          }
          final val = double.tryParse(wert);
          if (val == null) {
            return AppLocalizations.of(context)!.validatorMsgUngueltigeZahl;
          }
          if (val < 0)
            return AppLocalizations.of(context)!
                .validatorMsgWertMussPositivSein;
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
      headerBuilder: (context, isExpanded) => ListTile(
        title: Text(titel,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
      ),
      body: Padding(
          padding: kPanelPaddingBody, child: Column(children: children)),
      isExpanded: isExpanded,
      canTapOnHeader: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < kSmallScreenBreakpoint;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'appLogo',
              child: Image.asset('assets/images/logo.png',
                  height: 30,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.agriculture, size: kIconSizeDefault)),
            ),
            const SizedBox(width: kPaddingSmall),
            Text(l10n.appBarTitle),
          ],
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: isSmallScreen ? kScreenPaddingSmall : kScreenPaddingLarge,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                l10n.mainParameterFormTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kPaddingMedium),
              ExpansionPanelList(
                expansionCallback: (index, isExpanded) =>
                    setState(() => _isExpanded[index] = !_isExpanded[index]),
                elevation: 2,
                expandedHeaderPadding: EdgeInsets.zero,
                children: [
                  _erstelleAusklappPanel(
                    titel: l10n.panelTitleTierzahlen,
                    isExpanded: _isExpanded[0],
                    children: [
                      _erstelleTextFeld(
                          context,
                          'anzahlMilchkuehe',
                          l10n.textFormFieldLabelAnzahlMilchkuehe,
                          l10n.einheitStueck,
                          erlaubeDezimal: false),
                      _erstelleTextFeld(
                          context,
                          'anzahlFaersenZurAbkalbung',
                          l10n.textFormFieldLabelAnzahlFaersen,
                          l10n.einheitStueck,
                          erlaubeDezimal: false),
                    ],
                  ),
                  _erstelleAusklappPanel(
                    titel: l10n.panelTitleGeschlecht,
                    isExpanded: _isExpanded[1],
                    children: [
                      _erstelleTextFeld(
                          context,
                          'anteilMaennlicherKaelberProzent',
                          l10n.textFormFieldLabelAnteilMaennlKaelber,
                          l10n.einheitProzent,
                          istProzent: true),
                    ],
                  ),
                  _erstelleAusklappPanel(
                    titel: l10n.panelTitleZeit,
                    isExpanded: _isExpanded[2],
                    children: [
                      _erstelleTextFeld(
                          context,
                          'zwischenkalbezeitTage',
                          l10n.textFormFieldLabelZwischenkalbezeit,
                          l10n.einheitTage),
                      _erstelleTextFeld(
                          context,
                          'haltedauerBullenkaelberTage',
                          l10n.textFormFieldLabelHaltedauerBullen,
                          l10n.einheitTage),
                      _erstelleTextFeld(
                          context,
                          'haltedauerFaersenkaelberTage',
                          l10n.textFormFieldLabelHaltedauerFaersen,
                          l10n.einheitTage),
                      _erstelleTextFeld(
                          context,
                          'leerstandszeitTage',
                          l10n.textFormFieldLabelLeerstandszeit,
                          l10n.einheitTage),
                    ],
                  ),
                  _erstelleAusklappPanel(
                    titel: l10n.panelTitleReproduktion,
                    isExpanded: _isExpanded[3],
                    children: [
                      _erstelleTextFeld(
                          context,
                          'abkalberateProzent',
                          l10n.textFormFieldLabelAbkalberate,
                          l10n.einheitProzent,
                          istProzent: true),
                      _erstelleTextFeld(
                          context,
                          'fruehmortalitaetProzent',
                          l10n.textFormFieldLabelFruehmortalitaet,
                          l10n.einheitProzent,
                          istProzent: true),
                      _erstelleTextFeld(
                          context,
                          'totgeburtenrateProzent',
                          l10n.textFormFieldLabelTotgeburtenrate,
                          l10n.einheitProzent,
                          istProzent: true),
                      _erstelleTextFeld(
                          context,
                          'anteilZwillingstraechtigkeitenProzent',
                          l10n.textFormFieldLabelZwillingstraechtigkeiten,
                          l10n.einheitProzent,
                          istProzent: true),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: kPaddingLarge),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.calculate, size: kIconSizeDefault),
                  onPressed: _berechneAlleSzenarien,
                  label: Text(l10n.buttonTextBerechnen),
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: kPaddingLarge),
              if (_aktuellErgebnis != null &&
                  _realistischErgebnis != null &&
                  _empfehlungErgebnis != null)
                ErgebnisTabelleWidget(
                  aktuellErgebnis: _aktuellErgebnis,
                  realistischErgebnis: _realistischErgebnis,
                  empfehlungErgebnis: _empfehlungErgebnis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
