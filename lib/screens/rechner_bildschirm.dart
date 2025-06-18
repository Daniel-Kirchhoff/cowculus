import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/rechner_providers.dart';
import '../widgets/ergebnis_tabelle_widget.dart';
import '../widgets/ergebnis_chart_widget.dart';
import '../widgets/input_form_widget.dart';
import '../config/app_constants.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import '../helpers/info_dialog_helper.dart';
import '../helpers/loading_manager.dart';
import '../widgets/language_selector_widget.dart';

class RechnerBildschirm extends ConsumerStatefulWidget {
  const RechnerBildschirm({super.key});

  @override
  ConsumerState<RechnerBildschirm> createState() => _RechnerBildschirmState();
}

class _RechnerBildschirmState extends ConsumerState<RechnerBildschirm> {
  late final ScrollController _scrollController;
  final GlobalKey _resultsKey = GlobalKey();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToResults() {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < kDesktopBreakpoint;

    if (isMobile) {
      final RenderBox? renderBox =
          _resultsKey.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final scrollOffset = position.dy + _scrollController.offset - 100;

        _scrollController.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _onFormSubmit() async {
    await LoadingManager.executeWithLoading(
      onLoadingStart: () => setState(() => _isLoading = true),
      onLoadingComplete: () => setState(() => _isLoading = false),
      onSuccess: () {
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollToResults();
        });
      },
    );
  }

  Widget _buildInputColumn() {
    return InputFormWidget(
      onSubmit: _onFormSubmit,
      isLoading: _isLoading,
    );
  }

  Widget _buildResultsColumn() {
    final ergebnisse = ref.watch(ergebnisProvider);

    if (_isLoading) {
      return LoadingManager.buildLoadingWidget(context);
    }

    if (ergebnisse == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingLarge),
          child: Text(
            AppLocalizations.of(context)!.resultsPlaceholder,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      key: _resultsKey,
      children: [
        ErgebnisChartWidget(
          aktuellErgebnis: ergebnisse.aktuell,
          realistischErgebnis: ergebnisse.realistisch,
          empfehlungErgebnis: ergebnisse.empfehlung,
        ),
        const SizedBox(height: kPaddingLarge * 2),
        ErgebnisTabelleWidget(
          aktuellErgebnis: ergebnisse.aktuell,
          realistischErgebnis: ergebnisse.realistisch,
          empfehlungErgebnis: ergebnisse.empfehlung,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= kDesktopBreakpoint;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () => InfoDialogHelper.showInfoDialog(context),
          tooltip: l10n.helpButtonTooltip,
        ),
        title: Hero(
          tag: 'appLogo',
          child: Image.asset(
            isDarkMode
                ? 'lib/assets/images/logo_bild_dark.png'
                : 'lib/assets/images/logo_bild.png',
            height: 30,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.agriculture, size: kIconSizeDefault),
          ),
        ),
        actions: [
          const LanguageSelectorWidget(),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
            tooltip: 'Helligkeit wechseln',
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kPaddingLarge),
            child: _buildInputColumn(),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kPaddingLarge),
            child: _buildResultsColumn(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(kPaddingLarge),
      child: Column(
        children: [
          _buildInputColumn(),
          const SizedBox(height: kPaddingLarge),
          _buildResultsColumn(),
        ],
      ),
    );
  }
}
