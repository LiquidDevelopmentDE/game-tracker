// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get choose_group => 'Gruppe wählen';

  @override
  String get create_new_match => 'Neues Match erstellen';

  @override
  String get choose_ruleset => 'Regelwerk wählen';

  @override
  String get choose_game => 'Spiel wählen';

  @override
  String get select_winner => 'Gewinner wählen:';

  @override
  String get no_recent_matches_available => 'Keine letzten Matches verfügbar';

  @override
  String get no_second_match_available => 'Kein zweites Match verfügbar';

  @override
  String get delete_all_data => 'Alle Daten löschen?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get create_new_group => 'Neue Gruppe erstellen';

  @override
  String get error_while_creating_group_please_try_again =>
      'Fehler beim Erstellen der Gruppe, bitte erneut versuchen';

  @override
  String selected_players(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return 'Ausgewählte Spieler: $countString';
  }

  @override
  String get no_players_selected => 'Keine Spieler ausgewählt';

  @override
  String get all_players => 'Alle Spieler:';

  @override
  String successfully_added_player(String playerName) {
    return 'Spieler $playerName erfolgreich hinzugefügt';
  }

  @override
  String could_not_add_player(String playerName) {
    return 'Spieler $playerName konnte nicht hinzugefügt werden';
  }

  @override
  String winner(String winnerName) {
    return 'Gewinner: $winnerName';
  }

  @override
  String get players => 'Spieler';

  @override
  String get no_statistics_available => 'Keine Statistiken verfügbar';

  @override
  String get no_data_available => 'Keine Daten verfügbar';

  @override
  String get matches => 'Matches';

  @override
  String get groups => 'Gruppen';

  @override
  String get recent_matches => 'Letzte Matches';

  @override
  String get quick_create => 'Schnellzugriff';

  @override
  String get winner_label => 'Gewinner';

  @override
  String get ruleset_label => 'Regelwerk';

  @override
  String get match_in_progress => 'Match läuft...';

  @override
  String get menu => 'Menü';

  @override
  String get settings => 'Einstellungen';

  @override
  String get export_data => 'Daten exportieren';

  @override
  String get import_data => 'Daten importieren';

  @override
  String get this_cannot_be_undone =>
      'Dies kann nicht rückgängig gemacht werden';

  @override
  String get data_successfully_deleted => 'Daten erfolgreich gelöscht';

  @override
  String get data_successfully_imported => 'Daten erfolgreich importiert';

  @override
  String get invalid_schema => 'Ungültiges Schema';

  @override
  String get error_reading_file => 'Fehler beim Lesen der Datei';

  @override
  String get import_canceled => 'Import abgebrochen';

  @override
  String get format_exception => 'Formatfehler (siehe Konsole)';

  @override
  String get unknown_exception => 'Unbekannter Fehler (siehe Konsole)';

  @override
  String get data_successfully_exported => 'Daten erfolgreich exportiert';

  @override
  String get export_canceled => 'Export abgebrochen';

  @override
  String get undo => 'Rückgängig';

  @override
  String get wins => 'Siege';

  @override
  String get winrate => 'Siegquote';

  @override
  String get amount_of_matches => 'Anzahl der Matches';

  @override
  String get info => 'Info';

  @override
  String get no_groups_created_yet => 'Noch keine Gruppen erstellt';

  @override
  String get no_players_created_yet => 'Noch keine Spieler erstellt';

  @override
  String get create_group => 'Gruppe erstellen';

  @override
  String get group_name => 'Gruppenname';

  @override
  String get player_name => 'Spielername';

  @override
  String get no_matches_created_yet => 'Noch keine Matches erstellt';

  @override
  String get match_name => 'Matchname';

  @override
  String get game => 'Spiel';

  @override
  String get ruleset => 'Regelwerk';

  @override
  String get group => 'Gruppe';

  @override
  String get none => 'Keine';

  @override
  String get create_match => 'Match erstellen';

  @override
  String get no_players_found_with_that_name =>
      'Keine Spieler mit diesem Namen gefunden';

  @override
  String get all_players_selected => 'Alle Spieler ausgewählt';

  @override
  String today_at(String time) {
    return 'Heute um $time';
  }

  @override
  String yesterday_at(String time) {
    return 'Gestern um $time';
  }

  @override
  String days_ago(int count) {
    return 'vor $count Tagen';
  }

  @override
  String get home => 'Startseite';

  @override
  String get statistics => 'Statistiken';

  @override
  String get stats => 'Statistiken';

  @override
  String players_count(int count) {
    return '$count Spieler';
  }

  @override
  String get there_is_no_group_matching_your_search =>
      'Es gibt keine Gruppe, die deiner Suche entspricht';

  @override
  String get game_name => 'Spielname';

  @override
  String get ruleset_single_winner_desc =>
      'Genau ein Gewinner wird gewählt; Unentschieden werden durch einen vordefinierten Tie-Breaker aufgelöst.';

  @override
  String get ruleset_single_loser_desc =>
      'Genau ein Verlierer wird bestimmt; der letzte Platz erhält die Strafe oder Konsequenz.';

  @override
  String get ruleset_most_points_desc =>
      'Traditionelles Regelwerk: Der Spieler mit den meisten Punkten gewinnt.';

  @override
  String get ruleset_least_points_desc =>
      'Umgekehrte Wertung: Der Spieler mit den wenigsten Punkten gewinnt.';

  @override
  String get single_winner => 'Ein Gewinner';

  @override
  String get single_loser => 'Ein Verlierer';

  @override
  String get most_points => 'Höchste Punkte';

  @override
  String get least_points => 'Niedrigste Punkte';

  @override
  String get search_for_players => 'Nach Spielern suchen';

  @override
  String get search_for_groups => 'Nach Gruppen suchen';

  @override
  String get not_available => 'Nicht verfügbar';
}
