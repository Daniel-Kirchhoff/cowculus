import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/locale_provider.dart';

class LanguageSelectorWidget extends ConsumerWidget {
  const LanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider);
    final currentLocale = selectedLocale ?? Localizations.localeOf(context);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: 'Sprache wechseln',
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
              const Text('System'),
              const Spacer(),
              if (selectedLocale == null) const Icon(Icons.check, size: 16),
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
              const Spacer(),
              if (currentLocale.languageCode == 'de' && selectedLocale != null)
                const Icon(Icons.check, size: 16),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              const Text('🇬🇧'),
              const SizedBox(width: 8),
              const Text('English'),
              const Spacer(),
              if (currentLocale.languageCode == 'en' && selectedLocale != null)
                const Icon(Icons.check, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}
