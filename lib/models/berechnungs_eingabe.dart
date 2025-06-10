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

  BerechnungsEingabe aktualisiereFeld(String feldName, double wert) {
    switch (feldName) {
      case 'anzahlMilchkuehe':
        return copyWith(anzahlMilchkuehe: wert);
      case 'anzahlFaersenZurAbkalbung':
        return copyWith(anzahlFaersenZurAbkalbung: wert);
      case 'anteilMaennlicherKaelberProzent':
        return copyWith(anteilMaennlicherKaelberProzent: wert);
      case 'zwischenkalbezeitTage':
        return copyWith(zwischenkalbezeitTage: wert);
      case 'haltedauerBullenkaelberTage':
        return copyWith(haltedauerBullenkaelberTage: wert);
      case 'haltedauerFaersenkaelberTage':
        return copyWith(haltedauerFaersenkaelberTage: wert);
      case 'leerstandszeitTage':
        return copyWith(leerstandszeitTage: wert);
      case 'abkalberateProzent':
        return copyWith(abkalberateProzent: wert);
      case 'fruehmortalitaetProzent':
        return copyWith(fruehmortalitaetProzent: wert);
      case 'totgeburtenrateProzent':
        return copyWith(totgeburtenrateProzent: wert);
      case 'anteilZwillingstraechtigkeitenProzent':
        return copyWith(anteilZwillingstraechtigkeitenProzent: wert);
      default:
        print(
            'Unbekanntes Feld in BerechnungsEingabe.aktualisiereFeld: $feldName');
        return this; // Gibt die aktuelle (unveränderte) Instanz zurück
    }
  }
}
