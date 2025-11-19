import 'package:clock/clock.dart';
import 'package:uuid/uuid.dart';

class Player {
  final String id;
  final DateTime createdAt;
  final String name;

  Player({String? id, DateTime? createdAt, required this.name})
    : id = id ?? const Uuid().v4(),
      createdAt = createdAt ?? clock.now();

  @override
  String toString() {
    return 'Player{id: $id,name: $name}';
  }

  /// Creates a Player instance from a JSON object.
  Player.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      createdAt = DateTime.parse(json['createdAt']),
      name = json['name'];

  /// Converts the Player instance to a JSON object.
  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'name': name,
  };
}
