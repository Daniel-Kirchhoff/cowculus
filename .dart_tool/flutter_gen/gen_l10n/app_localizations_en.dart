import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'cowculus';

  @override
  String get appBarTitle => 'AppBarTitle Placeholder';

  @override
  String get calculatorTitle => 'Calf Pen Calculator';

  @override
  String welcomeMessage(String appName) {
    return 'Welcome to $appName!';
  }

  @override
  String get welcomeSubtitle => 'WelcomeSubtitle Placeholder';

  @override
  String get startCalculatorButton => 'Start Calculator';

  @override
  String get mainParameterFormTitle => 'Enter Farm-Specific Parameters:';

  @override
  String get resultsTitle => 'Results of Calf Pen Calculation:';

  @override
  String get panelTitleTierzahlen => 'Animal Numbers';

  @override
  String get panelTitleGeschlecht => 'Sex Distribution';

  @override
  String get panelTitleZeit => 'Time Parameters';

  @override
  String get panelTitleReproduktion => 'Reproduction & Health Parameters';

  @override
  String get columnHeaderParameter => 'Parameter';

  @override
  String get columnHeaderAktuell => 'Current\n(farm-specific)';

  @override
  String get columnHeaderRealistisch => 'Realistic\n(Avg. NRW/DE, +25% Res.)';

  @override
  String get columnHeaderEmpfehlung => 'Recommendation\n(Consulting)';

  @override
  String get rowLabelBullenkaelber => 'Bull Calf Pens';

  @override
  String get rowLabelFaersenkaelber => 'Heifer Calf Pens';

  @override
  String get rowLabelGesamtPlaetze => 'Total Pens';

  @override
  String get buttonTextBerechnen => 'Calculate';

  @override
  String get hinweisTextTabelle => '* Note: \'Realistic\' includes a 25% reserve on total pens. \'Bull calf\' and \'Heifer calf pens\' are shown without this scenario-specific reserve.';

  @override
  String get textFieldHint => 'Enter value';

  @override
  String get validatorMsgBitteWertEingeben => 'Please enter a value';

  @override
  String get validatorMsgUngueltigeZahl => 'Invalid number';

  @override
  String get validatorMsgWertMussPositivSein => 'Value must be positive';

  @override
  String get einheitStueck => 'pcs.';

  @override
  String get einheitProzent => '%';

  @override
  String get einheitTage => 'days';

  @override
  String get textFormFieldLabelAnzahlMilchkuehe => 'Number of Dairy Cows';

  @override
  String get textFormFieldLabelAnzahlFaersen => 'Number of Heifers for Calving (per year)';

  @override
  String get textFormFieldLabelAnteilMaennlKaelber => 'Percentage of Male Calves';

  @override
  String get textFormFieldLabelZwischenkalbezeit => 'Inter-Calving Interval';

  @override
  String get textFormFieldLabelHaltedauerBullen => 'Housing Duration Bull Calves (single)';

  @override
  String get textFormFieldLabelHaltedauerFaersen => 'Housing Duration Heifer Calves (single)';

  @override
  String get textFormFieldLabelLeerstandszeit => 'Vacancy Period Between Occupancies';

  @override
  String get textFormFieldLabelAbkalberate => 'Calving Rate';

  @override
  String get textFormFieldLabelFruehmortalitaet => 'Early Mortality (calves up to 28 days)';

  @override
  String get textFormFieldLabelTotgeburtenrate => 'Stillbirth Rate (optional)';

  @override
  String get textFormFieldLabelZwillingstraechtigkeiten => 'Twin Pregnancy Rate';
}
