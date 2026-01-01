// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get choose_group => 'Choose Group';

  @override
  String get create_new_match => 'Create new match';

  @override
  String get choose_ruleset => 'Choose Ruleset';

  @override
  String get choose_game => 'Choose Game';

  @override
  String get select_winner => 'Select Winner:';

  @override
  String get no_recent_matches_available => 'No recent matches available';

  @override
  String get no_second_match_available => 'No second match available';

  @override
  String get delete_all_data => 'Delete all data?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get create_new_group => 'Create new group';

  @override
  String get error_while_creating_group_please_try_again =>
      'Error while creating group, please try again';

  @override
  String selected_players(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'Selected players: $countString';
  }

  @override
  String get no_players_selected => 'No players selected';

  @override
  String get all_players => 'All players:';

  @override
  String successfully_added_player(String playerName) {
    return 'Successfully added player $playerName';
  }

  @override
  String could_not_add_player(String playerName) {
    return 'Could not add player $playerName';
  }

  @override
  String winner(String winnerName) {
    return 'Winner: $winnerName';
  }

  @override
  String get players => 'Players';

  @override
  String get no_statistics_available => 'No statistics available';

  @override
  String get no_data_available => 'No data available';

  @override
  String get matches => 'Matches';

  @override
  String get groups => 'Groups';

  @override
  String get recent_matches => 'Recent Matches';

  @override
  String get quick_create => 'Quick Create';

  @override
  String get winner_label => 'Winner';

  @override
  String get ruleset_label => 'Ruleset';

  @override
  String get match_in_progress => 'Match in progress...';

  @override
  String get menu => 'Menu';

  @override
  String get settings => 'Settings';

  @override
  String get export_data => 'Export data';

  @override
  String get import_data => 'Import data';

  @override
  String get this_cannot_be_undone => 'This can\'t be undone';

  @override
  String get data_successfully_deleted => 'Data successfully deleted';

  @override
  String get data_successfully_imported => 'Data successfully imported';

  @override
  String get invalid_schema => 'Invalid Schema';

  @override
  String get error_reading_file => 'Error reading file';

  @override
  String get import_canceled => 'Import canceled';

  @override
  String get format_exception => 'Format Exception (see console)';

  @override
  String get unknown_exception => 'Unknown Exception (see console)';

  @override
  String get data_successfully_exported => 'Data successfully exported';

  @override
  String get export_canceled => 'Export canceled';

  @override
  String get undo => 'Undo';

  @override
  String get wins => 'Wins';

  @override
  String get winrate => 'Winrate';

  @override
  String get amount_of_matches => 'Amount of Matches';

  @override
  String get info => 'Info';

  @override
  String get no_groups_created_yet => 'No groups created yet';

  @override
  String get no_players_created_yet => 'No players created yet';

  @override
  String get create_group => 'Create Group';

  @override
  String get group_name => 'Group name';

  @override
  String get player_name => 'Player name';

  @override
  String get no_matches_created_yet => 'No matches created yet';

  @override
  String get match_name => 'Match name';

  @override
  String get game => 'Game';

  @override
  String get ruleset => 'Ruleset';

  @override
  String get group => 'Group';

  @override
  String get none => 'None';

  @override
  String get create_match => 'Create match';

  @override
  String get no_players_found_with_that_name =>
      'No players found with that name';

  @override
  String get all_players_selected => 'All players selected';

  @override
  String today_at(String time) {
    return 'Today at $time';
  }

  @override
  String yesterday_at(String time) {
    return 'Yesterday at $time';
  }

  @override
  String days_ago(int count) {
    return '$count days ago';
  }

  @override
  String get home => 'Home';

  @override
  String get statistics => 'Statistics';

  @override
  String get stats => 'Stats';

  @override
  String players_count(int count) {
    return '$count Players';
  }

  @override
  String get there_is_no_group_matching_your_search =>
      'There is no group matching your search';

  @override
  String get game_name => 'Game Name';

  @override
  String get ruleset_single_winner_desc =>
      'Exactly one winner is chosen; ties are resolved by a predefined tiebreaker.';

  @override
  String get ruleset_single_loser_desc =>
      'Exactly one loser is determined; last place receives the penalty or consequence.';

  @override
  String get ruleset_most_points_desc =>
      'Traditional ruleset: the player with the most points wins.';

  @override
  String get ruleset_least_points_desc =>
      'Inverse scoring: the player with the fewest points wins.';

  @override
  String get single_winner => 'Single Winner';

  @override
  String get single_loser => 'Single Loser';

  @override
  String get most_points => 'Most Points';

  @override
  String get least_points => 'Least Points';

  @override
  String get search_for_players => 'Search for players';

  @override
  String get search_for_groups => 'Search for groups';
}
