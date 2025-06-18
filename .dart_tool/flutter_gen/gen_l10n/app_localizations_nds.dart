// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Low German Low Saxon (`nds`).
class AppLocalizationsNds extends AppLocalizations {
  AppLocalizationsNds([String locale = 'nds']) : super(locale);

  @override
  String get systemLanguage => 'Systemspraak';

  @override
  String get appTitle => 'cowculus';

  @override
  String get appBarTitle => 'AppBarTitel Platzholler';

  @override
  String get calculatorTitle => 'Kälverplatz-Reekner';

  @override
  String get welcomeHeadline => 'Willkamen bi cowculus!';

  @override
  String get welcomeSubtitle =>
      'Disse App geiht op de Masterarbeit vun Maren Thiemann torügg un maakt ehr Reeknertool för de Bestimmung vun enkelte Kälverplaatzen för de Praxis bruukbor. Se is maakt för Melkveehöllers un Beraters un hölpt bi’t Reeknen vun de Platzbedarv un dat Opdecken vun Mööglichkeiten to Verbesserungen in de Kälverholling.';

  @override
  String get splashExplanation =>
      'Disse App hölpt Di bi’t Utfinnen, wo vele Kälverplaatzen Du för Dien Hof brauchst.';

  @override
  String get masterThesisCredit =>
      'Utwickelt as Deel vun de Masterarbeit vun M. Thiemann, FH Süüdwestfalen.';

  @override
  String get skipSplashCheckboxLabel =>
      'Startschirm tom nächsten Maal övergahn';

  @override
  String get startCalculatorButton => 'Reekner starten';

  @override
  String get mainParameterFormTitle => 'Giff Dien hofeegen Parameters in:';

  @override
  String get resultsTitle => 'Resultaten vun de Kälverplatz-Reeknung:';

  @override
  String get panelTitleTierzahlen => 'Diertallen';

  @override
  String get panelTitleGeschlecht => 'Köönt-Verdeelen';

  @override
  String get panelTitleZeit => 'Tied-Parameters';

  @override
  String get panelTitleReproduktion => 'Reproduktion & Gesondheit';

  @override
  String get columnHeaderParameter => 'Parameter';

  @override
  String get columnHeaderAktuell => 'Aktuell\n(hofeegen)';

  @override
  String get columnHeaderRealistisch => 'Realistisch\n(Ø NRW/D, +25% Reserve)';

  @override
  String get columnHeaderEmpfehlung => 'Raat\n(Verlööf)';

  @override
  String get rowLabelBullenkaelber => 'Bullen-Kälverplaatzen';

  @override
  String get rowLabelFaersenkaelber => 'Färsen-Kälverplaatzen';

  @override
  String get rowLabelGesamtPlaetze => 'Totel Plaatzen';

  @override
  String get buttonTextBerechnen => 'Utreken';

  @override
  String get hinweisTextTabelle =>
      '* Hinweis: \'Realistisch\' enthält 25% Reserve op de Totelplaatzen. \'Bullen-\' un \'Färsen-Kälverplaatzen\' sünd ahn disse szenariospezifische Reserve.';

  @override
  String get textFieldHint => 'Weert ingeven';

  @override
  String get validatorMsgBitteWertEingeben => 'Giff bitte en Weert in';

  @override
  String get validatorMsgUngueltigeZahl => 'Keen gellen Tall';

  @override
  String get validatorMsgWertMussPositivSein => 'Weert mutt positiv wesen';

  @override
  String get einheitStueck => 'Stk.';

  @override
  String get einheitProzent => '%';

  @override
  String get einheitTage => 'Daag';

  @override
  String get textFormFieldLabelAnzahlMilchkuehe => 'Tall Melkkühe';

  @override
  String get textFormFieldLabelAnzahlFaersen =>
      'Tall Färsen, de afkalen (per Johr)';

  @override
  String get textFormFieldLabelAnteilMaennlKaelber => 'Andeel männliche Kälver';

  @override
  String get textFormFieldLabelZwischenkalbezeit => 'Tied twischen Afkalen';

  @override
  String get textFormFieldLabelHaltedauerBullen =>
      'Hollduur Bullenkälver (Enkelholling)';

  @override
  String get textFormFieldLabelHaltedauerFaersen =>
      'Hollduur Färsenkälver (Enkelholling)';

