import 'package:flutter/material.dart';
import 'dart:async';

import './rechner_bildschirm.dart';
import '../config/app_constants.dart';

class StartBildschirm extends StatefulWidget {
  const StartBildschirm({super.key});

  @override
  State<StartBildschirm> createState() => _StartBildschirmState();
}

class _StartBildschirmState extends State<StartBildschirm>
    with SingleTickerProviderStateMixin {
  // Variablen für Animationen
  bool _contentVisible = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200), // Gesamtdauer der Animation
      vsync: this,
    );

    // Skalierungsanimation für das Logo
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Fade-In Animation für Text und Button
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.4,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    Timer(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _contentVisible =
              true; // Macht initiale Elemente sichtbar, falls nicht animiert
        });
        _animationController.forward(); // Startet die definierten Animationen
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToRechner() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const RechnerBildschirm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPaddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Logo mit Hero-Animation und Skalierungsanimation
              ScaleTransition(
                scale: _scaleAnimation,
                child: Hero(
                  tag: 'appLogo',
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: screenWidth * 0.4, // Responsive Breite
                    // height: 150,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback, falls das Logo nicht geladen werden kann
                      return const Icon(Icons.agriculture,
                          size: 100, color: kSeedColor);
                    },
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Willkommenstext mit Fade-In Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Willkommen bei cowculus!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Ihr Helfer für die Kälberplatzplanung.', // Untertitel
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              SizedBox(height: screenHeight * 0.08),

              // Button zum Weiterklicken mit Fade-In Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  style: ElevatedButton.styleFrom(
                    padding: kButtonPadding.add(const EdgeInsets.symmetric(
                        vertical: kPaddingSmall / 2)),
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _navigateToRechner,
                  label: const Text(kButtonTextBerechnen),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
