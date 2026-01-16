import 'package:clock/clock.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:uuid/uuid.dart';

class Match {
  final String id;
  final DateTime createdAt;
  final String name;
  final Game? game;
  final Group? group;
  final List<Player>? players;
  final String? notes;
  Player? winner;

  Match({
    String? id,
    DateTime? createdAt,
    required this.name,
    this.game,
    this.group,
    this.players,
    this.notes,
    this.winner,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? clock.now();

  @override
  String toString() {
    return 'Match{id: $id, name: $name, game: $game, group: $group, players: $players, notes: $notes, winner: $winner}';
  }

  /// Creates a Match instance from a JSON object.
  Match.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      createdAt = DateTime.parse(json['createdAt']),
      name = json['name'],
      game = json['game'] != null ? Game.fromJson(json['game']) : null,
      group = json['group'] != null ? Group.fromJson(json['group']) : null,
      players = json['players'] != null
          ? (json['players'] as List)
              .map((playerJson) => Player.fromJson(playerJson))
              .toList()
          : null,
      notes = json['notes'];

  /// Converts the Match instance to a JSON object.
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'name': name,
    'game': game?.toJson(),
    'group': group?.toJson(),
    'players': players?.map((player) => player.toJson()).toList(),
    'notes': notes,
  };
}
