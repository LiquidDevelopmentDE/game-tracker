import 'package:clock/clock.dart';
import 'package:uuid/uuid.dart';

class Player {
  final String id;
  final String name;
  final DateTime createdAt;

  Player({String? id, DateTime? createdAt, required this.name})
    : id = id ?? const Uuid().v4(),
      createdAt = createdAt ?? clock.now();

  @override
  String toString() {
    return 'Player{id: $id,name: $name}';
  }
}
