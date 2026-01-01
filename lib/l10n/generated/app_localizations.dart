import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// Label for choosing a group
  ///
  /// In en, this message translates to:
  /// **'Choose Group'**
  String get choose_group;

  /// Button text to create a new match
  ///
  /// In en, this message translates to:
  /// **'Create new match'**
  String get create_new_match;

  /// Label for choosing a ruleset
  ///
  /// In en, this message translates to:
  /// **'Choose Ruleset'**
  String get choose_ruleset;

  /// Label for choosing a game
  ///
  /// In en, this message translates to:
  /// **'Choose Game'**
  String get choose_game;

  /// Label to select the winner
  ///
  /// In en, this message translates to:
  /// **'Select Winner:'**
  String get select_winner;

  /// Message when no recent matches exist
  ///
  /// In en, this message translates to:
  /// **'No recent matches available'**
  String get no_recent_matches_available;

  /// No description provided for @no_second_match_available.
  ///
  /// In en, this message translates to:
  /// **'No second match available'**
  String get no_second_match_available;

  /// Confirmation dialog for deleting all data
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get delete_all_data;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Button text to create a new group
  ///
  /// In en, this message translates to:
  /// **'Create new group'**
  String get create_new_group;

  /// Error message when group creation fails
  ///
  /// In en, this message translates to:
  /// **'Error while creating group, please try again'**
  String get error_while_creating_group_please_try_again;

  /// Shows the number of selected players
  ///
  /// In en, this message translates to:
  /// **'Selected players: {count}'**
  String selected_players(int count);

  /// Message when no players are selected
  ///
  /// In en, this message translates to:
  /// **'No players selected'**
  String get no_players_selected;

  /// Label for all players list
  ///
  /// In en, this message translates to:
  /// **'All players:'**
  String get all_players;

  /// Success message when adding a player
  ///
  /// In en, this message translates to:
  /// **'Successfully added player {playerName}.'**
  String successfully_added_player(String playerName);

  /// Error message when adding a player fails
  ///
  /// In en, this message translates to:
  /// **'Could not add player {playerName}.'**
  String could_not_add_player(String playerName);

  /// Shows the winner's name
  ///
  /// In en, this message translates to:
  /// **'Winner: {winnerName}'**
  String winner(String winnerName);

  /// Players label
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// Message when no data is available
  ///
  /// In en, this message translates to:
  /// **'No data available.'**
  String get no_data_available;

  /// Label for matches
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// Label for groups
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groups;

  /// Title for recent matches section
  ///
  /// In en, this message translates to:
  /// **'Recent Matches'**
  String get recent_matches;

  /// Title for quick create section
  ///
  /// In en, this message translates to:
  /// **'Quick Create'**
  String get quick_create;

  /// Label for winner field
  ///
  /// In en, this message translates to:
  /// **'Winner'**
  String get winner_label;

  /// Label for ruleset field
  ///
  /// In en, this message translates to:
  /// **'Ruleset'**
  String get ruleset_label;

  /// Message when match is in progress
  ///
  /// In en, this message translates to:
  /// **'Match in progress...'**
  String get match_in_progress;

  /// Menu label
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// Settings label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Export data menu item
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get export_data;

  /// Import data menu item
  ///
  /// In en, this message translates to:
  /// **'Import data'**
  String get import_data;

  /// Warning message for irreversible actions
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone'**
  String get this_cannot_be_undone;

  /// Success message after deleting data
  ///
  /// In en, this message translates to:
  /// **'Data successfully deleted'**
  String get data_successfully_deleted;

  /// Success message after importing data
  ///
  /// In en, this message translates to:
  /// **'Data successfully imported'**
  String get data_successfully_imported;

  /// Error message for invalid schema
  ///
  /// In en, this message translates to:
  /// **'Invalid Schema'**
  String get invalid_schema;

  /// Error message when file cannot be read
  ///
  /// In en, this message translates to:
  /// **'Error reading file'**
  String get error_reading_file;

  /// Message when import is canceled
  ///
  /// In en, this message translates to:
  /// **'Import canceled'**
  String get import_canceled;

  /// Error message for format exceptions
  ///
  /// In en, this message translates to:
  /// **'Format Exception (see console)'**
  String get format_exception;

  /// Error message for unknown exceptions
  ///
  /// In en, this message translates to:
  /// **'Unknown Exception (see console)'**
  String get unknown_exception;

  /// Success message after exporting data
  ///
  /// In en, this message translates to:
  /// **'Data successfully exported'**
  String get data_successfully_exported;

  /// Message when export is canceled
  ///
  /// In en, this message translates to:
  /// **'Export canceled'**
  String get export_canceled;

  /// Undo button text
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Label for wins statistic
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get wins;

  /// Label for winrate statistic
  ///
  /// In en, this message translates to:
  /// **'Winrate'**
  String get winrate;

  /// Label for amount of matches statistic
  ///
  /// In en, this message translates to:
  /// **'Amount of Matches'**
  String get amount_of_matches;

  /// Info label
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// Message when no groups exist
  ///
  /// In en, this message translates to:
  /// **'No groups created yet'**
  String get no_groups_created_yet;

  /// Message when no players exist
  ///
  /// In en, this message translates to:
  /// **'No players created yet'**
  String get no_players_created_yet;

  /// Button text to create a group
  ///
  /// In en, this message translates to:
  /// **'Create Group'**
  String get create_group;

  /// Placeholder for group name input
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get group_name;

  /// Placeholder for player name input
  ///
  /// In en, this message translates to:
  /// **'Player name'**
  String get player_name;

  /// Message when no matches exist
  ///
  /// In en, this message translates to:
  /// **'No matches created yet'**
  String get no_matches_created_yet;

  /// Placeholder for match name input
  ///
  /// In en, this message translates to:
  /// **'Match name'**
  String get match_name;

  /// Game label
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// Ruleset label
  ///
  /// In en, this message translates to:
  /// **'Ruleset'**
  String get ruleset;

  /// Group label
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// None option label
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// Button text to create a match
  ///
  /// In en, this message translates to:
  /// **'Create match'**
  String get create_match;

  /// Message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No players found with that name'**
  String get no_players_found_with_that_name;

  /// Message when all players are added to selection
  ///
  /// In en, this message translates to:
  /// **'All players selected'**
  String get all_players_selected;

  /// Date format for today
  ///
  /// In en, this message translates to:
  /// **'Today at {time}'**
  String today_at(String time);

  /// Date format for yesterday
  ///
  /// In en, this message translates to:
  /// **'Yesterday at {time}'**
  String yesterday_at(String time);

  /// Date format for days ago
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String days_ago(int count);

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Statistics tab label
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Stats tab label (short)
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// Shows the number of players
  ///
  /// In en, this message translates to:
  /// **'{count} Players'**
  String players_count(int count);

  /// Message when search returns no groups
  ///
  /// In en, this message translates to:
  /// **'There is no group matching your search'**
  String get there_is_no_group_matching_your_search;

  /// Placeholder for game name search
  ///
  /// In en, this message translates to:
  /// **'Game Name'**
  String get game_name;

  /// Description for single winner ruleset
  ///
  /// In en, this message translates to:
  /// **'Exactly one winner is chosen; ties are resolved by a predefined tiebreaker.'**
  String get ruleset_single_winner_desc;

  /// Description for single loser ruleset
  ///
  /// In en, this message translates to:
  /// **'Exactly one loser is determined; last place receives the penalty or consequence.'**
  String get ruleset_single_loser_desc;

  /// Description for most points ruleset
  ///
  /// In en, this message translates to:
  /// **'Traditional ruleset: the player with the most points wins.'**
  String get ruleset_most_points_desc;

  /// Description for least points ruleset
  ///
  /// In en, this message translates to:
  /// **'Inverse scoring: the player with the fewest points wins.'**
  String get ruleset_least_points_desc;

  /// Title for single winner ruleset
  ///
  /// In en, this message translates to:
  /// **'Single Winner'**
  String get single_winner;

  /// Title for single loser ruleset
  ///
  /// In en, this message translates to:
  /// **'Single Loser'**
  String get single_loser;

  /// Title for most points ruleset
  ///
  /// In en, this message translates to:
  /// **'Most Points'**
  String get most_points;

  /// Title for least points ruleset
  ///
  /// In en, this message translates to:
  /// **'Least Points'**
  String get least_points;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
