import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/widgets/tiles/settings_list_tile.dart';
import 'package:game_tracker/services/data_transfer_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:game_tracker/presentation/widgets/custom_alert_dialog.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'n.A.',
    packageName: 'n.A.',
    version: 'n.A.',
    buildNumber: 'n.A.',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(backgroundColor: CustomTheme.backgroundColor),
        backgroundColor: CustomTheme.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
              child: Text(
                textAlign: TextAlign.start,
                loc.menu,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Text(
                textAlign: TextAlign.start,
                loc.settings,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SettingsListTile(
              title: loc.export_data,
              icon: Icons.upload_rounded,
              suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () async {
                final String json = await DataTransferService.getAppDataAsJson(
                  context,
                );
                final result = await DataTransferService.exportData(
                  json,
                  'game_tracker-data',
                );
                if (!context.mounted) return;
                showExportSnackBar(context: context, result: result);
              },
            ),
            SettingsListTile(
              title: loc.import_data,
              icon: Icons.download_rounded,
              suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () async {
                final result = await DataTransferService.importData(context);
                if (!context.mounted) return;
                showImportSnackBar(context: context, result: result);
              },
            ),
            SettingsListTile(
              title: loc.delete_all_data,
              icon: Icons.delete_rounded,
              suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: '${loc.delete_all_data}?',
                    content: loc.this_cannot_be_undone,
                    actions: [
                      _PressableButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(loc.cancel, style: const TextStyle(color: CustomTheme.textColor)),
                      ),
                      _PressableButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(loc.delete, style: TextStyle(color: CustomTheme.secondaryColor)),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if (confirmed == true && context.mounted) {
                    DataTransferService.deleteAllData(context);
                    showSnackbar(
                      context: context,
                      message: AppLocalizations.of(
                        context,
                      ).data_successfully_deleted,
                    );
                  }
                });
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Version ${_packageInfo.version} (${_packageInfo.buildNumber})',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Displays a snackbar based on the import result.
  ///
  /// [context] The BuildContext to show the snackbar in.
  /// [result] The result of the import operation.
  void showImportSnackBar({
    required BuildContext context,
    required ImportResult result,
  }) {
    final loc = AppLocalizations.of(context);
    switch (result) {
      case ImportResult.success:
        showSnackbar(context: context, message: loc.data_successfully_imported);
      case ImportResult.invalidSchema:
        showSnackbar(context: context, message: loc.invalid_schema);
      case ImportResult.fileReadError:
        showSnackbar(context: context, message: loc.error_reading_file);
      case ImportResult.canceled:
        showSnackbar(context: context, message: loc.import_canceled);
      case ImportResult.formatException:
        showSnackbar(context: context, message: loc.format_exception);
      case ImportResult.unknownException:
        showSnackbar(context: context, message: loc.unknown_exception);
    }
  }

  /// Displays a snackbar based on the export result.
  ///
  /// [context] The BuildContext to show the snackbar in.
  /// [result] The result of the export operation.
  void showExportSnackBar({
    required BuildContext context,
    required ExportResult result,
  }) {
    final loc = AppLocalizations.of(context);
    switch (result) {
      case ExportResult.success:
        showSnackbar(context: context, message: loc.data_successfully_exported);
      case ExportResult.canceled:
        showSnackbar(context: context, message: loc.export_canceled);
      case ExportResult.unknownException:
        showSnackbar(context: context, message: loc.unknown_exception);
    }
  }

  /// Displays a snackbar with the given message and optional action.
  ///
  /// [context] The BuildContext to show the snackbar in.
  /// [message] The message to display in the snackbar.
  /// [duration] The duration for which the snackbar is displayed.
  /// [action] An optional callback function to execute when the action button is pressed.
  void showSnackbar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? action,
  }) {
    final loc = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: CustomTheme.onBoxColor,
        duration: duration,
        action: action != null
            ? SnackBarAction(label: loc.undo, onPressed: action)
            : null,
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
}

class _PressableButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const _PressableButton({required this.onPressed, required this.child});

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.6 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}


/*
                      TextButton(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: Colors.transparent,
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(loc.cancel, style: const TextStyle(color: CustomTheme.textColor),),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: Colors.transparent,
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(loc.delete, style: TextStyle(color: CustomTheme.secondaryColor),),
                      ),
 */
