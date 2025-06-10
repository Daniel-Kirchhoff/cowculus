import '../models/berechnungs_eingabe.dart';
import '../models/szenario_ergebnis.dart';

class BerechnungsService {
  SzenarioErgebnis berechne(BerechnungsEingabe eingabe,
      {double reserveProzent = 0}) {
    double jkFaersen = eingabe.anzahlFaersenZurAbkalbung *
        (eingabe.abkalberateProzent / 100.0);
    double jkKuehe = (eingabe.anzahlMilchkuehe *
            (365.0 /
                (eingabe.zwischenkalbezeitTage > 0
                    ? eingabe.zwischenkalbezeitTage
                    : 365))) *
        (eingabe.abkalberateProzent / 100.0);
    double jkg = jkFaersen + jkKuehe;

    double kiz =
        jkg * (1 + (eingabe.anteilZwillingstraechtigkeitenProzent / 100.0));

    double lgk = kiz *
        (1 - (eingabe.totgeburtenrateProzent / 100.0)) *
        (1 - (eingabe.fruehmortalitaetProzent / 100.0));

    double anzahlMaennl =
        lgk * (eingabe.anteilMaennlicherKaelberProzent / 100.0);
    double anzahlWeibl =
        lgk * ((100.0 - eingabe.anteilMaennlicherKaelberProzent) / 100.0);

    double plaetzeMaennl = (anzahlMaennl *
            (eingabe.haltedauerBullenkaelberTage +
                eingabe.leerstandszeitTage)) /
        365.0;

    double plaetzeWeibl = (anzahlWeibl *
            (eingabe.haltedauerFaersenkaelberTage +
                eingabe.leerstandszeitTage)) /
        365.0;

    plaetzeMaennl = plaetzeMaennl < 0 ? 0 : plaetzeMaennl;
    plaetzeWeibl = plaetzeWeibl < 0 ? 0 : plaetzeWeibl;

    double gp = plaetzeMaennl + plaetzeWeibl;

    double gpr = gp;
    if (reserveProzent > 0) {
      gpr = gp * (1 + (reserveProzent / 100.0));
    }

    gpr = gpr < 0 ? 0 : gpr;

    return SzenarioErgebnis(
      bullenkaelberPlaetze: plaetzeMaennl,
      faersenkaelberPlaetze: plaetzeWeibl,
      gesamtPlaetze: gpr,
    );
  }
}
