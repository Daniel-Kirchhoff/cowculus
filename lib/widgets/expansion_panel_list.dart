import 'package:cowculus/models/berechnungs_eingabe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_constants.dart';

class CustomExpansionPanelList extends ConsumerWidget {
  const CustomExpansionPanelList({
    super.key,
    required this.isExpanded,
    required this.expansionCallback,
    required this.controllerMap,
    required this.focusNode,
  });

  final List<bool> isExpanded;
  final void Function(int index, bool isExpanded) expansionCallback;
  final Map<String, TextEditingController> controllerMap;
  final FocusNode focusNode;

  static const _felder = [
    // Gruppiert nach Panels
    {
      'titel': "Tierzahlen",
      'felder': [
        ['anzahlMilchkuehe', 'Anzahl Milchkühe', 'Stk.', false, false],
        [
          'anzahlFaersenZurAbkalbung',
          'Anzahl Färsen zur Abkalbung (pro Jahr)',
          'Stk.',
          false,
          false
        ],
      ],
    },
    {
      'titel': "Geschlechterverteilung",
      'felder': [
        [
          'anteilMaennlicherKaelberProzent',
          'Anteil männlicher Kälber',
          '%',
          true,
          true
        ],
      ],
    },
    {
      'titel': "Zeitparameter",
      'felder': [
        ['zwischenkalbezeitTage', 'Zwischenkalbezeit', 'Tage', false, true],
        [
          'haltedauerBullenkaelberTage',
          'Haltedauer Bullenkälber (Einzelhaltung)',
          'Tage',
          false,
          true
        ],
        [
          'haltedauerFaersenkaelberTage',
          'Haltedauer Färsenkälber (Einzelhaltung)',
          'Tage',
          false,
          true
        ],
        [
          'leerstandszeitTage',
          'Leerstandszeit zwischen Belegungen',
          'Tage',
          false,
          true
        ],
      ],
    },
    {
      'titel': "Reproduktions- & Gesundheitsparameter",
      'felder': [
        ['abkalberateProzent', 'Abkalberate', '%', true, true],
        [
          'fruehmortalitaetProzent',
          'Frühmortalität (Kälber bis 28 Tage)',
          '%',
          true,
          true
        ],
        [
          'totgeburtenrateProzent',
          'Totgeburtenrate (optional)',
          '%',
          true,
          true
        ],
        [
          'anteilZwillingstraechtigkeitenProzent',
          'Anteil Zwillingsträchtigkeiten',
          '%',
          true,
          true
        ],
      ],
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final berechnungEingabeMethods =
        ref.read(berechnungsEingabeProvider.notifier);

    return ExpansionPanelList(
      expansionCallback: expansionCallback,
      elevation: 2,
      expandedHeaderPadding: EdgeInsets.zero,
      children: List.generate(_felder.length, (index) {
        final panel = _felder[index];
        final feldListe = panel['felder'] as List<List<dynamic>>;
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) => ListTile(
            title: Text(panel['titel'] as String,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPaddingRechner_Bildschirm,
                vertical: kVerticalPaddingRechner_Bildschirm),
            child: Column(
              children: feldListe
                  .map((f) => _buildTextField(
                        berechnungEingabeMethods,
                        focusNode: focusNode,
                        context: context,
                        key: f[0] as String,
                        label: f[1] as String,
                        suffix: f[2] as String,
                        isPercent: f[3] as bool,
                        allowDecimal: f[4] as bool,
                      ))
                  .toList(),
            ),
          ),
          isExpanded: isExpanded[index],
          canTapOnHeader: true,
        );
      }),
    );
  }

  Widget _buildTextField(
    BerechnungsEingabeNotifier berechnungEingabeMethods, {
    required BuildContext context,
    required String key,
    required String label,
    required String suffix,
    required bool isPercent,
    required bool allowDecimal,
    required FocusNode focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kVerticalPaddingRechner_Bildschirm),
      child: TextFormField(
        controller: controllerMap[key],
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Wert eingeben',
          suffixText: suffix,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(allowDecimal ? r'^\d*\.?\d*' : r'^\d+'),
          ),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) return 'Bitte Wert eingeben';
          final val = double.tryParse(value);
          if (val == null) return 'Ungültige Zahl';
          if (isPercent && (val < 0 || val > 100)) {
            return 'Wert muss zwischen 0 und 100 sein';
          }
          if (val < 0) return 'Wert muss positiv sein';
          return null;
        },
        onSaved: (value) {
          final val = double.tryParse(value ?? "0") ?? 0;
          berechnungEingabeMethods.aktualisiereFeld(key, val);
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          focusNode.requestFocus();
        },
      ),
    );
  }
}
