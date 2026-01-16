import 'package:game_tracker/data/dto/team.dart';

class Pair extends Team {
  Pair({
    super.id,
    super.createdAt,
    required super.members,
  });

  @override
  String toString() {
    return 'Pair{id: $id, members: $members}';
  }

}

