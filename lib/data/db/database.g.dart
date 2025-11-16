// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlayerTableTable extends PlayerTable
    with TableInfo<$PlayerTableTable, PlayerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $PlayerTableTable createAlias(String alias) {
    return $PlayerTableTable(attachedDatabase, alias);
  }
}

class PlayerTableData extends DataClass implements Insertable<PlayerTableData> {
  final String id;
  final String name;
  const PlayerTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlayerTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerTableCompanion(id: Value(id), name: Value(name));
  }

  factory PlayerTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  PlayerTableData copyWith({String? id, String? name}) =>
      PlayerTableData(id: id ?? this.id, name: name ?? this.name);
  PlayerTableData copyWithCompanion(PlayerTableCompanion data) {
    return PlayerTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class PlayerTableCompanion extends UpdateCompanion<PlayerTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const PlayerTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerTableCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<PlayerTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return PlayerTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupTableTable extends GroupTable
    with TableInfo<$GroupTableTable, GroupTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $GroupTableTable createAlias(String alias) {
    return $GroupTableTable(attachedDatabase, alias);
  }
}

class GroupTableData extends DataClass implements Insertable<GroupTableData> {
  final String id;
  final String name;
  const GroupTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  GroupTableCompanion toCompanion(bool nullToAbsent) {
    return GroupTableCompanion(id: Value(id), name: Value(name));
  }

  factory GroupTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  GroupTableData copyWith({String? id, String? name}) =>
      GroupTableData(id: id ?? this.id, name: name ?? this.name);
  GroupTableData copyWithCompanion(GroupTableCompanion data) {
    return GroupTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class GroupTableCompanion extends UpdateCompanion<GroupTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const GroupTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupTableCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<GroupTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return GroupTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GameTableTable extends GameTable
    with TableInfo<$GameTableTable, GameTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _winnerIdMeta = const VerificationMeta(
    'winnerId',
  );
  @override
  late final GeneratedColumn<String> winnerId = GeneratedColumn<String>(
    'winner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES player_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, winnerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('winner_id')) {
      context.handle(
        _winnerIdMeta,
        winnerId.isAcceptableOrUnknown(data['winner_id']!, _winnerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_winnerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      winnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}winner_id'],
      )!,
    );
  }

  @override
  $GameTableTable createAlias(String alias) {
    return $GameTableTable(attachedDatabase, alias);
  }
}

