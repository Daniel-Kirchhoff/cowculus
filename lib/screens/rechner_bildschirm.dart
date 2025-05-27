import 'package:cowculus/config/app_constants.dart';
import 'package:cowculus/widgets/expansion_panel_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/berechnungs_eingabe.dart';
import '../models/szenario_ergebnis.dart';
import '../services/berechnungs_service.dart';
import '../widgets/ergebnis_tabelle_widget.dart';

class RechnerBildschirm extends ConsumerStatefulWidget {
  const RechnerBildschirm({super.key});

  @override
  ConsumerState<RechnerBildschirm> createState() => _RechnerBildschirmState();
}

class _RechnerBildschirmState extends ConsumerState<RechnerBildschirm> {
  final _formKey = GlobalKey<FormState>();
  final BerechnungsService _berechnungsService = BerechnungsService();

  SzenarioErgebnis? _aktuellErgebnis;
  SzenarioErgebnis? _realistischErgebnis;
  SzenarioErgebnis? _empfehlungErgebnis;

  final Map<String, TextEditingController> _controllers = {};
  final List<bool> _isExpanded = [true, false, false, false];
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final _berechnungEingabeState = ref.read(berechnungsEingabeProvider);
    final felder = {
      'anzahlMilchkuehe': _berechnungEingabeState.anzahlMilchkuehe,
      'anzahlFaersenZurAbkalbung':
          _berechnungEingabeState.anzahlFaersenZurAbkalbung,
      'anteilMaennlicherKaelberProzent':
          _berechnungEingabeState.anteilMaennlicherKaelberProzent,
      'zwischenkalbezeitTage': _berechnungEingabeState.zwischenkalbezeitTage,
      'haltedauerBullenkaelberTage':
          _berechnungEingabeState.haltedauerBullenkaelberTage,
      'haltedauerFaersenkaelberTage':
          _berechnungEingabeState.haltedauerFaersenkaelberTage,
      'leerstandszeitTage': _berechnungEingabeState.leerstandszeitTage,
      'abkalberateProzent': _berechnungEingabeState.abkalberateProzent,
      'fruehmortalitaetProzent':
          _berechnungEingabeState.fruehmortalitaetProzent,
      'totgeburtenrateProzent': _berechnungEingabeState.totgeburtenrateProzent,
      'anteilZwillingstraechtigkeitenProzent':
          _berechnungEingabeState.anteilZwillingstraechtigkeitenProzent,
    };

    felder.forEach((key, value) {
      _controllers[key] = TextEditingController(text: value.toString());
    });
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _berechneAlleSzenarien(BerechnungsEingabe berechnungEingabeState) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final berechnungEingabeState = ref.read(berechnungsEingabeProvider);

      setState(() {
        _aktuellErgebnis = _berechnungsService.berechne(berechnungEingabeState);
        BerechnungsEingabe realistischEingabe = berechnungEingabeState.copyWith(
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

        double empfZKZ = berechnungEingabeState.zwischenkalbezeitTage > 410
            ? berechnungEingabeState.zwischenkalbezeitTage
            : 410;
        BerechnungsEingabe empfehlungEingabe = berechnungEingabeState.copyWith(
          zwischenkalbezeitTage: empfZKZ,
          haltedauerBullenkaelberTage: 28,
          haltedauerFaersenkaelberTage: 14,
          leerstandszeitTage: 7,
        );
        _empfehlungErgebnis = _berechnungsService.berechne(empfehlungEingabe);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < kThresholdScreenWidthToMobile;
    final berechnungEingabeState = ref.watch(berechnungsEingabeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kälberplatz Kalkulator'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: isSmallScreen ? false : true,
        trackVisibility: isSmallScreen ? false : true,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(
              isSmallScreen ? kAllPaddingIsMobile : kAllPaddingIsNotMobile),
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
                const SizedBox(height: kBoxHeightRechner_Bildschirm),
                CustomExpansionPanelList(
                  isExpanded: _isExpanded,
                  controllerMap: _controllers,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _isExpanded[index] = !_isExpanded[index];
                    });
                  },
                  focusNode: _focusNode,
                ),
                const SizedBox(height: kBoxHeightRechner_Bildschirm * 2),
                Center(
                  child: KeyboardListener(
                    autofocus: true,
                    focusNode: _focusNode,
                    onKeyEvent: (event) {
                      if (event is KeyUpEvent &&
                          event.logicalKey == LogicalKeyboardKey.enter) {
                        _berechneAlleSzenarien(berechnungEingabeState);
                      }
                    },
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.calculate),
                      onPressed: () =>
                          _berechneAlleSzenarien(berechnungEingabeState),
                      label: const Text('Berechnen'),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                        minimumSize: const Size(200, 50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kBoxHeightRechner_Bildschirm * 2),
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
      ),
    );
  }
}
