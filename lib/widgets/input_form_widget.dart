import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/rechner_providers.dart';
import '../config/app_constants.dart';

class InputFormWidget extends ConsumerStatefulWidget {
  final VoidCallback onSubmit;
  
  const InputFormWidget({
    super.key,
    required this.onSubmit,
  });

  @override
  ConsumerState<InputFormWidget> createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends ConsumerState<InputFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final List<bool> _isExpanded = [true, false, false, false];
  late final FocusNode _buttonFocusNode;

  @override
  void initState() {
    super.initState();
    _buttonFocusNode = FocusNode();
    final eingabe = ref.read(eingabeProvider);
    _controllers['anzahlMilchkuehe'] =
        TextEditingController(text: eingabe.anzahlMilchkuehe.toString());
    _controllers['anzahlFaersenZurAbkalbung'] = TextEditingController(
        text: eingabe.anzahlFaersenZurAbkalbung.toString());
    _controllers['anteilMaennlicherKaelberProzent'] = TextEditingController(
        text: eingabe.anteilMaennlicherKaelberProzent.toString());
    _controllers['zwischenkalbezeitTage'] =
        TextEditingController(text: eingabe.zwischenkalbezeitTage.toString());
    _controllers['haltedauerBullenkaelberTage'] = TextEditingController(
        text: eingabe.haltedauerBullenkaelberTage.toString());
    _controllers['haltedauerFaersenkaelberTage'] = TextEditingController(
        text: eingabe.haltedauerFaersenkaelberTage.toString());
    _controllers['leerstandszeitTage'] =
        TextEditingController(text: eingabe.leerstandszeitTage.toString());
    _controllers['abkalberateProzent'] =
        TextEditingController(text: eingabe.abkalberateProzent.toString());
    _controllers['fruehmortalitaetProzent'] =
        TextEditingController(text: eingabe.fruehmortalitaetProzent.toString());
    _controllers['totgeburtenrateProzent'] =
        TextEditingController(text: eingabe.totgeburtenrateProzent.toString());
    _controllers['anteilZwillingstraechtigkeitenProzent'] =
        TextEditingController(
            text: eingabe.anteilZwillingstraechtigkeitenProzent.toString());
  }

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _submitAndCalculate() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      final aktuelleEingabe = ref.read(eingabeProvider);
      final berechnungsService = ref.read(berechnungsServiceProvider);
      final aktuellErgebnis = berechnungsService.berechne(aktuelleEingabe);
      final realistischEingabe = aktuelleEingabe.copyWith(
        zwischenkalbezeitTage: 401,
        haltedauerBullenkaelberTage: 28,
        haltedauerFaersenkaelberTage: 14,
        leerstandszeitTage: 7,
        abkalberateProzent: 95,
        fruehmortalitaetProzent: 5,
        totgeburtenrateProzent: 3.95,
        anteilZwillingstraechtigkeitenProzent: 2.9,
      );
      final realistischErgebnis =
          berechnungsService.berechne(realistischEingabe, reserveProzent: 25);
      final empfZKZ = aktuelleEingabe.zwischenkalbezeitTage > 410.0
          ? aktuelleEingabe.zwischenkalbezeitTage
          : 410.0;
      final empfehlungEingabe = aktuelleEingabe.copyWith(
        zwischenkalbezeitTage: empfZKZ,
        haltedauerBullenkaelberTage: 28,
        haltedauerFaersenkaelberTage: 14,
        leerstandszeitTage: 7,
      );
      final empfehlungErgebnis = berechnungsService.berechne(empfehlungEingabe);
      final ergebnisse = (
        aktuell: aktuellErgebnis,
        realistisch: realistischErgebnis,
        empfehlung: empfehlungErgebnis,
      );
      ref.read(ergebnisProvider.notifier).state = ergebnisse;
      
