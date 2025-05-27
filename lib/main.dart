import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './screens/rechner_bildschirm.dart';
import './config/app_theme.dart';

void main() {
  runApp(const KaelberRechnerApp());
}

class KaelberRechnerApp extends StatelessWidget {
  const KaelberRechnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Kuhkulus',
        theme: AppTheme.lightTheme,
        home: const RechnerBildschirm(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
