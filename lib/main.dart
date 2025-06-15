import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/start_bildschirm.dart';
import './screens/rechner_bildschirm.dart';
import './config/app_theme.dart';
import './providers/theme_provider.dart';
import './providers/locale_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool skipSplash = prefs.getBool('skipSplash') ?? false;

  runApp(ProviderScope(
    child: KaelberRechnerApp(skipSplash: skipSplash),
  ));
}

class KaelberRechnerApp extends ConsumerWidget {
  final bool skipSplash;
  const KaelberRechnerApp({super.key, required this.skipSplash});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final selectedLocale = ref.watch(localeProvider);

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: selectedLocale,
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
      home: skipSplash ? const RechnerBildschirm() : const StartBildschirm(),
      debugShowCheckedModeBanner: false,
    );
  }
}
