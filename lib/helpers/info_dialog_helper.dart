import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../config/app_constants.dart';

class InfoDialogHelper {
  static void showInfoDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(l10n.helpDialogTitle),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.helpDialogAboutTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  _wrapText(l10n.helpDialogAboutText, 60),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.helpDialogUsageTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  _wrapText(l10n.helpDialogUsageText, 60),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.helpDialogScenariosTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  _wrapText(l10n.helpDialogScenariosText, 60),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      MediaQuery.of(context).size.width >= kDesktopBreakpoint
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  isDarkMode
                                      ? 'lib/assets/images/logo_dark.png'
                                      : 'lib/assets/images/logo.png',
                                  height: 40,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.agriculture,
                                          size: 40,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                                Image.asset(
                                  isDarkMode
                                      ? 'lib/assets/images/fh_logo_dark.png'
                                      : 'lib/assets/images/fh_logo.png',
                                  height: 40,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.school,
                                          size: 40,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Image.asset(
                                  isDarkMode
                                      ? 'lib/assets/images/logo_dark.png'
                                      : 'lib/assets/images/logo.png',
                                  height: 40,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.agriculture,
                                          size: 40,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                                const SizedBox(height: 8),
                                Image.asset(
                                  isDarkMode
                                      ? 'lib/assets/images/fh_logo_dark.png'
                                      : 'lib/assets/images/fh_logo.png',
                                  height: 40,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.school,
                                          size: 40,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                              ],
                            ),
                      const SizedBox(height: 12),
                      Text(
                        _wrapText(l10n.programmerInfo, 60),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7),
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.appVersion,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.5),
                              fontStyle: FontStyle.italic,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(l10n.helpDialogCloseButton),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        );
      },
    );
  }

  static String _wrapText(String text, int maxLineLength) {
    if (text.length <= maxLineLength) return text;

    final words = text.split(' ');
    final lines = <String>[];
    String currentLine = '';

    for (final word in words) {
      if (word.startsWith('•') ||
          word.startsWith('1.') ||
          word.startsWith('2.') ||
          word.startsWith('3.') ||
          word.startsWith('4.')) {
        if (currentLine.isNotEmpty) {
          lines.add(currentLine.trim());
          currentLine = '';
        }
        currentLine = word;
      } else if (currentLine.isEmpty) {
        currentLine = word;
      } else if ((currentLine + ' ' + word).length <= maxLineLength) {
        currentLine += ' ' + word;
      } else {
        lines.add(currentLine);
        currentLine = word;
      }
    }

    if (currentLine.isNotEmpty) {
      lines.add(currentLine);
    }

    return lines.join('\n');
  }
}
