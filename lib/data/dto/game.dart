import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:uuid/uuid.dart';

class Game {
  final String id;
  final String name;
  final List<Player>? players;
  final Group? group;
  final String winner;
  final DateTime createdAt;

  Game({
    String? id,
    DateTime? createdAt,
    required this.name,
    this.players,
    this.group,
    this.winner = '',
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'Game{\n\tid: $id,\n\tname: $name,\n\tplayers: $players,\n\tgroup: $group,\n\twinner: $winner\n}';
  }
}
