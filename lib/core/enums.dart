/// Button types used for styling the [CustomWidthButton]
enum ButtonType { primary, secondary, tertiary }

/// Result types for import operations in the [SettingsView]
/// - [ImportResult.success]: The import operation was successful.
/// - [ImportResult.canceled]: The import operation was canceled by the user.
/// - [ImportResult.fileReadError]: There was an error reading the selected file.
/// - [ImportResult.invalidSchema]: The JSON schema of the imported data is invalid.
/// - [ImportResult.formatException]: A format exception occurred during import.
/// - [ImportResult.unknownException]: An exception occurred during import.
enum ImportResult {
  success,
  canceled,
  fileReadError,
  invalidSchema,
  formatException,
  unknownException,
}

/// Result types for export operations in the [SettingsView]
/// - [ExportResult.success]: The export operation was successful.
/// - [ExportResult.canceled]: The export operation was canceled by the user.
/// - [ExportResult.unknownException]: An exception occurred during export.
enum ExportResult { success, canceled, unknownException }
