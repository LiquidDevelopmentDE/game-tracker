import 'package:game_tracker/data/dto/player.dart';
import 'package:uuid/uuid.dart';

class Group {
  final String id;
  final String name;
  final List<Player> members;

  Group({String? id, required this.name, required this.members})
    : id = id ?? const Uuid().v4();

  @override
  String toString() {
    return 'Group{id: $id, name: $name,members: $members}';
  }
}
