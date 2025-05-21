// Datenmodell für Berechnungseingaben
class BerechnungsEingabe {
  double anzahlMilchkuehe;
  double anzahlFaersenZurAbkalbung;
  double anteilMaennlicherKaelberProzent;
  double zwischenkalbezeitTage;
  double haltedauerBullenkaelberTage;
  double haltedauerFaersenkaelberTage;
  double leerstandszeitTage;
  double abkalberateProzent;
  double fruehmortalitaetProzent;
  double totgeburtenrateProzent;
  double anteilZwillingstraechtigkeitenProzent;

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

  // Hilfsmethode, um eine Kopie mit spezifischen Änderungen für Szenarien zu erstellen
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
