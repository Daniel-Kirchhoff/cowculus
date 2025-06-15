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
  String get welcomeHeadline => 'Welcome to cowculus!';

  @override
  String get welcomeSubtitle => 'This app is based on the master’s thesis by Maren Thiemann and brings her calculation tool for determining the need for individual calf pens into practice. Designed for dairy farmers and advisors, it helps you calculate your specific space requirements and identify opportunities to improve calf housing management.';

  @override
  String get splashExplanation => 'This app helps you determine the required number of calf pens for your farm.';

  @override
  String get masterThesisCredit => 'Developed as part of the master\'s thesis by M. Thiemann, FH Südwestfalen.';

  @override
  String get skipSplashCheckboxLabel => 'Skip this page next time';

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

  @override
  String get tooltipAnzahlMilchkuehe => 'Enter the average number of lactating cows in your herd.';

  @override
  String get tooltipAnzahlFaersen => 'Enter the number of heifers expected to calve for the first time in the coming year.';

  @override
  String get tooltipAnteilMaennlKaelber => 'The percentage of born calves that are male. Usually around 50%.';

  @override
  String get tooltipZwischenkalbezeit => 'The average number of days between two consecutive calvings of a cow.';

  @override
  String get tooltipHaltedauerBullen => 'The average number of days a bull calf remains in a single hutch or calf box after birth.';

  @override
  String get tooltipHaltedauerFaersen => 'The average number of days a heifer calf remains in a single hutch or calf box after birth.';

  @override
  String get tooltipLeerstandszeit => 'The number of days a box or hutch remains empty after a calf is moved out before it is reoccupied (for cleaning and disinfection).';

  @override
  String get tooltipAbkalberate => 'The percentage of cows and heifers intended for calving that actually calve per year.';

  @override
  String get tooltipFruehmortalitaet => 'The percentage of calves that die within the first 28 days of life.';

  @override
  String get tooltipTotgeburtenrate => 'Optional: The percentage of calves that are stillborn or die within the first 24 hours.';

  @override
  String get tooltipZwillingstraechtigkeiten => 'The percentage of pregnancies that result in twin births.';

  @override
  String get resultsPlaceholder => 'Enter your data and click \'Calculate\' to display the results here.';
}
