import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/views/main_menu/settings_view/licenses/oss_licenses.dart';
import 'package:game_tracker/presentation/widgets/tiles/license_tile.dart';

class LicensesView extends StatelessWidget {
  const LicensesView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.licenses),
        backgroundColor: CustomTheme.backgroundColor,
      ),
      backgroundColor: CustomTheme.backgroundColor,
      body: ListView.builder(
        itemCount: allDependencies.length,
        itemBuilder: (context, index) {
          final package = allDependencies[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: LicenseTile(package: package),
          );
        },
      ),
    );
  }
}
