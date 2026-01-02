import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/core/enums.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/widgets/tiles/settings_list_tile.dart';
import 'package:game_tracker/services/data_transfer_service.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: CustomTheme.backgroundColor),
      backgroundColor: CustomTheme.backgroundColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                    child: Text(
                      textAlign: TextAlign.start,
                      AppLocalizations.of(context).menu,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: Text(
                      textAlign: TextAlign.start,
                      AppLocalizations.of(context).settings,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SettingsListTile(
                    title: AppLocalizations.of(context).export_data,
                    icon: Icons.upload_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () async {
                      final String json =
                          await DataTransferService.getAppDataAsJson(context);
                      final result = await DataTransferService.exportData(
                        json,
                        'game_tracker-data',
                      );
                      if (!context.mounted) return;
                      showExportSnackBar(context: context, result: result);
                    },
                  ),
                  SettingsListTile(
                    title: AppLocalizations.of(context).import_data,
                    icon: Icons.download_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () async {
                      final result = await DataTransferService.importData(
                        context,
                      );
                      if (!context.mounted) return;
                      showImportSnackBar(context: context, result: result);
                    },
                  ),
                  SettingsListTile(
                    title: AppLocalizations.of(context).delete_all_data,
                    icon: Icons.download_outlined,
                    suffixWidget: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () {
                      showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            AppLocalizations.of(context).delete_all_data,
                          ),
                          content: Text(
                            AppLocalizations.of(context).this_cannot_be_undone,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(AppLocalizations.of(context).cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(AppLocalizations.of(context).delete),
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
                ],
              ),
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
    switch (result) {
      case ImportResult.success:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).data_successfully_imported,
        );
      case ImportResult.invalidSchema:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).invalid_schema,
        );
      case ImportResult.fileReadError:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).error_reading_file,
        );
      case ImportResult.canceled:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).import_canceled,
        );
      case ImportResult.formatException:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).format_exception,
        );
      case ImportResult.unknownException:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).unknown_exception,
        );
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
    switch (result) {
      case ExportResult.success:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).data_successfully_exported,
        );
      case ExportResult.canceled:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).export_canceled,
        );
      case ExportResult.unknownException:
        showSnackbar(
          context: context,
          message: AppLocalizations.of(context).unknown_exception,
        );
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
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: CustomTheme.onBoxColor,
        duration: duration,
        action: action != null
            ? SnackBarAction(
                label: AppLocalizations.of(context).undo,
                onPressed: action,
              )
            : null,
      ),
    );
  }
}
