import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/berechnungs_eingabe.dart';
import '../models/szenario_ergebnis.dart';
import '../services/berechnungs_service.dart';

typedef ErgebnisSzenarien = ({
  SzenarioErgebnis aktuell,
  SzenarioErgebnis realistisch,
  SzenarioErgebnis empfehlung
});

final berechnungsServiceProvider = Provider<BerechnungsService>((ref) {
  return BerechnungsService();
});

final eingabeProvider =
    StateNotifierProvider<EingabeNotifier, BerechnungsEingabe>((ref) {
  return EingabeNotifier();
});

class EingabeNotifier extends StateNotifier<BerechnungsEingabe> {
  EingabeNotifier() : super(BerechnungsEingabe());

  void updateFeld(String schluessel, double wert) {
    state = state.aktualisiereFeld(schluessel, wert);
  }
}

final ergebnisProvider = StateProvider<ErgebnisSzenarien?>((ref) {
  return null;
});