      widget.onSubmit();
    }
  }

  Widget _erstelleTextFeld(BuildContext context, String schluessel,
      String bezeichnung, String tooltipText, String einheit,
      {bool istProzent = false,
      bool erlaubeDezimal = true,
      bool istHeader = false}) {
    if (istHeader) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: kPaddingSmall),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Text(
            bezeichnung,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPaddingSmall),
      child: TextFormField(
        controller: _controllers[schluessel],
        decoration: InputDecoration(
          labelText: bezeichnung,
          hintText: AppLocalizations.of(context)!.textFieldHint,
          suffixText: einheit,
          suffixIcon: Tooltip(
            message: tooltipText,
            padding: const EdgeInsets.all(kPaddingSmall),
            textStyle:
                TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(kAppBorderRadius / 2),
            ),
            child: Icon(
              Icons.info_outline,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: erlaubeDezimal),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(erlaubeDezimal ? r'^\d*\.?\d*' : r'^\d*'))
        ],
        onFieldSubmitted: (_) => _submitAndCalculate(),
        validator: (wert) {
          final l10n = AppLocalizations.of(context)!;
          if (wert == null || wert.isEmpty)
            return l10n.validatorMsgBitteWertEingeben;
          if (double.tryParse(wert) == null)
            return l10n.validatorMsgUngueltigeZahl;
          if (double.parse(wert) < 0)
            return l10n.validatorMsgWertMussPositivSein;
          return null;
        },
        onSaved: (wert) {
          final val = double.tryParse(wert ?? '0') ?? 0;
          ref.read(eingabeProvider.notifier).updateFeld(schluessel, val);
        },
      ),
    );
  }

  ExpansionPanel _erstelleAusklappPanel({
    required String titel,
    required bool isExpanded,
    required List<Widget> children,
  }) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(
        title: Text(titel, style: Theme.of(context).textTheme.titleMedium),
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
    
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.mainParameterFormTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: kPaddingMedium),
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded[index] = !_isExpanded[index];
              });
            },
            elevation: 1,
            children: [
              _erstelleAusklappPanel(
                titel: l10n.panelTitleTierzahlen,
                isExpanded: _isExpanded[0],
                children: [
                  _erstelleTextFeld(
                    context,
                    'anzahlMilchkuehe',
                    l10n.textFormFieldLabelAnzahlMilchkuehe,
                    l10n.tooltipAnzahlMilchkuehe,
                    l10n.einheitStueck,
                    erlaubeDezimal: false,
                  ),
                  _erstelleTextFeld(
                    context,
                    'anzahlFaersenZurAbkalbung',
                    l10n.textFormFieldLabelAnzahlFaersen,
                    l10n.tooltipAnzahlFaersen,
                    l10n.einheitStueck,
                    erlaubeDezimal: false,
                  ),
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
                    l10n.tooltipAnteilMaennlKaelber,
                    l10n.einheitProzent,
                    istProzent: true,
                  ),
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
                    l10n.tooltipZwischenkalbezeit,
                    l10n.einheitTage,
                  ),
                  _erstelleTextFeld(
                    context,
                    'haltedauerBullenkaelberTage',
                    l10n.textFormFieldLabelHaltedauerBullen,
                    l10n.tooltipHaltedauerBullen,
                    l10n.einheitTage,
                  ),
                  _erstelleTextFeld(
                    context,
                    'haltedauerFaersenkaelberTage',
                    l10n.textFormFieldLabelHaltedauerFaersen,
                    l10n.tooltipHaltedauerFaersen,
                    l10n.einheitTage,
                  ),
                  _erstelleTextFeld(
                    context,
                    'leerstandszeitTage',
                    l10n.textFormFieldLabelLeerstandszeit,
                    l10n.tooltipLeerstandszeit,
                    l10n.einheitTage,
                  ),
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
                    l10n.tooltipAbkalberate,
                    l10n.einheitProzent,
                    istProzent: true,
                  ),
                  _erstelleTextFeld(
                    context,
                    'fruehmortalitaetProzent',
                    l10n.textFormFieldLabelFruehmortalitaet,
                    l10n.tooltipFruehmortalitaet,
                    l10n.einheitProzent,
                    istProzent: true,
                  ),
                  _erstelleTextFeld(
                    context,
                    'totgeburtenrateProzent',
                    l10n.textFormFieldLabelTotgeburtenrate,
                    l10n.tooltipTotgeburtenrate,
                    l10n.einheitProzent,
                    istProzent: true,
                  ),
                  _erstelleTextFeld(
                    context,
                    'anteilZwillingstraechtigkeitenProzent',
                    l10n.textFormFieldLabelZwillingstraechtigkeiten,
                    l10n.tooltipZwillingstraechtigkeiten,
                    l10n.einheitProzent,
                    istProzent: true,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: kPaddingLarge),
          Center(
            child: KeyboardListener(
              focusNode: _buttonFocusNode,
              onKeyEvent: (KeyEvent event) {
                if (event is KeyDownEvent &&
                    (event.logicalKey == LogicalKeyboardKey.enter ||
                        event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
                  _submitAndCalculate();
                }
              },
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calculate, size: kIconSizeDefault),
                onPressed: _submitAndCalculate,
                label: Text(l10n.buttonTextBerechnen),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
