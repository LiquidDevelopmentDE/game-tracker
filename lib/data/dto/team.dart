import 'package:clock/clock.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:uuid/uuid.dart';

class Team {
  final String id;
  final String name;
  final DateTime createdAt;
  final List<Player> members;

  Team({
    String? id,
    required this.name,
    DateTime? createdAt,
    required this.members,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? clock.now();

  @override
  String toString() {
    return 'Team{id: $id, name: $name, members: $members}';
  }

  /// Creates a Team instance from a JSON object.
  Team.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      createdAt = DateTime.parse(json['createdAt']),
      members = (json['members'] as List)
          .map((memberJson) => Player.fromJson(memberJson))
          .toList();

  /// Converts the Team instance to a JSON object.
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'members': members.map((member) => member.toJson()).toList(),
  };
}