  @override
  String get textFormFieldLabelLeerstandszeit =>
      'Leegstandstied twischen Belegungen';

  @override
  String get textFormFieldLabelAbkalberate => 'Afkalrate';

  @override
  String get textFormFieldLabelFruehmortalitaet =>
      'Frühstorv (% Kälver binnen 28 Daag)';

  @override
  String get textFormFieldLabelTotgeburtenrate => 'Doodborenrate (wahlwies)';

  @override
  String get textFormFieldLabelZwillingstraechtigkeiten =>
      'Andeel Twegen-Drächtigkeiten';

  @override
  String get tooltipAnzahlMilchkuehe =>
      'Giff de dörsnittliche Tall Melkkühe in Dien Herd in.';

  @override
  String get tooltipAnzahlFaersen =>
      'Tall Färsen, de binnen’t Johr för\'t eerst mol afkalen schullt.';

  @override
  String get tooltipAnteilMaennlKaelber =>
      'Wat för en Deel vun de Kälver sünd männlich? Normal üm 50%.';

  @override
  String get tooltipZwischenkalbezeit =>
      'Tall Daag twischen twee Kalvings vun een Ko.';

  @override
  String get tooltipHaltedauerBullen =>
      'Wie lange blifft en Bullenkalb in’t Iglu oder Kälverbox?';

  @override
  String get tooltipHaltedauerFaersen =>
      'Wie lange blifft en Färsenkalb in’t Iglu oder Kälverbox?';

  @override
  String get tooltipLeerstandszeit =>
      'Wieviele Daag steiht de Box oder’t Iglu leer, bevör dat wedder bruukt warrt?';

  @override
  String get tooltipAbkalberate =>
      'Wieviele Kühe/Färsen kalvt wirklich per Johr af?';

  @override
  String get tooltipFruehmortalitaet =>
      'Wieviele Kälver storvt in de eerste 28 Daag?';

  @override
  String get tooltipTotgeburtenrate =>
      'Doodboren oder binnen 24 Stünnen storven. Wahlwies.';

  @override
  String get tooltipZwillingstraechtigkeiten =>
      'Wieviel Twegenbörs sünd dor bi de Drächtigkeiten?';

  @override
  String get resultsPlaceholder =>
      'Giff Dien Daten in un klick op \'Utreken\', denn kummt hier de Resultaten.';

  @override
  String get chartTitle => 'Grafische Ümfaten';

  @override
  String get buttonTextPdfExport => 'PDF exporteren';

  @override
  String get pdfErrorNoResults =>
      'Keen Resultaten to exporteren. Bitte eerst utreken.';

  @override
  String get pdfGenerating => 'PDF warrt maakt...';

  @override
  String get pdfErrorGeneral => 'Fehler bi’t Maak’n vun’t PDF';

  @override
  String get pdfGeneratedOn => 'Maak op’n:';

  @override
  String get helpButtonTooltip => 'Hülp & Info';

  @override
  String get helpDialogTitle => 'App-Info';

  @override
  String get helpDialogAboutTitle => 'Över cowculus';

  @override
  String get helpDialogAboutText =>
      'Disse App geiht torügg op de Masterarbeit vun Maren Thiemann un maakt ehr Reeknertool för de Bedarvsbestimmung vun enkelte Kälverplaatzen bruukbor för de Praxis. Se hölpt Melkveehöllers un Beraters bi’t Reeknen un Updecken vun Optimierungspotenzialen.';

  @override
  String get helpDialogUsageTitle => 'Anwennen';

  @override
  String get helpDialogUsageText =>
      '1. Giff Dien Parameters in\n2. Klick op \'Utreken\'\n3. Kiek de Resultaten in de Tabel un Diagramm an\n4. Bruuk de dree Szenarios för de Planung';

  @override
  String get helpDialogScenariosTitle => 'Szenarios';

  @override
  String get helpDialogScenariosText =>
      '• Aktuell: Diene Angaben\n• Realistisch: Ø NRW/Deutschland mit 25% Reserve\n• Raat: Optimierte Raten för Beraters';

  @override
  String get helpDialogCloseButton => 'Tomaaken';

  @override
  String get programmerInfo =>
      'Maak vun Daniel Kirchhoff • App-Entwicklung un Technik • Kontakt: info@danielkirchhoff.de';

  @override
  String get appVersion => 'Version 1.0.0';
}
