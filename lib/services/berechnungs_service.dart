import '../models/berechnungs_eingabe.dart';
import '../models/szenario_ergebnis.dart';

// Berechnungsdienst
class BerechnungsService {
  SzenarioErgebnis berechne(BerechnungsEingabe eingabe,
      {double reserveProzent = 0}) {
    // 1. Jährliche Gesamtkalbungen (JKG)
    // Berechnung der Anzahl Kalbungen von Färsen
    double jkFaersen =
        eingabe.anzahlFaersenZurAbkalbung * (eingabe.abkalberateProzent / 100.0);
    // Berechnung der Anzahl Kalbungen von Kühen unter Berücksichtigung der Zwischenkalbezeit
    double jkKuehe = (eingabe.anzahlMilchkuehe *
            (365.0 /
                (eingabe.zwischenkalbezeitTage > 0
                    ? eingabe.zwischenkalbezeitTage
                    : 365))) * // Standardwert 365 Tage, falls ZKZ 0 oder negativ
        (eingabe.abkalberateProzent / 100.0);
    double jkg = jkFaersen + jkKuehe; // Gesamte jährliche Kalbungen

    // 2. Kälber inklusive Zwillinge (KIZ)
    // Gesamtzahl Kälber einschließlich Zwillinge
    double kiz =
        jkg * (1 + (eingabe.anteilZwillingstraechtigkeitenProzent / 100.0));

    // 3. Lebendgeborene Kälber (LGK)
    // Lebendgeborene Kälber nach Abzug von Totgeburten und Frühmortalität
    double lgk = kiz *
        (1 - (eingabe.totgeburtenrateProzent / 100.0)) *
        (1 - (eingabe.fruehmortalitaetProzent / 100.0));

    // 4. Anzahl männlicher/weiblicher Kälber
    // Anzahl männlicher Kälber
    double anzahlMaennl = lgk * (eingabe.anteilMaennlicherKaelberProzent / 100.0);
    // Anzahl weiblicher Kälber
    double anzahlWeibl =
        lgk * ((100.0 - eingabe.anteilMaennlicherKaelberProzent) / 100.0);

    // 5. Plätze pro Kategorie (inklusive Leerstand)
    // Benötigte Plätze für männliche Kälber, inklusive Leerstandstage
    double plaetzeMaennl = (anzahlMaennl *
            (eingabe.haltedauerBullenkaelberTage + eingabe.leerstandszeitTage)) /
        365.0;
    // Benötigte Plätze für weibliche Kälber, inklusive Leerstandstage
    double plaetzeWeibl = (anzahlWeibl *
            (eingabe.haltedauerFaersenkaelberTage + eingabe.leerstandszeitTage)) /
        365.0;

    // Sicherstellen, dass die Platzergebnisse nicht negativ sind
    plaetzeMaennl = plaetzeMaennl < 0 ? 0 : plaetzeMaennl;
    plaetzeWeibl = plaetzeWeibl < 0 ? 0 : plaetzeWeibl;

    // 6. Gesamtplätze (GP) (ohne explizite szenariospezifische Reserve)
    // Gesamtplätze ohne szenariospezifische Reserve
    double gp = plaetzeMaennl + plaetzeWeibl;

    // 7. Gesamtplätze mit Reserve (GPR) (nur wenn reserveProzent > 0)
    // Gesamtplätze inklusive Reserve, falls zutreffend
    double gpr = gp;
    if (reserveProzent > 0) {
      gpr = gp * (1 + (reserveProzent / 100.0));
    }

    // Sicherstellen, dass Gesamtplätze mit Reserve nicht negativ sind
    gpr = gpr < 0 ? 0 : gpr;

    return SzenarioErgebnis(
      bullenkaelberPlaetze:
          plaetzeMaennl, // Bullenkälberplätze (ohne spezifische Reserve für diese Kategorie)
      faersenkaelberPlaetze:
          plaetzeWeibl, // Färsenkälberplätze (ohne spezifische Reserve für diese Kategorie)
      gesamtPlaetze: gpr, // Gesamtplätze (kann Gesamtreserve beinhalten)
    );
  }
}
