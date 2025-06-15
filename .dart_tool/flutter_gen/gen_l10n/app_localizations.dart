import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @systemLanguage.
  ///
  /// In de, this message translates to:
  /// **'Systemsprache'**
  String get systemLanguage;

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'cowculus'**
  String get appTitle;

  /// No description provided for @appBarTitle.
  ///
  /// In de, this message translates to:
  /// **'AppBarTitle Placeholder'**
  String get appBarTitle;

  /// No description provided for @calculatorTitle.
  ///
  /// In de, this message translates to:
  /// **'Kälberplatz Kalkulator'**
  String get calculatorTitle;

  /// No description provided for @welcomeHeadline.
  ///
  /// In de, this message translates to:
  /// **'Willkommen bei cowculus!'**
  String get welcomeHeadline;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Diese App basiert auf der Masterarbeit von Maren Thiemann und setzt ihr Kalkulationstool zur Bedarfsbestimmung von Einzelplätzen für Kälber in der Praxis um. Entwickelt für Milchviehhalter und Berater, unterstützt sie Sie dabei, den individuellen Platzbedarf zu berechnen und Optimierungspotenziale im Management der Kälberhaltung zu erkennen.'**
  String get welcomeSubtitle;

  /// No description provided for @splashExplanation.
  ///
  /// In de, this message translates to:
  /// **'Diese App hilft Ihnen bei der Ermittlung des Bedarfs an Kälberplätzen für Ihren landwirtschaftlichen Betrieb.'**
  String get splashExplanation;

  /// No description provided for @masterThesisCredit.
  ///
  /// In de, this message translates to:
  /// **'Entwickelt im Rahmen der Masterarbeit von M. Thiemann, FH Südwestfalen.'**
  String get masterThesisCredit;

  /// No description provided for @skipSplashCheckboxLabel.
  ///
  /// In de, this message translates to:
  /// **'Startseite beim nächsten Mal überspringen'**
  String get skipSplashCheckboxLabel;

  /// No description provided for @startCalculatorButton.
  ///
  /// In de, this message translates to:
  /// **'Rechner starten'**
  String get startCalculatorButton;

  /// No description provided for @mainParameterFormTitle.
  ///
  /// In de, this message translates to:
  /// **'Betriebsindividuelle Parameter eingeben:'**
  String get mainParameterFormTitle;

  /// No description provided for @resultsTitle.
  ///
  /// In de, this message translates to:
  /// **'Ergebnisse der Kälberplatzberechnung:'**
  String get resultsTitle;

  /// No description provided for @panelTitleTierzahlen.
  ///
  /// In de, this message translates to:
  /// **'Tierzahlen'**
  String get panelTitleTierzahlen;

  /// No description provided for @panelTitleGeschlecht.
  ///
  /// In de, this message translates to:
  /// **'Geschlechterverteilung'**
  String get panelTitleGeschlecht;

  /// No description provided for @panelTitleZeit.
  ///
  /// In de, this message translates to:
  /// **'Zeitparameter'**
  String get panelTitleZeit;

  /// No description provided for @panelTitleReproduktion.
  ///
  /// In de, this message translates to:
  /// **'Reproduktions- & Gesundheitsparameter'**
  String get panelTitleReproduktion;

  /// No description provided for @columnHeaderParameter.
  ///
  /// In de, this message translates to:
  /// **'Parameter'**
  String get columnHeaderParameter;

  /// No description provided for @columnHeaderAktuell.
  ///
  /// In de, this message translates to:
  /// **'Aktuell\n(betriebsspez.)'**
  String get columnHeaderAktuell;

  /// No description provided for @columnHeaderRealistisch.
  ///
  /// In de, this message translates to:
  /// **'Realistisch\n(Ø NRW/DE, +25% Res.)'**
  String get columnHeaderRealistisch;

  /// No description provided for @columnHeaderEmpfehlung.
  ///
  /// In de, this message translates to:
  /// **'Empfehlung\n(Beratung)'**
  String get columnHeaderEmpfehlung;

  /// No description provided for @rowLabelBullenkaelber.
  ///
  /// In de, this message translates to:
  /// **'Bullenkälber-Plätze'**
  String get rowLabelBullenkaelber;

  /// No description provided for @rowLabelFaersenkaelber.
  ///
  /// In de, this message translates to:
  /// **'Färsenkälber-Plätze'**
  String get rowLabelFaersenkaelber;

  /// No description provided for @rowLabelGesamtPlaetze.
  ///
  /// In de, this message translates to:
  /// **'Gesamt-Plätze'**
  String get rowLabelGesamtPlaetze;

  /// No description provided for @buttonTextBerechnen.
  ///
  /// In de, this message translates to:
  /// **'Berechnen'**
  String get buttonTextBerechnen;

  /// No description provided for @hinweisTextTabelle.
  ///
  /// In de, this message translates to:
  /// **'* Hinweis: \'Realistisch\' beinhaltet 25% Reserve auf die Gesamtplätze. \'Bullenkälber-\' und \'Färsenkälber-Plätze\' werden ohne diese szenariospezifische Reserve ausgewiesen.'**
  String get hinweisTextTabelle;

  /// No description provided for @textFieldHint.
  ///
  /// In de, this message translates to:
  /// **'Wert eingeben'**
  String get textFieldHint;

  /// No description provided for @validatorMsgBitteWertEingeben.
  ///
  /// In de, this message translates to:
  /// **'Bitte Wert eingeben'**
  String get validatorMsgBitteWertEingeben;

  /// No description provided for @validatorMsgUngueltigeZahl.
  ///
  /// In de, this message translates to:
  /// **'Ungültige Zahl'**
  String get validatorMsgUngueltigeZahl;

  /// No description provided for @validatorMsgWertMussPositivSein.
  ///
  /// In de, this message translates to:
  /// **'Wert muss positiv sein'**
  String get validatorMsgWertMussPositivSein;

  /// No description provided for @einheitStueck.
  ///
  /// In de, this message translates to:
  /// **'Stk.'**
  String get einheitStueck;

  /// No description provided for @einheitProzent.
  ///
  /// In de, this message translates to:
  /// **'%'**
  String get einheitProzent;

  /// No description provided for @einheitTage.
  ///
  /// In de, this message translates to:
  /// **'Tage'**
  String get einheitTage;

  /// No description provided for @textFormFieldLabelAnzahlMilchkuehe.
  ///
  /// In de, this message translates to:
  /// **'Anzahl Milchkühe'**
  String get textFormFieldLabelAnzahlMilchkuehe;

  /// No description provided for @textFormFieldLabelAnzahlFaersen.
  ///
  /// In de, this message translates to:
  /// **'Anzahl Färsen zur Abkalbung (pro Jahr)'**
  String get textFormFieldLabelAnzahlFaersen;

  /// No description provided for @textFormFieldLabelAnteilMaennlKaelber.
  ///
  /// In de, this message translates to:
  /// **'Anteil männlicher Kälber'**
  String get textFormFieldLabelAnteilMaennlKaelber;

  /// No description provided for @textFormFieldLabelZwischenkalbezeit.
  ///
  /// In de, this message translates to:
  /// **'Zwischenkalbezeit'**
  String get textFormFieldLabelZwischenkalbezeit;

  /// No description provided for @textFormFieldLabelHaltedauerBullen.
  ///
  /// In de, this message translates to:
  /// **'Haltedauer Bullenkälber (Einzelhaltung)'**
  String get textFormFieldLabelHaltedauerBullen;

  /// No description provided for @textFormFieldLabelHaltedauerFaersen.
  ///
  /// In de, this message translates to:
  /// **'Haltedauer Färsenkälber (Einzelhaltung)'**
  String get textFormFieldLabelHaltedauerFaersen;

  /// No description provided for @textFormFieldLabelLeerstandszeit.
  ///
  /// In de, this message translates to:
  /// **'Leerstandszeit zwischen Belegungen'**
  String get textFormFieldLabelLeerstandszeit;

  /// No description provided for @textFormFieldLabelAbkalberate.
  ///
  /// In de, this message translates to:
  /// **'Abkalberate'**
  String get textFormFieldLabelAbkalberate;

  /// No description provided for @textFormFieldLabelFruehmortalitaet.
  ///
  /// In de, this message translates to:
  /// **'Frühmortalität (Kälber bis 28 Tage)'**
  String get textFormFieldLabelFruehmortalitaet;

  /// No description provided for @textFormFieldLabelTotgeburtenrate.
  ///
  /// In de, this message translates to:
  /// **'Totgeburtenrate (optional)'**
  String get textFormFieldLabelTotgeburtenrate;

  /// No description provided for @textFormFieldLabelZwillingstraechtigkeiten.
  ///
  /// In de, this message translates to:
  /// **'Anteil Zwillingsträchtigkeiten'**
  String get textFormFieldLabelZwillingstraechtigkeiten;

  /// No description provided for @tooltipAnzahlMilchkuehe.
  ///
  /// In de, this message translates to:
  /// **'Geben Sie die durchschnittliche Anzahl der laktierenden Kühe in Ihrer Herde an.'**
  String get tooltipAnzahlMilchkuehe;

  /// No description provided for @tooltipAnzahlFaersen.
  ///
  /// In de, this message translates to:
  /// **'Geben Sie die Anzahl der Färsen an, die voraussichtlich im kommenden Jahr zum ersten Mal kalben werden.'**
  String get tooltipAnzahlFaersen;

  /// No description provided for @tooltipAnteilMaennlKaelber.
  ///
  /// In de, this message translates to:
  /// **'Der prozentuale Anteil der geborenen Kälber, die männlich sind. Üblicherweise um die 50%.'**
  String get tooltipAnteilMaennlKaelber;

  /// No description provided for @tooltipZwischenkalbezeit.
  ///
  /// In de, this message translates to:
  /// **'Die durchschnittliche Anzahl der Tage zwischen zwei aufeinanderfolgenden Kalbungen einer Kuh.'**
  String get tooltipZwischenkalbezeit;

  /// No description provided for @tooltipHaltedauerBullen.
  ///
  /// In de, this message translates to:
  /// **'Die durchschnittliche Anzahl der Tage, die ein Bullenkalb nach der Geburt im Einzel-Iglu oder in der Kälberbox verbleibt.'**
  String get tooltipHaltedauerBullen;

  /// No description provided for @tooltipHaltedauerFaersen.
  ///
  /// In de, this message translates to:
  /// **'Die durchschnittliche Anzahl der Tage, die ein Färsenkalb nach der Geburt im Einzel-Iglu oder in der Kälberbox verbleibt.'**
  String get tooltipHaltedauerFaersen;

  /// No description provided for @tooltipLeerstandszeit.
  ///
  /// In de, this message translates to:
  /// **'Die Anzahl der Tage, die eine Box oder ein Iglu nach dem Ausstallen eines Kalbes leer steht, bevor es neu belegt wird (für Reinigung und Desinfektion).'**
  String get tooltipLeerstandszeit;

  /// No description provided for @tooltipAbkalberate.
  ///
  /// In de, this message translates to:
  /// **'Der prozentuale Anteil der Kühe und zur Abkalbung vorgesehenen Färsen, die pro Jahr tatsächlich kalben.'**
  String get tooltipAbkalberate;

  /// No description provided for @tooltipFruehmortalitaet.
  ///
  /// In de, this message translates to:
  /// **'Der prozentuale Anteil der Kälber, die in den ersten 28 Lebenstagen verenden.'**
  String get tooltipFruehmortalitaet;

  /// No description provided for @tooltipTotgeburtenrate.
  ///
  /// In de, this message translates to:
  /// **'Optional: Der prozentuale Anteil der Kälber, die tot geboren werden oder innerhalb der ersten 24 Stunden verenden.'**
  String get tooltipTotgeburtenrate;

  /// No description provided for @tooltipZwillingstraechtigkeiten.
  ///
  /// In de, this message translates to:
  /// **'Der prozentuale Anteil der Trächtigkeiten, die zu Zwillingsgeburten führen.'**
  String get tooltipZwillingstraechtigkeiten;

  /// No description provided for @resultsPlaceholder.
  ///
  /// In de, this message translates to:
  /// **'Geben Sie Ihre Daten ein und klicken Sie auf \'Berechnen\', um die Ergebnisse hier anzuzeigen.'**
  String get resultsPlaceholder;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
