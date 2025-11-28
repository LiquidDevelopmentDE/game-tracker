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

/// Different rulesets available for games
/// - [Ruleset.singleWinner]: The game is won by a single player
/// - [Ruleset.singleLoser]: The game is lost by a single player
/// - [Ruleset.mostPoints]: The player with the most points wins.
/// - [Ruleset.leastPoints]: The player with the fewest points wins.
enum Ruleset { singleWinner, singleLoser, mostPoints, leastPoints }

/// Translates a [Ruleset] enum value to its corresponding string representation.
String translateRulesetToString(Ruleset ruleset) {
  switch (ruleset) {
    case Ruleset.singleWinner:
      return 'Single Winner';
    case Ruleset.singleLoser:
      return 'Single Loser';
    case Ruleset.mostPoints:
      return 'Most Points';
    case Ruleset.leastPoints:
      return 'Least Points';
  }
}
