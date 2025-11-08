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

class $PlayerGroupTableTable extends PlayerGroupTable
    with TableInfo<$PlayerGroupTableTable, PlayerGroupTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerGroupTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES player_table (id)',
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
      'REFERENCES group_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [userId, groupId];
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
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {userId, groupId};
  @override
  PlayerGroupTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerGroupTableData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
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
  final String userId;
  final String groupId;
  const PlayerGroupTableData({required this.userId, required this.groupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['group_id'] = Variable<String>(groupId);
    return map;
  }

  PlayerGroupTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerGroupTableCompanion(
      userId: Value(userId),
      groupId: Value(groupId),
    );
  }

  factory PlayerGroupTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerGroupTableData(
      userId: serializer.fromJson<String>(json['userId']),
      groupId: serializer.fromJson<String>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'groupId': serializer.toJson<String>(groupId),
    };
  }

  PlayerGroupTableData copyWith({String? userId, String? groupId}) =>
      PlayerGroupTableData(
        userId: userId ?? this.userId,
        groupId: groupId ?? this.groupId,
      );
  PlayerGroupTableData copyWithCompanion(PlayerGroupTableCompanion data) {
    return PlayerGroupTableData(
      userId: data.userId.present ? data.userId.value : this.userId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerGroupTableData(')
          ..write('userId: $userId, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, groupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerGroupTableData &&
          other.userId == this.userId &&
          other.groupId == this.groupId);
}

class PlayerGroupTableCompanion extends UpdateCompanion<PlayerGroupTableData> {
  final Value<String> userId;
  final Value<String> groupId;
  final Value<int> rowid;
  const PlayerGroupTableCompanion({
    this.userId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerGroupTableCompanion.insert({
    required String userId,
    required String groupId,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       groupId = Value(groupId);
  static Insertable<PlayerGroupTableData> custom({
    Expression<String>? userId,
    Expression<String>? groupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (groupId != null) 'group_id': groupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerGroupTableCompanion copyWith({
    Value<String>? userId,
    Value<String>? groupId,
    Value<int>? rowid,
  }) {
    return PlayerGroupTableCompanion(
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
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
          ..write('userId: $userId, ')
          ..write('groupId: $groupId, ')
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
  @override
  List<GeneratedColumn> get $columns => [id, name];
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
  const GameTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  GameTableCompanion toCompanion(bool nullToAbsent) {
    return GameTableCompanion(id: Value(id), name: Value(name));
  }

  factory GameTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameTableData(
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

  GameTableData copyWith({String? id, String? name}) =>
      GameTableData(id: id ?? this.id, name: name ?? this.name);
  GameTableData copyWithCompanion(GameTableCompanion data) {
    return GameTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameTableData(')
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
      (other is GameTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class GameTableCompanion extends UpdateCompanion<GameTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const GameTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameTableCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<GameTableData> custom({
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

  GameTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return GameTableCompanion(
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
    return (StringBuffer('GameTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
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
  late final $PlayerGroupTableTable playerGroupTable = $PlayerGroupTableTable(
    this,
  );
  late final $GameTableTable gameTable = $GameTableTable(this);
  late final GroupDao groupDao = GroupDao(this as AppDatabase);
  late final PlayerDao playerDao = PlayerDao(this as AppDatabase);
  late final PlayerGroupDao playerGroupDao = PlayerGroupDao(
    this as AppDatabase,
  );
  late final GameDao gameDao = GameDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    playerTable,
    groupTable,
    playerGroupTable,
    gameTable,
  ];
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

  static MultiTypedResultKey<$PlayerGroupTableTable, List<PlayerGroupTableData>>
  _playerGroupTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerGroupTable,
    aliasName: $_aliasNameGenerator(
      db.playerTable.id,
      db.playerGroupTable.userId,
    ),
  );

  $$PlayerGroupTableTableProcessedTableManager get playerGroupTableRefs {
    final manager = $$PlayerGroupTableTableTableManager(
      $_db,
      $_db.playerGroupTable,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playerGroupTableRefsTable($_db),
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

  Expression<bool> playerGroupTableRefs(
    Expression<bool> Function($$PlayerGroupTableTableFilterComposer f) f,
  ) {
    final $$PlayerGroupTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGroupTable,
      getReferencedColumn: (t) => t.userId,
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

  Expression<T> playerGroupTableRefs<T extends Object>(
    Expression<T> Function($$PlayerGroupTableTableAnnotationComposer a) f,
  ) {
    final $$PlayerGroupTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerGroupTable,
      getReferencedColumn: (t) => t.userId,
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
          PrefetchHooks Function({bool playerGroupTableRefs})
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
          prefetchHooksCallback: ({playerGroupTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playerGroupTableRefs) db.playerGroupTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
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
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
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
      PrefetchHooks Function({bool playerGroupTableRefs})
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
          PrefetchHooks Function({bool playerGroupTableRefs})
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
          prefetchHooksCallback: ({playerGroupTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playerGroupTableRefs) db.playerGroupTable,
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
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
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
      PrefetchHooks Function({bool playerGroupTableRefs})
    >;
typedef $$PlayerGroupTableTableCreateCompanionBuilder =
    PlayerGroupTableCompanion Function({
      required String userId,
      required String groupId,
      Value<int> rowid,
    });
typedef $$PlayerGroupTableTableUpdateCompanionBuilder =
    PlayerGroupTableCompanion Function({
      Value<String> userId,
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

  static $PlayerTableTable _userIdTable(_$AppDatabase db) =>
      db.playerTable.createAlias(
        $_aliasNameGenerator(db.playerGroupTable.userId, db.playerTable.id),
      );

  $$PlayerTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$PlayerTableTableTableManager(
      $_db,
      $_db.playerTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
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
  $$PlayerTableTableFilterComposer get userId {
    final $$PlayerTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
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
  $$PlayerTableTableOrderingComposer get userId {
    final $$PlayerTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
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
  $$PlayerTableTableAnnotationComposer get userId {
    final $$PlayerTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
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
          PrefetchHooks Function({bool userId, bool groupId})
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
                Value<String> userId = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerGroupTableCompanion(
                userId: userId,
                groupId: groupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String groupId,
                Value<int> rowid = const Value.absent(),
              }) => PlayerGroupTableCompanion.insert(
                userId: userId,
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
          prefetchHooksCallback: ({userId = false, groupId = false}) {
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
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$PlayerGroupTableTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$PlayerGroupTableTableReferences
                                        ._userIdTable(db)
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
      PrefetchHooks Function({bool userId, bool groupId})
    >;
typedef $$GameTableTableCreateCompanionBuilder =
    GameTableCompanion Function({
      required String id,
      required String name,
      Value<int> rowid,
    });
typedef $$GameTableTableUpdateCompanionBuilder =
    GameTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> rowid,
    });

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
          (
            GameTableData,
            BaseReferences<_$AppDatabase, $GameTableTable, GameTableData>,
          ),
          GameTableData,
          PrefetchHooks Function()
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
                Value<int> rowid = const Value.absent(),
              }) => GameTableCompanion(id: id, name: name, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => GameTableCompanion.insert(id: id, name: name, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        GameTableData,
        BaseReferences<_$AppDatabase, $GameTableTable, GameTableData>,
      ),
      GameTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayerTableTableTableManager get playerTable =>
      $$PlayerTableTableTableManager(_db, _db.playerTable);
  $$GroupTableTableTableManager get groupTable =>
      $$GroupTableTableTableManager(_db, _db.groupTable);
  $$PlayerGroupTableTableTableManager get playerGroupTable =>
      $$PlayerGroupTableTableTableManager(_db, _db.playerGroupTable);
  $$GameTableTableTableManager get gameTable =>
      $$GameTableTableTableManager(_db, _db.gameTable);
}
