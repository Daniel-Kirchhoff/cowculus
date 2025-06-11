import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'cowculus';

  @override
  String get appBarTitle => 'AppBarTitle Placeholder';

  @override
  String get calculatorTitle => 'Kälberplatz Kalkulator';

  @override
  String get welcomeHeadline => 'Willkommen bei cowculus!';

  @override
  String get welcomeSubtitle => 'Diese App basiert auf der Masterarbeit von Maren Thiemann und setzt ihr Kalkulationstool zur Bedarfsbestimmung von Einzelplätzen für Kälber in der Praxis um. Entwickelt für Milchviehhalter und Berater, unterstützt sie Sie dabei, den individuellen Platzbedarf zu berechnen und Optimierungspotenziale im Management der Kälberhaltung zu erkennen.';

  @override
  String get splashExplanation => 'Diese App hilft Ihnen bei der Ermittlung des Bedarfs an Kälberplätzen für Ihren landwirtschaftlichen Betrieb.';

  @override
  String get masterThesisCredit => 'Entwickelt im Rahmen der Masterarbeit von M. Thiemann, FH Südwestfalen.';

  @override
  String get skipSplashCheckboxLabel => 'Startseite beim nächsten Mal überspringen';

  @override
  String get startCalculatorButton => 'Rechner starten';

  @override
  String get mainParameterFormTitle => 'Betriebsindividuelle Parameter eingeben:';

  @override
  String get resultsTitle => 'Ergebnisse der Kälberplatzberechnung:';

  @override
  String get panelTitleTierzahlen => 'Tierzahlen';

  @override
  String get panelTitleGeschlecht => 'Geschlechterverteilung';

  @override
  String get panelTitleZeit => 'Zeitparameter';

  @override
  String get panelTitleReproduktion => 'Reproduktions- & Gesundheitsparameter';

  @override
  String get columnHeaderParameter => 'Parameter';

  @override
  String get columnHeaderAktuell => 'Aktuell\n(betriebsspez.)';

  @override
  String get columnHeaderRealistisch => 'Realistisch\n(Ø NRW/DE, +25% Res.)';

  @override
  String get columnHeaderEmpfehlung => 'Empfehlung\n(Beratung)';

  @override
  String get rowLabelBullenkaelber => 'Bullenkälber-Plätze';

  @override
  String get rowLabelFaersenkaelber => 'Färsenkälber-Plätze';

  @override
  String get rowLabelGesamtPlaetze => 'Gesamt-Plätze';

  @override
  String get buttonTextBerechnen => 'Berechnen';

  @override
  String get hinweisTextTabelle => '* Hinweis: \'Realistisch\' beinhaltet 25% Reserve auf die Gesamtplätze. \'Bullenkälber-\' und \'Färsenkälber-Plätze\' werden ohne diese szenariospezifische Reserve ausgewiesen.';

  @override
  String get textFieldHint => 'Wert eingeben';

  @override
  String get validatorMsgBitteWertEingeben => 'Bitte Wert eingeben';

  @override
  String get validatorMsgUngueltigeZahl => 'Ungültige Zahl';

  @override
  String get validatorMsgWertMussPositivSein => 'Wert muss positiv sein';

  @override
  String get einheitStueck => 'Stk.';

  @override
  String get einheitProzent => '%';

  @override
  String get einheitTage => 'Tage';

  @override
  String get textFormFieldLabelAnzahlMilchkuehe => 'Anzahl Milchkühe';

  @override
  String get textFormFieldLabelAnzahlFaersen => 'Anzahl Färsen zur Abkalbung (pro Jahr)';

  @override
  String get textFormFieldLabelAnteilMaennlKaelber => 'Anteil männlicher Kälber';

  @override
  String get textFormFieldLabelZwischenkalbezeit => 'Zwischenkalbezeit';

  @override
  String get textFormFieldLabelHaltedauerBullen => 'Haltedauer Bullenkälber (Einzelhaltung)';

  @override
  String get textFormFieldLabelHaltedauerFaersen => 'Haltedauer Färsenkälber (Einzelhaltung)';

  @override
  String get textFormFieldLabelLeerstandszeit => 'Leerstandszeit zwischen Belegungen';

  @override
  String get textFormFieldLabelAbkalberate => 'Abkalberate';

  @override
  String get textFormFieldLabelFruehmortalitaet => 'Frühmortalität (Kälber bis 28 Tage)';

  @override
  String get textFormFieldLabelTotgeburtenrate => 'Totgeburtenrate (optional)';

  @override
  String get textFormFieldLabelZwillingstraechtigkeiten => 'Anteil Zwillingsträchtigkeiten';
}
