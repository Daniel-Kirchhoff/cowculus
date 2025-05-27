import 'package:flutter_riverpod/flutter_riverpod.dart';

class BerechnungsEingabe {
  final double anzahlMilchkuehe;
  final double anzahlFaersenZurAbkalbung;
  final double anteilMaennlicherKaelberProzent;
  final double zwischenkalbezeitTage;
  final double haltedauerBullenkaelberTage;
  final double haltedauerFaersenkaelberTage;
  final double leerstandszeitTage;
  final double abkalberateProzent;
  final double fruehmortalitaetProzent;
  final double totgeburtenrateProzent;
  final double anteilZwillingstraechtigkeitenProzent;

  BerechnungsEingabe({
    this.anzahlMilchkuehe = 100,
    this.anzahlFaersenZurAbkalbung = 30,
    this.anteilMaennlicherKaelberProzent = 50,
    this.zwischenkalbezeitTage = 400,
    this.haltedauerBullenkaelberTage = 28,
    this.haltedauerFaersenkaelberTage = 14,
    this.leerstandszeitTage = 7,
    this.abkalberateProzent = 90,
    this.fruehmortalitaetProzent = 3,
    this.totgeburtenrateProzent = 4,
    this.anteilZwillingstraechtigkeitenProzent = 3,
  });

  BerechnungsEingabe copyWith({
    double? anzahlMilchkuehe,
    double? anzahlFaersenZurAbkalbung,
    double? anteilMaennlicherKaelberProzent,
    double? zwischenkalbezeitTage,
    double? haltedauerBullenkaelberTage,
    double? haltedauerFaersenkaelberTage,
    double? leerstandszeitTage,
    double? abkalberateProzent,
    double? fruehmortalitaetProzent,
    double? totgeburtenrateProzent,
    double? anteilZwillingstraechtigkeitenProzent,
  }) {
    return BerechnungsEingabe(
      anzahlMilchkuehe: anzahlMilchkuehe ?? this.anzahlMilchkuehe,
      anzahlFaersenZurAbkalbung:
          anzahlFaersenZurAbkalbung ?? this.anzahlFaersenZurAbkalbung,
      anteilMaennlicherKaelberProzent: anteilMaennlicherKaelberProzent ??
          this.anteilMaennlicherKaelberProzent,
      zwischenkalbezeitTage:
          zwischenkalbezeitTage ?? this.zwischenkalbezeitTage,
      haltedauerBullenkaelberTage:
          haltedauerBullenkaelberTage ?? this.haltedauerBullenkaelberTage,
      haltedauerFaersenkaelberTage:
          haltedauerFaersenkaelberTage ?? this.haltedauerFaersenkaelberTage,
      leerstandszeitTage: leerstandszeitTage ?? this.leerstandszeitTage,
      abkalberateProzent: abkalberateProzent ?? this.abkalberateProzent,
      fruehmortalitaetProzent:
          fruehmortalitaetProzent ?? this.fruehmortalitaetProzent,
      totgeburtenrateProzent:
          totgeburtenrateProzent ?? this.totgeburtenrateProzent,
      anteilZwillingstraechtigkeitenProzent:
          anteilZwillingstraechtigkeitenProzent ??
              this.anteilZwillingstraechtigkeitenProzent,
    );
  }
}

class BerechnungsEingabeNotifier extends StateNotifier<BerechnungsEingabe> {
  BerechnungsEingabeNotifier() : super(BerechnungsEingabe());

  void aktualisiereFeld(String feldName, double wert) {
    switch (feldName) {
      case 'anzahlMilchkuehe':
        state = state.copyWith(anzahlMilchkuehe: wert);
        break;
      case 'anzahlFaersenZurAbkalbung':
        state = state.copyWith(anzahlFaersenZurAbkalbung: wert);
        break;
      case 'anteilMaennlicherKaelberProzent':
        state = state.copyWith(anteilMaennlicherKaelberProzent: wert);
        break;
      case 'zwischenkalbezeitTage':
        state = state.copyWith(zwischenkalbezeitTage: wert);
        break;
      case 'haltedauerBullenkaelberTage':
        state = state.copyWith(haltedauerBullenkaelberTage: wert);
        break;
      case 'haltedauerFaersenkaelberTage':
        state = state.copyWith(haltedauerFaersenkaelberTage: wert);
        break;
      case 'leerstandszeitTage':
        state = state.copyWith(leerstandszeitTage: wert);
        break;
      case 'abkalberateProzent':
        state = state.copyWith(abkalberateProzent: wert);
        break;
      case 'fruehmortalitaetProzent':
        state = state.copyWith(fruehmortalitaetProzent: wert);
        break;
      case 'totgeburtenrateProzent':
        state = state.copyWith(totgeburtenrateProzent: wert);
        break;
      case 'anteilZwillingstraechtigkeitenProzent':
        state = state.copyWith(anteilZwillingstraechtigkeitenProzent: wert);
        break;
      default:
        // Optional: Fehlerlogik oder Exception
        break;
    }
  }
}

final berechnungsEingabeProvider =
    StateNotifierProvider<BerechnungsEingabeNotifier, BerechnungsEingabe>(
        (ref) {
  return BerechnungsEingabeNotifier();
});
