import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './screens/start_bildschirm.dart';
import './config/app_theme.dart';

void main() {
  runApp(const KaelberRechnerApp());
}

class KaelberRechnerApp extends StatelessWidget {
  const KaelberRechnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.lightTheme,

      // --- i18n Konfiguration START ---
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('de'),
        Locale('en'),
      ],
      // --- i18n Konfiguration ENDE ---

      home: const StartBildschirm(),
      debugShowCheckedModeBanner: false,
    );
  }
}
