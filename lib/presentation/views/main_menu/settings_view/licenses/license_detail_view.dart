import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/views/main_menu/settings_view/licenses/oss_licenses.dart';

class LicenseDetailView extends StatelessWidget {
  final Package package;

  const LicenseDetailView({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Lizenzdetails')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsetsGeometry.only(right: 15),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: CustomTheme.primaryColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.description,
                          color: CustomTheme.primaryColor,
                          size: 30,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            package.name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              height: 0,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (package.version != null) ...[
                            Text(
                              'Version ${package.version}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),

                  if (package.authors.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    SelectableText(
                      package.authors.join(', '),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                  if (package.homepage != null &&
                      package.homepage!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    SelectableText(
                      package.homepage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: CustomTheme.standardBoxDecoration,
              child: (package.license != null && package.license!.isNotEmpty)
                  ? SelectableText(
                      package.license!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade300,
                        height: 1.5,
                        fontFamily: 'monospace',
                      ),
                    )
                  : Center(
                      heightFactor: 25,
                      child: Text(
                        loc.no_license_text_available,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
