import 'package:clock/clock.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:uuid/uuid.dart';

class Group {
  final String id;
  final String name;
  final List<Player> members;
  final DateTime createdAt;

  Group({
    String? id,
    DateTime? createdAt,
    required this.name,
    required this.members,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? clock.now();

  @override
  String toString() {
    return 'Group{id: $id, name: $name,members: $members}';
  }

  /// Creates a Group instance from a JSON object.
  Group.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      members = (json['members'] as List)
          .map((memberJson) => Player.fromJson(memberJson))
          .toList();

  /// Converts the Group instance to a JSON object.
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'members': members.map((member) => member.toJson()).toList(),
  };
}
