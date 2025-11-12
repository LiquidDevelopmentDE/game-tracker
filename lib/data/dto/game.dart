import 'package:game_tracker/data/dto/group.dart';
import 'package:game_tracker/data/dto/player.dart';

class Game {
  final String id;
  final String name;
  final List<Player>? players;
  final Group? group;
  final String winner;

  Game({
    this.players,
    this.group,
    this.winner = '',
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return 'Game{\n\tid: $id,\n\tname: $name,\n\tplayers: $players,\n\tgroup: $group,\n\twinner: $winner\n}';
  }
}
