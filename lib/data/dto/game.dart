import 'package:clock/clock.dart';
import 'package:uuid/uuid.dart';

class Game {
  final String id;
  final DateTime createdAt;
  final String name;
  final String? ruleset;
  final String? description;
  final int? color;
  final String? icon;

  Game({
    String? id,
    DateTime? createdAt,
    required this.name,
    this.ruleset,
    this.description,
    this.color,
    this.icon,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? clock.now();
}
