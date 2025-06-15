import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider);
    final currentLocale = selectedLocale ?? Localizations.localeOf(context);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String languageCode) {
        if (languageCode == 'system') {
          ref.read(localeProvider.notifier).clearLocale();
        } else {
          ref.read(localeProvider.notifier).setLocale(Locale(languageCode));
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'system',
          child: Row(
            children: [
              const Icon(Icons.phone_android),
              const SizedBox(width: 8),
              Text(AppLocalizations.of(context)!.systemLanguage ?? 'System'),
              if (selectedLocale == null) 
                const Icon(Icons.check, size: 16),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'de',
          child: Row(
            children: [
              const Text('🇩🇪'),
              const SizedBox(width: 8),
              const Text('Deutsch'),
              if (currentLocale.languageCode == 'de' && selectedLocale != null)
                const Icon(Icons.check, size: 16),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              const Text('🇺🇸'),
              const SizedBox(width: 8),
              const Text('English'),
              if (currentLocale.languageCode == 'en' && selectedLocale != null)
                const Icon(Icons.check, size: 16),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'pt',
          child: Row(
            children: [
              const Text('🇵🇹'),
              const SizedBox(width: 8),
              const Text('Português'),
              if (currentLocale.languageCode == 'pt' && selectedLocale != null)
                const Icon(Icons.check, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}
