import 'package:uuid/uuid.dart';

class Player {
  final String id;
  final String name;

  Player({String? id, required this.name}) : id = id ?? const Uuid().v4();

  @override
  String toString() {
    return 'Player{id: $id,name: $name}';
  }
}
