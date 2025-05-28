import 'package:flutter/material.dart';

// === FARBEN ===
const Color kSeedColor = Colors.green; // Bereits vorhanden für Theme
final Color kInputFillColor = Colors.grey[100]!; // Bereits vorhanden für Theme
final Color kDataTableBorderColor = Colors.grey.shade300;
final Color kTotalRowHighlightColor = Colors.green.shade50;
final Color kHintTextColor =
    Colors.grey; // Für den Hinweis-Text unter der Tabelle

// === TEXT STILE & SCHRIFTARTEN ===
const String kFontFamily = 'Inter'; // Bereits vorhanden für Theme
const double kHintTextFontSize = 12.0; // Für den Hinweis-Text unter der Tabelle

// === ABSTÄNDE & PADDING ===
const double kPaddingSmall = 8.0;
const double kPaddingMedium = 16.0;
const double kPaddingLarge = 24.0;

const EdgeInsets kButtonPadding = EdgeInsets.symmetric(
    horizontal: 20, vertical: 15); // Bereits vorhanden für Theme
const EdgeInsets kPanelPaddingBody =
    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
const EdgeInsets kScreenPaddingSmall = EdgeInsets.all(12.0);
const EdgeInsets kScreenPaddingLarge = EdgeInsets.all(24.0);

// === BORDER RADII ===
const double kAppBorderRadius = 8.0;

// === UI DIMENSIONEN / BREAKPOINTS ===
const double kSmallScreenBreakpoint = 600.0;
const double kDataTableColumnSpacing = 20.0;
const Size kElevatedButtonMinimumSize = Size(200, 50);
const double kIconSizeDefault = 24.0;

// === TEXT KONSTANTEN (UI Strings) ===
// Titel & Überschriften
const String kAppTitle = 'cowculus';
const String kAppBarTitle = 'Kälberplatz Kalkulator';
const String kMainParameterFormTitle =
    "Betriebsindividuelle Parameter eingeben:";
const String kResultsTitle = "Ergebnisse der Kälberplatzberechnung:";

// Expansion Panel Titel
const String kPanelTitleTierzahlen = "Tierzahlen";
const String kPanelTitleGeschlecht = "Geschlechterverteilung";
const String kPanelTitleZeit = "Zeitparameter";
const String kPanelTitleReproduktion = "Reproduktions- & Gesundheitsparameter";

// DataTable Spaltenüberschriften
const String kColumnHeaderParameter = 'Parameter';
const String kColumnHeaderAktuell = 'Aktuell\n(betriebsspez.)';
const String kColumnHeaderRealistisch = 'Realistisch\n(Ø NRW/DE, +25% Res.)';
const String kColumnHeaderEmpfehlung = 'Empfehlung\n(Beratung)';

// DataTable Zeilenbeschriftungen
const String kRowLabelBullenkaelber = 'Bullenkälber-Plätze';
const String kRowLabelFaersenkaelber = 'Färsenkälber-Plätze';
const String kRowLabelGesamtPlaetze = 'Gesamt-Plätze';

// Sonstige Texte
const String kButtonTextBerechnen = 'Berechnen';
const String kHinweisTextTabelle =
    "* Hinweis: 'Realistisch' beinhaltet 25% Reserve auf die Gesamtplätze. 'Bullenkälber-' und 'Färsenkälber-Plätze' werden ohne diese szenariospezifische Reserve ausgewiesen.";
const String kTextFieldHint =
    'Wert eingeben'; // Standard-Hint-Text für Textfelder

// Validierungsnachrichten
const String kValidatorMsgBitteWertEingeben = 'Bitte Wert eingeben';
const String kValidatorMsgUngueltigeZahl = 'Ungültige Zahl';
const String kValidatorMsgWertMussPositivSein = 'Wert muss positiv sein';

// Einheiten (
const String kEinheitStueck = 'Stk.';
const String kEinheitProzent = '%';
const String kEinheitTage = 'Tage';
