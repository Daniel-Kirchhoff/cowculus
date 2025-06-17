import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './rechner_bildschirm.dart';
import '../config/app_constants.dart';

class StartBildschirm extends ConsumerStatefulWidget {
  const StartBildschirm({super.key});

  @override
  ConsumerState<StartBildschirm> createState() => _StartBildschirmState();
}

class _StartBildschirmState extends ConsumerState<StartBildschirm>
    with SingleTickerProviderStateMixin {
  bool _skipNextTime = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );
    Timer(const Duration(milliseconds: 200), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _navigateToRechner() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('skipSplash', _skipNextTime);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RechnerBildschirm()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingLarge),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: 'appLogo',
                    child: Image.asset(
                      isDarkMode
                          ? 'lib/assets/images/logo_dark.png'
                          : 'lib/assets/images/logo.png',
                      height: 80,
                      errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.agriculture,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Image.asset(
                    isDarkMode
                        ? 'lib/assets/images/fh_logo_dark.png'
                        : 'lib/assets/images/fh_logo.png',
                    height: 60,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.school, size: 60),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Text(
                            l10n.welcomeHeadline,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: kPaddingMedium),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            l10n.splashExplanation,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: kPaddingLarge),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            l10n.masterThesisCredit,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _skipNextTime,
                          onChanged: (bool? value) {
                            setState(() {
                              _skipNextTime = value ?? false;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _skipNextTime = !_skipNextTime;
                            });
                          },
                          child: Text(l10n.skipSplashCheckboxLabel),
                        ),
                      ],
                    ),
                    const SizedBox(height: kPaddingSmall),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward_rounded),
                      onPressed: _navigateToRechner,
                      label: Text(l10n.startCalculatorButton),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
