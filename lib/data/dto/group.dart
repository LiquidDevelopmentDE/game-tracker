import 'package:game_tracker/data/dto/player.dart';

class Group {
  final String id;
  final String name;
  final List<Player> members;

  Group({required this.id, required this.name, required this.members});

  @override
  String toString() {
    return 'Group{id: $id, name: $name,members: $members}';
  }
}
