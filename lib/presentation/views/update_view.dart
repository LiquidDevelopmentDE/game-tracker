import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:tallee/core/custom_theme.dart';
import 'package:tallee/l10n/generated/app_localizations.dart';
import 'package:tallee/presentation/widgets/buttons/buttons.dart';
import 'package:tallee/presentation/widgets/colored_icon_container.dart';
import 'package:tallee/services/package_info_service.dart';

class UpdateView extends StatelessWidget {
  const UpdateView({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final PackageInfo packageInfo = PackageInfoService.info;

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  buildHeader(loc, packageInfo),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: FutureBuilder<String>(
                      future: loadMarkdownFiles(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: CustomTheme.primaryColor,
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(loc.error_loading_whats_new),
                          );
                        }
                        return Markdown(
                          data: snapshot.data ?? '',
                          selectable: true,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          styleSheet: buildMarkdownSheet(context),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: BottomAnimatedButton(
                buttonConstraints: const BoxConstraints(minWidth: 390),
                buttonText: loc.close,
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(AppLocalizations loc, PackageInfo packageInfo) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 28, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 6,
        children: [
          // Icon
          const ColoredIconContainer(containerSize: 60, icon: Icons.newspaper),

          // Title
          Text(
            loc.whats_new,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          // Version
          Text(
            'Version ${packageInfo.version}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade300),
          ),
        ],
      ),
    );
  }

  MarkdownStyleSheet buildMarkdownSheet(BuildContext context) {
    return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      p: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: CustomTheme.textColor,
        overflow: TextOverflow.visible,
      ),
      h1: const TextStyle(
        color: CustomTheme.textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      h2: const TextStyle(
        color: CustomTheme.primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      h3: const TextStyle(
        color: CustomTheme.textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      listBullet: const TextStyle(color: CustomTheme.textColor),
      strong: const TextStyle(
        color: CustomTheme.textColor,
        fontWeight: FontWeight.bold,
      ),
      horizontalRuleDecoration: const BoxDecoration(
        border: Border(top: BorderSide(color: CustomTheme.boxBorderColor)),
      ),
    );
  }

  Future<String> loadMarkdownFiles(BuildContext context) async {
    final languageCode = Localizations.localeOf(context).languageCode;
    try {
      return await rootBundle.loadString(
        'assets/whats_new/whats_new_$languageCode.md',
      );
    } catch (_) {
      return await rootBundle.loadString('assets/whats_new/whats_new_en.md');
    }
  }
}
