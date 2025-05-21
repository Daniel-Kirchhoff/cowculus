// Datenmodell für Berechnungsergebnisse eines Szenarios
class SzenarioErgebnis {
  final double bullenkaelberPlaetze;
  final double faersenkaelberPlaetze;
  final double gesamtPlaetze;

  SzenarioErgebnis({
    required this.bullenkaelberPlaetze,
    required this.faersenkaelberPlaetze,
    required this.gesamtPlaetze,
  });
}
