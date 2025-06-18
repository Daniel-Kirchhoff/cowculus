import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../config/app_constants.dart';

class LoadingManager {
  static Duration get defaultLoadingDuration => Duration(
        milliseconds: Random().nextInt(500) + 1000,
      );

  static Future<void> executeWithLoading({
    required VoidCallback onLoadingStart,
    required VoidCallback onLoadingComplete,
    required VoidCallback onSuccess,
    Duration? loadingDuration,
  }) async {
    onLoadingStart();

    await Future.delayed(loadingDuration ?? defaultLoadingDuration);

    onLoadingComplete();

    onSuccess();
  }

  static Widget buildLoadingWidget(BuildContext context, {String? customText}) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kPaddingLarge * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            ),
            const SizedBox(height: kPaddingLarge),
            Text(
              customText ?? l10n.loadingCalculating,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kPaddingLarge / 2),
            Text(
              l10n.loadingPleaseWait,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildLoadingButton({
    required BuildContext context,
    required VoidCallback? onPressed,
    required bool isLoading,
    required String normalText,
    required String loadingText,
    IconData? icon,
    double? width,
  }) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton.icon(
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(icon ?? Icons.calculate, size: kIconSizeDefault),
        onPressed: isLoading ? null : onPressed,
        label: Text(isLoading ? loadingText : normalText),
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading ? Theme.of(context).disabledColor : null,
        ),
      ),
    );
  }
}
