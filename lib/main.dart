import 'package:flutter/material.dart';
import './screens/start_bildschirm.dart';
// import './screens/rechner_bildschirm.dart';
import './config/app_theme.dart';
import './config/app_constants.dart';

void main() {
  runApp(const KaelberRechnerApp());
}

class KaelberRechnerApp extends StatelessWidget {
  const KaelberRechnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: AppTheme.lightTheme,
      home: const StartBildschirm(), // Auf den Startbildschirm setzen
      debugShowCheckedModeBanner: false,
    );
  }
}