class GameTableData extends DataClass implements Insertable<GameTableData> {
  final String id;
  final String name;
  final String winnerId;
  const GameTableData({
    required this.id,
    required this.name,
    required this.winnerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['winner_id'] = Variable<String>(winnerId);
    return map;
  }

  GameTableCompanion toCompanion(bool nullToAbsent) {
    return GameTableCompanion(
      id: Value(id),
      name: Value(name),
      winnerId: Value(winnerId),
    );
  }

  factory GameTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      winnerId: serializer.fromJson<String>(json['winnerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'winnerId': serializer.toJson<String>(winnerId),
    };
  }

  GameTableData copyWith({String? id, String? name, String? winnerId}) =>
      GameTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        winnerId: winnerId ?? this.winnerId,
      );
  GameTableData copyWithCompanion(GameTableCompanion data) {
    return GameTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      winnerId: data.winnerId.present ? data.winnerId.value : this.winnerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('winnerId: $winnerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, winnerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.winnerId == this.winnerId);
}

class GameTableCompanion extends UpdateCompanion<GameTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> winnerId;
  final Value<int> rowid;
  const GameTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.winnerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameTableCompanion.insert({
    required String id,
    required String name,
    required String winnerId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       winnerId = Value(winnerId);
  static Insertable<GameTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? winnerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (winnerId != null) 'winner_id': winnerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? winnerId,
    Value<int>? rowid,
  }) {
    return GameTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      winnerId: winnerId ?? this.winnerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (winnerId.present) {
      map['winner_id'] = Variable<String>(winnerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('winnerId: $winnerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayerGroupTableTable extends PlayerGroupTable
    with TableInfo<$PlayerGroupTableTable, PlayerGroupTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerGroupTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES player_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES group_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [playerId, groupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_group_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerGroupTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playerId, groupId};
  @override
  PlayerGroupTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerGroupTableData(
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      )!,
    );
  }

  @override
  $PlayerGroupTableTable createAlias(String alias) {
    return $PlayerGroupTableTable(attachedDatabase, alias);
  }
}

class PlayerGroupTableData extends DataClass
    implements Insertable<PlayerGroupTableData> {
  final String playerId;
  final String groupId;
  const PlayerGroupTableData({required this.playerId, required this.groupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['player_id'] = Variable<String>(playerId);
    map['group_id'] = Variable<String>(groupId);
    return map;
  }

  PlayerGroupTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerGroupTableCompanion(
      playerId: Value(playerId),
      groupId: Value(groupId),
    );
  }

  factory PlayerGroupTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerGroupTableData(
      playerId: serializer.fromJson<String>(json['playerId']),
      groupId: serializer.fromJson<String>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playerId': serializer.toJson<String>(playerId),
      'groupId': serializer.toJson<String>(groupId),
    };
  }

  PlayerGroupTableData copyWith({String? playerId, String? groupId}) =>
      PlayerGroupTableData(
        playerId: playerId ?? this.playerId,
        groupId: groupId ?? this.groupId,
      );
  PlayerGroupTableData copyWithCompanion(PlayerGroupTableCompanion data) {
    return PlayerGroupTableData(
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerGroupTableData(')
          ..write('playerId: $playerId, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playerId, groupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerGroupTableData &&
          other.playerId == this.playerId &&
          other.groupId == this.groupId);
}

class PlayerGroupTableCompanion extends UpdateCompanion<PlayerGroupTableData> {
  final Value<String> playerId;
  final Value<String> groupId;
  final Value<int> rowid;
  const PlayerGroupTableCompanion({
    this.playerId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerGroupTableCompanion.insert({
    required String playerId,
    required String groupId,
    this.rowid = const Value.absent(),
  }) : playerId = Value(playerId),
       groupId = Value(groupId);
  static Insertable<PlayerGroupTableData> custom({
    Expression<String>? playerId,
    Expression<String>? groupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playerId != null) 'player_id': playerId,
      if (groupId != null) 'group_id': groupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerGroupTableCompanion copyWith({
    Value<String>? playerId,
    Value<String>? groupId,
    Value<int>? rowid,
  }) {
    return PlayerGroupTableCompanion(
      playerId: playerId ?? this.playerId,
      groupId: groupId ?? this.groupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerGroupTableCompanion(')
          ..write('playerId: $playerId, ')
          ..write('groupId: $groupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayerGameTableTable extends PlayerGameTable
    with TableInfo<$PlayerGameTableTable, PlayerGameTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerGameTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES player_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [playerId, gameId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_game_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerGameTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playerId, gameId};
  @override
  PlayerGameTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerGameTableData(
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
    );
  }

  @override
  $PlayerGameTableTable createAlias(String alias) {
    return $PlayerGameTableTable(attachedDatabase, alias);
  }
}

class PlayerGameTableData extends DataClass
    implements Insertable<PlayerGameTableData> {
  final String playerId;
  final String gameId;
  const PlayerGameTableData({required this.playerId, required this.gameId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['player_id'] = Variable<String>(playerId);
    map['game_id'] = Variable<String>(gameId);
    return map;
  }

  PlayerGameTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerGameTableCompanion(
      playerId: Value(playerId),
      gameId: Value(gameId),
    );
  }

  factory PlayerGameTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerGameTableData(
      playerId: serializer.fromJson<String>(json['playerId']),
      gameId: serializer.fromJson<String>(json['gameId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playerId': serializer.toJson<String>(playerId),
      'gameId': serializer.toJson<String>(gameId),
    };
  }

  PlayerGameTableData copyWith({String? playerId, String? gameId}) =>
      PlayerGameTableData(
        playerId: playerId ?? this.playerId,
        gameId: gameId ?? this.gameId,
      );
  PlayerGameTableData copyWithCompanion(PlayerGameTableCompanion data) {
    return PlayerGameTableData(
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerGameTableData(')
          ..write('playerId: $playerId, ')
          ..write('gameId: $gameId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playerId, gameId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerGameTableData &&
          other.playerId == this.playerId &&
          other.gameId == this.gameId);
}

class PlayerGameTableCompanion extends UpdateCompanion<PlayerGameTableData> {
  final Value<String> playerId;
  final Value<String> gameId;
  final Value<int> rowid;
  const PlayerGameTableCompanion({
    this.playerId = const Value.absent(),
    this.gameId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerGameTableCompanion.insert({
    required String playerId,
    required String gameId,
    this.rowid = const Value.absent(),
  }) : playerId = Value(playerId),
       gameId = Value(gameId);
  static Insertable<PlayerGameTableData> custom({
    Expression<String>? playerId,
    Expression<String>? gameId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playerId != null) 'player_id': playerId,
      if (gameId != null) 'game_id': gameId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerGameTableCompanion copyWith({
    Value<String>? playerId,
    Value<String>? gameId,
    Value<int>? rowid,
  }) {
    return PlayerGameTableCompanion(
      playerId: playerId ?? this.playerId,
      gameId: gameId ?? this.gameId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerGameTableCompanion(')
          ..write('playerId: $playerId, ')
          ..write('gameId: $gameId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupGameTableTable extends GroupGameTable
    with TableInfo<$GroupGameTableTable, GroupGameTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupGameTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES group_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [groupId, gameId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_game_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupGameTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupId, gameId};
  @override
  GroupGameTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupGameTableData(
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
    );
  }

  @override
  $GroupGameTableTable createAlias(String alias) {
    return $GroupGameTableTable(attachedDatabase, alias);
  }
}

class GroupGameTableData extends DataClass
    implements Insertable<GroupGameTableData> {
  final String groupId;
  final String gameId;
  const GroupGameTableData({required this.groupId, required this.gameId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_id'] = Variable<String>(groupId);
    map['game_id'] = Variable<String>(gameId);
    return map;
  }

  GroupGameTableCompanion toCompanion(bool nullToAbsent) {
    return GroupGameTableCompanion(
      groupId: Value(groupId),
      gameId: Value(gameId),
    );
  }

  factory GroupGameTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupGameTableData(
      groupId: serializer.fromJson<String>(json['groupId']),
      gameId: serializer.fromJson<String>(json['gameId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupId': serializer.toJson<String>(groupId),
      'gameId': serializer.toJson<String>(gameId),
    };
  }

  GroupGameTableData copyWith({String? groupId, String? gameId}) =>
      GroupGameTableData(
        groupId: groupId ?? this.groupId,
        gameId: gameId ?? this.gameId,
      );
  GroupGameTableData copyWithCompanion(GroupGameTableCompanion data) {
    return GroupGameTableData(
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupGameTableData(')
          ..write('groupId: $groupId, ')
          ..write('gameId: $gameId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupId, gameId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupGameTableData &&
          other.groupId == this.groupId &&
          other.gameId == this.gameId);
}

class GroupGameTableCompanion extends UpdateCompanion<GroupGameTableData> {
  final Value<String> groupId;
  final Value<String> gameId;
  final Value<int> rowid;
  const GroupGameTableCompanion({
    this.groupId = const Value.absent(),
    this.gameId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupGameTableCompanion.insert({
    required String groupId,
    required String gameId,
    this.rowid = const Value.absent(),
  }) : groupId = Value(groupId),
       gameId = Value(gameId);
  static Insertable<GroupGameTableData> custom({
    Expression<String>? groupId,
    Expression<String>? gameId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (groupId != null) 'group_id': groupId,
      if (gameId != null) 'game_id': gameId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupGameTableCompanion copyWith({
    Value<String>? groupId,
    Value<String>? gameId,
    Value<int>? rowid,
  }) {
    return GroupGameTableCompanion(
      groupId: groupId ?? this.groupId,
      gameId: gameId ?? this.gameId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupGameTableCompanion(')
          ..write('groupId: $groupId, ')
          ..write('gameId: $gameId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayerTableTable playerTable = $PlayerTableTable(this);
  late final $GroupTableTable groupTable = $GroupTableTable(this);
  late final $GameTableTable gameTable = $GameTableTable(this);
  late final $PlayerGroupTableTable playerGroupTable = $PlayerGroupTableTable(
    this,
  );
  late final $PlayerGameTableTable playerGameTable = $PlayerGameTableTable(
    this,
  );
  late final $GroupGameTableTable groupGameTable = $GroupGameTableTable(this);
  late final PlayerDao playerDao = PlayerDao(this as AppDatabase);
  late final GroupDao groupDao = GroupDao(this as AppDatabase);
  late final GameDao gameDao = GameDao(this as AppDatabase);
  late final PlayerGroupDao playerGroupDao = PlayerGroupDao(
    this as AppDatabase,
  );
  late final PlayerGameDao playerGameDao = PlayerGameDao(this as AppDatabase);
  late final GroupGameDao groupGameDao = GroupGameDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    playerTable,
    groupTable,
    gameTable,
    playerGroupTable,
    playerGameTable,
    groupGameTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'player_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('game_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'player_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('player_group_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'group_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('player_group_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'player_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('player_game_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('player_game_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'group_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('group_game_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('group_game_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PlayerTableTableCreateCompanionBuilder =
    PlayerTableCompanion Function({
      required String id,
      required String name,
      Value<int> rowid,
    });
typedef $$PlayerTableTableUpdateCompanionBuilder =
    PlayerTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> rowid,
    });

final class $$PlayerTableTableReferences
    extends BaseReferences<_$AppDatabase, $PlayerTableTable, PlayerTableData> {
  $$PlayerTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GameTableTable, List<GameTableData>>
  _gameTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gameTable,
    aliasName: $_aliasNameGenerator(db.playerTable.id, db.gameTable.winnerId),
  );

  $$GameTableTableProcessedTableManager get gameTableRefs {
    final manager = $$GameTableTableTableManager(
      $_db,
      $_db.gameTable,
    ).filter((f) => f.winnerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gameTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlayerGroupTableTable, List<PlayerGroupTableData>>
  _playerGroupTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerGroupTable,
    aliasName: $_aliasNameGenerator(
      db.playerTable.id,
      db.playerGroupTable.playerId,
    ),
  );

  $$PlayerGroupTableTableProcessedTableManager get playerGroupTableRefs {
    final manager = $$PlayerGroupTableTableTableManager(
      $_db,
      $_db.playerGroupTable,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playerGroupTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlayerGameTableTable, List<PlayerGameTableData>>
  _playerGameTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerGameTable,
    aliasName: $_aliasNameGenerator(
      db.playerTable.id,
      db.playerGameTable.playerId,
    ),
  );

  $$PlayerGameTableTableProcessedTableManager get playerGameTableRefs {
    final manager = $$PlayerGameTableTableTableManager(
      $_db,
      $_db.playerGameTable,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playerGameTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayerTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gameTableRefs(
    Expression<bool> Function($$GameTableTableFilterComposer f) f,
  ) {
    final $$GameTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameTable,
      getReferencedColumn: (t) => t.winnerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameTableTableFilterComposer(
            $db: $db,
            $table: $db.gameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> playerGroupTableRefs(
    Expression<bool> Function($$PlayerGroupTableTableFilterComposer f) f,
  ) {
    final $$PlayerGroupTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGroupTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerGroupTableTableFilterComposer(
            $db: $db,
            $table: $db.playerGroupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> playerGameTableRefs(
    Expression<bool> Function($$PlayerGameTableTableFilterComposer f) f,
  ) {
    final $$PlayerGameTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGameTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerGameTableTableFilterComposer(
            $db: $db,
            $table: $db.playerGameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> gameTableRefs<T extends Object>(
    Expression<T> Function($$GameTableTableAnnotationComposer a) f,
  ) {
    final $$GameTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameTable,
      getReferencedColumn: (t) => t.winnerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameTableTableAnnotationComposer(
            $db: $db,
            $table: $db.gameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> playerGroupTableRefs<T extends Object>(
    Expression<T> Function($$PlayerGroupTableTableAnnotationComposer a) f,
  ) {
    final $$PlayerGroupTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGroupTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerGroupTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerGroupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> playerGameTableRefs<T extends Object>(
    Expression<T> Function($$PlayerGameTableTableAnnotationComposer a) f,
  ) {
    final $$PlayerGameTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGameTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerGameTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerGameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayerTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerTableTable,
          PlayerTableData,
          $$PlayerTableTableFilterComposer,
          $$PlayerTableTableOrderingComposer,
          $$PlayerTableTableAnnotationComposer,
          $$PlayerTableTableCreateCompanionBuilder,
          $$PlayerTableTableUpdateCompanionBuilder,
          (PlayerTableData, $$PlayerTableTableReferences),
          PlayerTableData,
          PrefetchHooks Function({
            bool gameTableRefs,
            bool playerGroupTableRefs,
            bool playerGameTableRefs,
          })
        > {
  $$PlayerTableTableTableManager(_$AppDatabase db, $PlayerTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerTableCompanion(id: id, name: name, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) =>
                  PlayerTableCompanion.insert(id: id, name: name, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayerTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                gameTableRefs = false,
                playerGroupTableRefs = false,
                playerGameTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (gameTableRefs) db.gameTable,
                    if (playerGroupTableRefs) db.playerGroupTable,
                    if (playerGameTableRefs) db.playerGameTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (gameTableRefs)
                        await $_getPrefetchedData<
                          PlayerTableData,
                          $PlayerTableTable,
                          GameTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PlayerTableTableReferences
                              ._gameTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayerTableTableReferences(
                                db,
                                table,
                                p0,
                              ).gameTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.winnerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (playerGroupTableRefs)
                        await $_getPrefetchedData<
                          PlayerTableData,
                          $PlayerTableTable,
                          PlayerGroupTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PlayerTableTableReferences
                              ._playerGroupTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayerTableTableReferences(
                                db,
                                table,
                                p0,
                              ).playerGroupTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (playerGameTableRefs)
                        await $_getPrefetchedData<
                          PlayerTableData,
                          $PlayerTableTable,
                          PlayerGameTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PlayerTableTableReferences
                              ._playerGameTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayerTableTableReferences(
                                db,
                                table,
                                p0,
                              ).playerGameTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlayerTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerTableTable,
      PlayerTableData,
      $$PlayerTableTableFilterComposer,
      $$PlayerTableTableOrderingComposer,
      $$PlayerTableTableAnnotationComposer,
      $$PlayerTableTableCreateCompanionBuilder,
      $$PlayerTableTableUpdateCompanionBuilder,
      (PlayerTableData, $$PlayerTableTableReferences),
      PlayerTableData,
      PrefetchHooks Function({
        bool gameTableRefs,
        bool playerGroupTableRefs,
        bool playerGameTableRefs,
      })
    >;
typedef $$GroupTableTableCreateCompanionBuilder =
    GroupTableCompanion Function({
      required String id,
      required String name,
      Value<int> rowid,
    });
typedef $$GroupTableTableUpdateCompanionBuilder =
    GroupTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> rowid,
    });

final class $$GroupTableTableReferences
    extends BaseReferences<_$AppDatabase, $GroupTableTable, GroupTableData> {
  $$GroupTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlayerGroupTableTable, List<PlayerGroupTableData>>
  _playerGroupTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerGroupTable,
    aliasName: $_aliasNameGenerator(
      db.groupTable.id,
      db.playerGroupTable.groupId,
    ),
  );

  $$PlayerGroupTableTableProcessedTableManager get playerGroupTableRefs {
    final manager = $$PlayerGroupTableTableTableManager(
      $_db,
      $_db.playerGroupTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playerGroupTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupGameTableTable, List<GroupGameTableData>>
  _groupGameTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.groupGameTable,
    aliasName: $_aliasNameGenerator(
      db.groupTable.id,
      db.groupGameTable.groupId,
    ),
  );

  $$GroupGameTableTableProcessedTableManager get groupGameTableRefs {
    final manager = $$GroupGameTableTableTableManager(
      $_db,
      $_db.groupGameTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupGameTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupTableTableFilterComposer
    extends Composer<_$AppDatabase, $GroupTableTable> {
  $$GroupTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> playerGroupTableRefs(
    Expression<bool> Function($$PlayerGroupTableTableFilterComposer f) f,
  ) {
    final $$PlayerGroupTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGroupTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerGroupTableTableFilterComposer(
            $db: $db,
            $table: $db.playerGroupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> groupGameTableRefs(
    Expression<bool> Function($$GroupGameTableTableFilterComposer f) f,
  ) {
    final $$GroupGameTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupGameTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupGameTableTableFilterComposer(
            $db: $db,
            $table: $db.groupGameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupTableTable> {
  $$GroupTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GroupTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupTableTable> {
  $$GroupTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> playerGroupTableRefs<T extends Object>(
    Expression<T> Function($$PlayerGroupTableTableAnnotationComposer a) f,
  ) {
    final $$PlayerGroupTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGroupTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerGroupTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerGroupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> groupGameTableRefs<T extends Object>(
    Expression<T> Function($$GroupGameTableTableAnnotationComposer a) f,
  ) {
    final $$GroupGameTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupGameTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupGameTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupGameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupTableTable,
          GroupTableData,
          $$GroupTableTableFilterComposer,
          $$GroupTableTableOrderingComposer,
          $$GroupTableTableAnnotationComposer,
          $$GroupTableTableCreateCompanionBuilder,
          $$GroupTableTableUpdateCompanionBuilder,
          (GroupTableData, $$GroupTableTableReferences),
          GroupTableData,
          PrefetchHooks Function({
            bool playerGroupTableRefs,
            bool groupGameTableRefs,
          })
        > {
  $$GroupTableTableTableManager(_$AppDatabase db, $GroupTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupTableCompanion(id: id, name: name, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) =>
                  GroupTableCompanion.insert(id: id, name: name, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GroupTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({playerGroupTableRefs = false, groupGameTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playerGroupTableRefs) db.playerGroupTable,
                    if (groupGameTableRefs) db.groupGameTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (playerGroupTableRefs)
                        await $_getPrefetchedData<
                          GroupTableData,
                          $GroupTableTable,
                          PlayerGroupTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GroupTableTableReferences
                              ._playerGroupTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupTableTableReferences(
                                db,
                                table,
                                p0,
                              ).playerGroupTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (groupGameTableRefs)
                        await $_getPrefetchedData<
                          GroupTableData,
                          $GroupTableTable,
                          GroupGameTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GroupTableTableReferences
                              ._groupGameTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupTableTableReferences(
                                db,
                                table,
                                p0,
                              ).groupGameTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GroupTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupTableTable,
      GroupTableData,
      $$GroupTableTableFilterComposer,
      $$GroupTableTableOrderingComposer,
      $$GroupTableTableAnnotationComposer,
      $$GroupTableTableCreateCompanionBuilder,
      $$GroupTableTableUpdateCompanionBuilder,
      (GroupTableData, $$GroupTableTableReferences),
      GroupTableData,
      PrefetchHooks Function({
        bool playerGroupTableRefs,
        bool groupGameTableRefs,
      })
    >;
typedef $$GameTableTableCreateCompanionBuilder =
    GameTableCompanion Function({
      required String id,
      required String name,
      required String winnerId,
      Value<int> rowid,
    });
typedef $$GameTableTableUpdateCompanionBuilder =
    GameTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> winnerId,
      Value<int> rowid,
    });

final class $$GameTableTableReferences
    extends BaseReferences<_$AppDatabase, $GameTableTable, GameTableData> {
  $$GameTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlayerTableTable _winnerIdTable(_$AppDatabase db) =>
      db.playerTable.createAlias(
        $_aliasNameGenerator(db.gameTable.winnerId, db.playerTable.id),
      );

  $$PlayerTableTableProcessedTableManager get winnerId {
    final $_column = $_itemColumn<String>('winner_id')!;

    final manager = $$PlayerTableTableTableManager(
      $_db,
      $_db.playerTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_winnerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlayerGameTableTable, List<PlayerGameTableData>>
  _playerGameTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerGameTable,
    aliasName: $_aliasNameGenerator(db.gameTable.id, db.playerGameTable.gameId),
  );

  $$PlayerGameTableTableProcessedTableManager get playerGameTableRefs {
    final manager = $$PlayerGameTableTableTableManager(
      $_db,
      $_db.playerGameTable,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playerGameTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupGameTableTable, List<GroupGameTableData>>
  _groupGameTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.groupGameTable,
    aliasName: $_aliasNameGenerator(db.gameTable.id, db.groupGameTable.gameId),
  );

  $$GroupGameTableTableProcessedTableManager get groupGameTableRefs {
    final manager = $$GroupGameTableTableTableManager(
      $_db,
      $_db.groupGameTable,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupGameTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GameTableTableFilterComposer
    extends Composer<_$AppDatabase, $GameTableTable> {
  $$GameTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayerTableTableFilterComposer get winnerId {
    final $$PlayerTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.winnerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableFilterComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> playerGameTableRefs(
    Expression<bool> Function($$PlayerGameTableTableFilterComposer f) f,
  ) {
    final $$PlayerGameTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGameTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerGameTableTableFilterComposer(
            $db: $db,
            $table: $db.playerGameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> groupGameTableRefs(
    Expression<bool> Function($$GroupGameTableTableFilterComposer f) f,
  ) {
    final $$GroupGameTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupGameTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupGameTableTableFilterComposer(
            $db: $db,
            $table: $db.groupGameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GameTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GameTableTable> {
  $$GameTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayerTableTableOrderingComposer get winnerId {
    final $$PlayerTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.winnerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableOrderingComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GameTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameTableTable> {
  $$GameTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$PlayerTableTableAnnotationComposer get winnerId {
    final $$PlayerTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.winnerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> playerGameTableRefs<T extends Object>(
    Expression<T> Function($$PlayerGameTableTableAnnotationComposer a) f,
  ) {
    final $$PlayerGameTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGameTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerGameTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerGameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> groupGameTableRefs<T extends Object>(
    Expression<T> Function($$GroupGameTableTableAnnotationComposer a) f,
  ) {
    final $$GroupGameTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupGameTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupGameTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupGameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GameTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameTableTable,
          GameTableData,
          $$GameTableTableFilterComposer,
          $$GameTableTableOrderingComposer,
          $$GameTableTableAnnotationComposer,
          $$GameTableTableCreateCompanionBuilder,
          $$GameTableTableUpdateCompanionBuilder,
          (GameTableData, $$GameTableTableReferences),
          GameTableData,
          PrefetchHooks Function({
            bool winnerId,
            bool playerGameTableRefs,
            bool groupGameTableRefs,
          })
        > {
  $$GameTableTableTableManager(_$AppDatabase db, $GameTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> winnerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameTableCompanion(
                id: id,
                name: name,
                winnerId: winnerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String winnerId,
                Value<int> rowid = const Value.absent(),
              }) => GameTableCompanion.insert(
                id: id,
                name: name,
                winnerId: winnerId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GameTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                winnerId = false,
                playerGameTableRefs = false,
                groupGameTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playerGameTableRefs) db.playerGameTable,
                    if (groupGameTableRefs) db.groupGameTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (winnerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.winnerId,
                                    referencedTable: $$GameTableTableReferences
                                        ._winnerIdTable(db),
                                    referencedColumn: $$GameTableTableReferences
                                        ._winnerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (playerGameTableRefs)
                        await $_getPrefetchedData<
                          GameTableData,
                          $GameTableTable,
                          PlayerGameTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GameTableTableReferences
                              ._playerGameTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameTableTableReferences(
                                db,
                                table,
                                p0,
                              ).playerGameTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gameId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (groupGameTableRefs)
                        await $_getPrefetchedData<
                          GameTableData,
                          $GameTableTable,
                          GroupGameTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GameTableTableReferences
                              ._groupGameTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameTableTableReferences(
                                db,
                                table,
                                p0,
                              ).groupGameTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gameId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GameTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameTableTable,
      GameTableData,
      $$GameTableTableFilterComposer,
      $$GameTableTableOrderingComposer,
      $$GameTableTableAnnotationComposer,
      $$GameTableTableCreateCompanionBuilder,
      $$GameTableTableUpdateCompanionBuilder,
      (GameTableData, $$GameTableTableReferences),
      GameTableData,
      PrefetchHooks Function({
        bool winnerId,
        bool playerGameTableRefs,
        bool groupGameTableRefs,
      })
    >;
typedef $$PlayerGroupTableTableCreateCompanionBuilder =
    PlayerGroupTableCompanion Function({
      required String playerId,
      required String groupId,
      Value<int> rowid,
    });
typedef $$PlayerGroupTableTableUpdateCompanionBuilder =
    PlayerGroupTableCompanion Function({
      Value<String> playerId,
      Value<String> groupId,
      Value<int> rowid,
    });

final class $$PlayerGroupTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PlayerGroupTableTable,
          PlayerGroupTableData
        > {
  $$PlayerGroupTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlayerTableTable _playerIdTable(_$AppDatabase db) =>
      db.playerTable.createAlias(
        $_aliasNameGenerator(db.playerGroupTable.playerId, db.playerTable.id),
      );

  $$PlayerTableTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager = $$PlayerTableTableTableManager(
      $_db,
      $_db.playerTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GroupTableTable _groupIdTable(_$AppDatabase db) =>
      db.groupTable.createAlias(
        $_aliasNameGenerator(db.playerGroupTable.groupId, db.groupTable.id),
      );

  $$GroupTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $$GroupTableTableTableManager(
      $_db,
      $_db.groupTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlayerGroupTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerGroupTableTable> {
  $$PlayerGroupTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlayerTableTableFilterComposer get playerId {
    final $$PlayerTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableFilterComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupTableTableFilterComposer get groupId {
    final $$GroupTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableFilterComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerGroupTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerGroupTableTable> {
  $$PlayerGroupTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlayerTableTableOrderingComposer get playerId {
    final $$PlayerTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableOrderingComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupTableTableOrderingComposer get groupId {
    final $$GroupTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableOrderingComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerGroupTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerGroupTableTable> {
  $$PlayerGroupTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlayerTableTableAnnotationComposer get playerId {
    final $$PlayerTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupTableTableAnnotationComposer get groupId {
    final $$GroupTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerGroupTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerGroupTableTable,
          PlayerGroupTableData,
          $$PlayerGroupTableTableFilterComposer,
          $$PlayerGroupTableTableOrderingComposer,
          $$PlayerGroupTableTableAnnotationComposer,
          $$PlayerGroupTableTableCreateCompanionBuilder,
          $$PlayerGroupTableTableUpdateCompanionBuilder,
          (PlayerGroupTableData, $$PlayerGroupTableTableReferences),
          PlayerGroupTableData,
          PrefetchHooks Function({bool playerId, bool groupId})
        > {
  $$PlayerGroupTableTableTableManager(
    _$AppDatabase db,
    $PlayerGroupTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerGroupTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerGroupTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerGroupTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> playerId = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerGroupTableCompanion(
                playerId: playerId,
                groupId: groupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String playerId,
                required String groupId,
                Value<int> rowid = const Value.absent(),
              }) => PlayerGroupTableCompanion.insert(
                playerId: playerId,
                groupId: groupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayerGroupTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({playerId = false, groupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable:
                                    $$PlayerGroupTableTableReferences
                                        ._playerIdTable(db),
                                referencedColumn:
                                    $$PlayerGroupTableTableReferences
                                        ._playerIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable:
                                    $$PlayerGroupTableTableReferences
                                        ._groupIdTable(db),
                                referencedColumn:
                                    $$PlayerGroupTableTableReferences
                                        ._groupIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlayerGroupTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerGroupTableTable,
      PlayerGroupTableData,
      $$PlayerGroupTableTableFilterComposer,
      $$PlayerGroupTableTableOrderingComposer,
      $$PlayerGroupTableTableAnnotationComposer,
      $$PlayerGroupTableTableCreateCompanionBuilder,
      $$PlayerGroupTableTableUpdateCompanionBuilder,
      (PlayerGroupTableData, $$PlayerGroupTableTableReferences),
      PlayerGroupTableData,
      PrefetchHooks Function({bool playerId, bool groupId})
    >;
typedef $$PlayerGameTableTableCreateCompanionBuilder =
    PlayerGameTableCompanion Function({
      required String playerId,
      required String gameId,
      Value<int> rowid,
    });
typedef $$PlayerGameTableTableUpdateCompanionBuilder =
    PlayerGameTableCompanion Function({
      Value<String> playerId,
      Value<String> gameId,
      Value<int> rowid,
    });

final class $$PlayerGameTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PlayerGameTableTable,
          PlayerGameTableData
        > {
  $$PlayerGameTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlayerTableTable _playerIdTable(_$AppDatabase db) =>
      db.playerTable.createAlias(
        $_aliasNameGenerator(db.playerGameTable.playerId, db.playerTable.id),
      );

  $$PlayerTableTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager = $$PlayerTableTableTableManager(
      $_db,
      $_db.playerTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GameTableTable _gameIdTable(_$AppDatabase db) =>
      db.gameTable.createAlias(
        $_aliasNameGenerator(db.playerGameTable.gameId, db.gameTable.id),
      );

  $$GameTableTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<String>('game_id')!;

    final manager = $$GameTableTableTableManager(
      $_db,
      $_db.gameTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlayerGameTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerGameTableTable> {
  $$PlayerGameTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlayerTableTableFilterComposer get playerId {
    final $$PlayerTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableFilterComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameTableTableFilterComposer get gameId {
    final $$GameTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameTableTableFilterComposer(
            $db: $db,
            $table: $db.gameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerGameTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerGameTableTable> {
  $$PlayerGameTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlayerTableTableOrderingComposer get playerId {
    final $$PlayerTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableOrderingComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameTableTableOrderingComposer get gameId {
    final $$GameTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameTableTableOrderingComposer(
            $db: $db,
            $table: $db.gameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerGameTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerGameTableTable> {
  $$PlayerGameTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlayerTableTableAnnotationComposer get playerId {
    final $$PlayerTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameTableTableAnnotationComposer get gameId {
    final $$GameTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameTableTableAnnotationComposer(
            $db: $db,
            $table: $db.gameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerGameTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerGameTableTable,
          PlayerGameTableData,
          $$PlayerGameTableTableFilterComposer,
          $$PlayerGameTableTableOrderingComposer,
          $$PlayerGameTableTableAnnotationComposer,
          $$PlayerGameTableTableCreateCompanionBuilder,
          $$PlayerGameTableTableUpdateCompanionBuilder,
          (PlayerGameTableData, $$PlayerGameTableTableReferences),
          PlayerGameTableData,
          PrefetchHooks Function({bool playerId, bool gameId})
        > {
  $$PlayerGameTableTableTableManager(
    _$AppDatabase db,
    $PlayerGameTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerGameTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerGameTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerGameTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> playerId = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerGameTableCompanion(
                playerId: playerId,
                gameId: gameId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String playerId,
                required String gameId,
                Value<int> rowid = const Value.absent(),
              }) => PlayerGameTableCompanion.insert(
                playerId: playerId,
                gameId: gameId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayerGameTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({playerId = false, gameId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable:
                                    $$PlayerGameTableTableReferences
                                        ._playerIdTable(db),
                                referencedColumn:
                                    $$PlayerGameTableTableReferences
                                        ._playerIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (gameId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gameId,
                                referencedTable:
                                    $$PlayerGameTableTableReferences
                                        ._gameIdTable(db),
                                referencedColumn:
                                    $$PlayerGameTableTableReferences
                                        ._gameIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlayerGameTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerGameTableTable,
      PlayerGameTableData,
      $$PlayerGameTableTableFilterComposer,
      $$PlayerGameTableTableOrderingComposer,
      $$PlayerGameTableTableAnnotationComposer,
      $$PlayerGameTableTableCreateCompanionBuilder,
      $$PlayerGameTableTableUpdateCompanionBuilder,
      (PlayerGameTableData, $$PlayerGameTableTableReferences),
      PlayerGameTableData,
      PrefetchHooks Function({bool playerId, bool gameId})
    >;
typedef $$GroupGameTableTableCreateCompanionBuilder =
    GroupGameTableCompanion Function({
      required String groupId,
      required String gameId,
      Value<int> rowid,
    });
typedef $$GroupGameTableTableUpdateCompanionBuilder =
    GroupGameTableCompanion Function({
      Value<String> groupId,
      Value<String> gameId,
      Value<int> rowid,
    });

final class $$GroupGameTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GroupGameTableTable,
          GroupGameTableData
        > {
  $$GroupGameTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GroupTableTable _groupIdTable(_$AppDatabase db) =>
      db.groupTable.createAlias(
        $_aliasNameGenerator(db.groupGameTable.groupId, db.groupTable.id),
      );

  $$GroupTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $$GroupTableTableTableManager(
      $_db,
      $_db.groupTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GameTableTable _gameIdTable(_$AppDatabase db) =>
      db.gameTable.createAlias(
        $_aliasNameGenerator(db.groupGameTable.gameId, db.gameTable.id),
      );

  $$GameTableTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<String>('game_id')!;

    final manager = $$GameTableTableTableManager(
      $_db,
      $_db.gameTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GroupGameTableTableFilterComposer
    extends Composer<_$AppDatabase, $GroupGameTableTable> {
  $$GroupGameTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GroupTableTableFilterComposer get groupId {
    final $$GroupTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableFilterComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameTableTableFilterComposer get gameId {
    final $$GameTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameTableTableFilterComposer(
            $db: $db,
            $table: $db.gameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupGameTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupGameTableTable> {
  $$GroupGameTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GroupTableTableOrderingComposer get groupId {
    final $$GroupTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableOrderingComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameTableTableOrderingComposer get gameId {
    final $$GameTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameTableTableOrderingComposer(
            $db: $db,
            $table: $db.gameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupGameTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupGameTableTable> {
  $$GroupGameTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$GroupTableTableAnnotationComposer get groupId {
    final $$GroupTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameTableTableAnnotationComposer get gameId {
    final $$GameTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameTableTableAnnotationComposer(
            $db: $db,
            $table: $db.gameTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupGameTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupGameTableTable,
          GroupGameTableData,
          $$GroupGameTableTableFilterComposer,
          $$GroupGameTableTableOrderingComposer,
          $$GroupGameTableTableAnnotationComposer,
          $$GroupGameTableTableCreateCompanionBuilder,
          $$GroupGameTableTableUpdateCompanionBuilder,
          (GroupGameTableData, $$GroupGameTableTableReferences),
          GroupGameTableData,
          PrefetchHooks Function({bool groupId, bool gameId})
        > {
  $$GroupGameTableTableTableManager(
    _$AppDatabase db,
    $GroupGameTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupGameTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupGameTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupGameTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> groupId = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupGameTableCompanion(
                groupId: groupId,
                gameId: gameId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String groupId,
                required String gameId,
                Value<int> rowid = const Value.absent(),
              }) => GroupGameTableCompanion.insert(
                groupId: groupId,
                gameId: gameId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GroupGameTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false, gameId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable: $$GroupGameTableTableReferences
                                    ._groupIdTable(db),
                                referencedColumn:
                                    $$GroupGameTableTableReferences
                                        ._groupIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (gameId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gameId,
                                referencedTable: $$GroupGameTableTableReferences
                                    ._gameIdTable(db),
                                referencedColumn:
                                    $$GroupGameTableTableReferences
                                        ._gameIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GroupGameTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupGameTableTable,
      GroupGameTableData,
      $$GroupGameTableTableFilterComposer,
      $$GroupGameTableTableOrderingComposer,
      $$GroupGameTableTableAnnotationComposer,
      $$GroupGameTableTableCreateCompanionBuilder,
      $$GroupGameTableTableUpdateCompanionBuilder,
      (GroupGameTableData, $$GroupGameTableTableReferences),
      GroupGameTableData,
      PrefetchHooks Function({bool groupId, bool gameId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayerTableTableTableManager get playerTable =>
      $$PlayerTableTableTableManager(_db, _db.playerTable);
  $$GroupTableTableTableManager get groupTable =>
      $$GroupTableTableTableManager(_db, _db.groupTable);
  $$GameTableTableTableManager get gameTable =>
      $$GameTableTableTableManager(_db, _db.gameTable);
  $$PlayerGroupTableTableTableManager get playerGroupTable =>
      $$PlayerGroupTableTableTableManager(_db, _db.playerGroupTable);
  $$PlayerGameTableTableTableManager get playerGameTable =>
      $$PlayerGameTableTableTableManager(_db, _db.playerGameTable);
  $$GroupGameTableTableTableManager get groupGameTable =>
      $$GroupGameTableTableTableManager(_db, _db.groupGameTable);
}
