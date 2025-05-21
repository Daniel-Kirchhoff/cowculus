import 'package:flutter/material.dart';
import './screens/rechner_bildschirm.dart';

void main() {
  runApp(const KaelberRechnerApp());
}

class KaelberRechnerApp extends StatelessWidget {
  const KaelberRechnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cowculus',
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        fontFamily: 'Inter',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
      home: const RechnerBildschirm(),
      debugShowCheckedModeBanner: false,
    );
  }
}
