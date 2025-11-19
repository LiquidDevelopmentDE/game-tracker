import 'package:clock/clock.dart';
import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:uuid/uuid.dart';

class Game {
  final String id;
  final String name;
  final List<Player>? players;
  final Group? group;
  final String? winner;
  final DateTime createdAt;

  Game({
    String? id,
    DateTime? createdAt,
    required this.name,
    this.players,
    this.group,
    this.winner = '',
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? clock.now();

  @override
  String toString() {
    return 'Game{\n\tid: $id,\n\tname: $name,\n\tplayers: $players,\n\tgroup: $group,\n\twinner: $winner\n}';
  }

  /// Creates a Game instance from a JSON object.
  Game.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      players = json['players'] != null
          ? (json['players'] as List)
                .map((playerJson) => Player.fromJson(playerJson))
                .toList()
          : null,
      group = json['group'] != null ? Group.fromJson(json['group']) : null,
      winner = json['winner'] ?? '';

  /// Converts the Game instance to a JSON object.
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'players': players?.map((player) => player.toJson()).toList(),
    'group': group?.toJson(),
    'winner': winner,
  };
}
