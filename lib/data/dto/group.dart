import 'package:game_tracker/data/methods/dto/player.dart';

class Group {
  final String id;
  final String name;
  final List<Player> members;

  Group({required this.id, required this.name, required this.members});
}
