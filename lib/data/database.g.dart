// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _surnameMeta = const VerificationMeta(
    'surname',
  );
  @override
  late final GeneratedColumn<String> surname = GeneratedColumn<String>(
    'surname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, surname];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserTableData> instance, {
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
    if (data.containsKey('surname')) {
      context.handle(
        _surnameMeta,
        surname.isAcceptableOrUnknown(data['surname']!, _surnameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      surname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surname'],
      ),
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final String id;
  final String name;
  final String? surname;
  const UserTableData({required this.id, required this.name, this.surname});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || surname != null) {
      map['surname'] = Variable<String>(surname);
    }
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      name: Value(name),
      surname: surname == null && nullToAbsent
          ? const Value.absent()
          : Value(surname),
    );
  }

  factory UserTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      surname: serializer.fromJson<String?>(json['surname']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'surname': serializer.toJson<String?>(surname),
    };
  }

  UserTableData copyWith({
    String? id,
    String? name,
    Value<String?> surname = const Value.absent(),
  }) => UserTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    surname: surname.present ? surname.value : this.surname,
  );
  UserTableData copyWithCompanion(UserTableCompanion data) {
    return UserTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      surname: data.surname.present ? data.surname.value : this.surname,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('surname: $surname')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, surname);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.surname == this.surname);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> surname;
  final Value<int> rowid;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.surname = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserTableCompanion.insert({
    required String id,
    required String name,
    this.surname = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<UserTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? surname,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? surname,
    Value<int>? rowid,
  }) {
    return UserTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
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
    if (surname.present) {
      map['surname'] = Variable<String>(surname.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('surname: $surname, ')
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

class $UserGroupTableTable extends UserGroupTable
    with TableInfo<$UserGroupTableTable, UserGroupTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserGroupTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_table (id)',
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
  static const String $name = 'user_group_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserGroupTableData> instance, {
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
  UserGroupTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserGroupTableData(
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
  $UserGroupTableTable createAlias(String alias) {
    return $UserGroupTableTable(attachedDatabase, alias);
  }
}

class UserGroupTableData extends DataClass
    implements Insertable<UserGroupTableData> {
  final String userId;
  final String groupId;
  const UserGroupTableData({required this.userId, required this.groupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['group_id'] = Variable<String>(groupId);
    return map;
  }

  UserGroupTableCompanion toCompanion(bool nullToAbsent) {
    return UserGroupTableCompanion(
      userId: Value(userId),
      groupId: Value(groupId),
    );
  }

  factory UserGroupTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserGroupTableData(
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

  UserGroupTableData copyWith({String? userId, String? groupId}) =>
      UserGroupTableData(
        userId: userId ?? this.userId,
        groupId: groupId ?? this.groupId,
      );
  UserGroupTableData copyWithCompanion(UserGroupTableCompanion data) {
    return UserGroupTableData(
      userId: data.userId.present ? data.userId.value : this.userId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserGroupTableData(')
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
      (other is UserGroupTableData &&
          other.userId == this.userId &&
          other.groupId == this.groupId);
}

class UserGroupTableCompanion extends UpdateCompanion<UserGroupTableData> {
  final Value<String> userId;
  final Value<String> groupId;
  final Value<int> rowid;
  const UserGroupTableCompanion({
    this.userId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserGroupTableCompanion.insert({
    required String userId,
    required String groupId,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       groupId = Value(groupId);
  static Insertable<UserGroupTableData> custom({
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

  UserGroupTableCompanion copyWith({
    Value<String>? userId,
    Value<String>? groupId,
    Value<int>? rowid,
  }) {
    return UserGroupTableCompanion(
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
    return (StringBuffer('UserGroupTableCompanion(')
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
        DriftSqlType.int,
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
  final int id;
  final String name;
  const GameTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
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
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  GameTableData copyWith({int? id, String? name}) =>
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
  final Value<int> id;
  final Value<String> name;
  const GameTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  GameTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<GameTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  GameTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return GameTableCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $MatchTableTable extends MatchTable
    with TableInfo<$MatchTableTable, MatchTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<int> gameId = GeneratedColumn<int>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_table (id)',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES group_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, gameId, groupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}game_id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      ),
    );
  }

  @override
  $MatchTableTable createAlias(String alias) {
    return $MatchTableTable(attachedDatabase, alias);
  }
}

class MatchTableData extends DataClass implements Insertable<MatchTableData> {
  final String id;
  final int gameId;
  final String? groupId;
  const MatchTableData({required this.id, required this.gameId, this.groupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['game_id'] = Variable<int>(gameId);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    return map;
  }

  MatchTableCompanion toCompanion(bool nullToAbsent) {
    return MatchTableCompanion(
      id: Value(id),
      gameId: Value(gameId),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
    );
  }

  factory MatchTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchTableData(
      id: serializer.fromJson<String>(json['id']),
      gameId: serializer.fromJson<int>(json['gameId']),
      groupId: serializer.fromJson<String?>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gameId': serializer.toJson<int>(gameId),
      'groupId': serializer.toJson<String?>(groupId),
    };
  }

  MatchTableData copyWith({
    String? id,
    int? gameId,
    Value<String?> groupId = const Value.absent(),
  }) => MatchTableData(
    id: id ?? this.id,
    gameId: gameId ?? this.gameId,
    groupId: groupId.present ? groupId.value : this.groupId,
  );
  MatchTableData copyWithCompanion(MatchTableCompanion data) {
    return MatchTableData(
      id: data.id.present ? data.id.value : this.id,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchTableData(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gameId, groupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchTableData &&
          other.id == this.id &&
          other.gameId == this.gameId &&
          other.groupId == this.groupId);
}

class MatchTableCompanion extends UpdateCompanion<MatchTableData> {
  final Value<String> id;
  final Value<int> gameId;
  final Value<String?> groupId;
  final Value<int> rowid;
  const MatchTableCompanion({
    this.id = const Value.absent(),
    this.gameId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatchTableCompanion.insert({
    required String id,
    required int gameId,
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gameId = Value(gameId);
  static Insertable<MatchTableData> custom({
    Expression<String>? id,
    Expression<int>? gameId,
    Expression<String>? groupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameId != null) 'game_id': gameId,
      if (groupId != null) 'group_id': groupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatchTableCompanion copyWith({
    Value<String>? id,
    Value<int>? gameId,
    Value<String?>? groupId,
    Value<int>? rowid,
  }) {
    return MatchTableCompanion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      groupId: groupId ?? this.groupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<int>(gameId.value);
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
    return (StringBuffer('MatchTableCompanion(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('groupId: $groupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ResultScoreTableTable extends ResultScoreTable
    with TableInfo<$ResultScoreTableTable, ResultScoreTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResultScoreTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<String> matchId = GeneratedColumn<String>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES match_table (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_table (id)',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [matchId, userId, score];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'result_score_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResultScoreTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {matchId, userId};
  @override
  ResultScoreTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResultScoreTableData(
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
    );
  }

  @override
  $ResultScoreTableTable createAlias(String alias) {
    return $ResultScoreTableTable(attachedDatabase, alias);
  }
}

class ResultScoreTableData extends DataClass
    implements Insertable<ResultScoreTableData> {
  final String matchId;
  final String userId;
  final int score;
  const ResultScoreTableData({
    required this.matchId,
    required this.userId,
    required this.score,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['match_id'] = Variable<String>(matchId);
    map['user_id'] = Variable<String>(userId);
    map['score'] = Variable<int>(score);
    return map;
  }

  ResultScoreTableCompanion toCompanion(bool nullToAbsent) {
    return ResultScoreTableCompanion(
      matchId: Value(matchId),
      userId: Value(userId),
      score: Value(score),
    );
  }

  factory ResultScoreTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResultScoreTableData(
      matchId: serializer.fromJson<String>(json['matchId']),
      userId: serializer.fromJson<String>(json['userId']),
      score: serializer.fromJson<int>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'matchId': serializer.toJson<String>(matchId),
      'userId': serializer.toJson<String>(userId),
      'score': serializer.toJson<int>(score),
    };
  }

  ResultScoreTableData copyWith({
    String? matchId,
    String? userId,
    int? score,
  }) => ResultScoreTableData(
    matchId: matchId ?? this.matchId,
    userId: userId ?? this.userId,
    score: score ?? this.score,
  );
  ResultScoreTableData copyWithCompanion(ResultScoreTableCompanion data) {
    return ResultScoreTableData(
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      userId: data.userId.present ? data.userId.value : this.userId,
      score: data.score.present ? data.score.value : this.score,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResultScoreTableData(')
          ..write('matchId: $matchId, ')
          ..write('userId: $userId, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(matchId, userId, score);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResultScoreTableData &&
          other.matchId == this.matchId &&
          other.userId == this.userId &&
          other.score == this.score);
}

class ResultScoreTableCompanion extends UpdateCompanion<ResultScoreTableData> {
  final Value<String> matchId;
  final Value<String> userId;
  final Value<int> score;
  final Value<int> rowid;
  const ResultScoreTableCompanion({
    this.matchId = const Value.absent(),
    this.userId = const Value.absent(),
    this.score = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ResultScoreTableCompanion.insert({
    required String matchId,
    required String userId,
    required int score,
    this.rowid = const Value.absent(),
  }) : matchId = Value(matchId),
       userId = Value(userId),
       score = Value(score);
  static Insertable<ResultScoreTableData> custom({
    Expression<String>? matchId,
    Expression<String>? userId,
    Expression<int>? score,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (matchId != null) 'match_id': matchId,
      if (userId != null) 'user_id': userId,
      if (score != null) 'score': score,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ResultScoreTableCompanion copyWith({
    Value<String>? matchId,
    Value<String>? userId,
    Value<int>? score,
    Value<int>? rowid,
  }) {
    return ResultScoreTableCompanion(
      matchId: matchId ?? this.matchId,
      userId: userId ?? this.userId,
      score: score ?? this.score,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (matchId.present) {
      map['match_id'] = Variable<String>(matchId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResultScoreTableCompanion(')
          ..write('matchId: $matchId, ')
          ..write('userId: $userId, ')
          ..write('score: $score, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ResultWinTableTable extends ResultWinTable
    with TableInfo<$ResultWinTableTable, ResultWinTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResultWinTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<String> matchId = GeneratedColumn<String>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES match_table (id)',
    ),
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
      'REFERENCES user_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [matchId, winnerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'result_win_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResultWinTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {matchId, winnerId};
  @override
  ResultWinTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResultWinTableData(
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_id'],
      )!,
      winnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}winner_id'],
      )!,
    );
  }

  @override
  $ResultWinTableTable createAlias(String alias) {
    return $ResultWinTableTable(attachedDatabase, alias);
  }
}

class ResultWinTableData extends DataClass
    implements Insertable<ResultWinTableData> {
  final String matchId;
  final String winnerId;
  const ResultWinTableData({required this.matchId, required this.winnerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['match_id'] = Variable<String>(matchId);
    map['winner_id'] = Variable<String>(winnerId);
    return map;
  }

  ResultWinTableCompanion toCompanion(bool nullToAbsent) {
    return ResultWinTableCompanion(
      matchId: Value(matchId),
      winnerId: Value(winnerId),
    );
  }

  factory ResultWinTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResultWinTableData(
      matchId: serializer.fromJson<String>(json['matchId']),
      winnerId: serializer.fromJson<String>(json['winnerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'matchId': serializer.toJson<String>(matchId),
      'winnerId': serializer.toJson<String>(winnerId),
    };
  }

  ResultWinTableData copyWith({String? matchId, String? winnerId}) =>
      ResultWinTableData(
        matchId: matchId ?? this.matchId,
        winnerId: winnerId ?? this.winnerId,
      );
  ResultWinTableData copyWithCompanion(ResultWinTableCompanion data) {
    return ResultWinTableData(
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      winnerId: data.winnerId.present ? data.winnerId.value : this.winnerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResultWinTableData(')
          ..write('matchId: $matchId, ')
          ..write('winnerId: $winnerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(matchId, winnerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResultWinTableData &&
          other.matchId == this.matchId &&
          other.winnerId == this.winnerId);
}

class ResultWinTableCompanion extends UpdateCompanion<ResultWinTableData> {
  final Value<String> matchId;
  final Value<String> winnerId;
  final Value<int> rowid;
  const ResultWinTableCompanion({
    this.matchId = const Value.absent(),
    this.winnerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ResultWinTableCompanion.insert({
    required String matchId,
    required String winnerId,
    this.rowid = const Value.absent(),
  }) : matchId = Value(matchId),
       winnerId = Value(winnerId);
  static Insertable<ResultWinTableData> custom({
    Expression<String>? matchId,
    Expression<String>? winnerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (matchId != null) 'match_id': matchId,
      if (winnerId != null) 'winner_id': winnerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ResultWinTableCompanion copyWith({
    Value<String>? matchId,
    Value<String>? winnerId,
    Value<int>? rowid,
  }) {
    return ResultWinTableCompanion(
      matchId: matchId ?? this.matchId,
      winnerId: winnerId ?? this.winnerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (matchId.present) {
      map['match_id'] = Variable<String>(matchId.value);
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
    return (StringBuffer('ResultWinTableCompanion(')
          ..write('matchId: $matchId, ')
          ..write('winnerId: $winnerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ResultPlacementTableTable extends ResultPlacementTable
    with TableInfo<$ResultPlacementTableTable, ResultPlacementTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResultPlacementTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<String> matchId = GeneratedColumn<String>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES match_table (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_table (id)',
    ),
  );
  static const VerificationMeta _placementMeta = const VerificationMeta(
    'placement',
  );
  @override
  late final GeneratedColumn<int> placement = GeneratedColumn<int>(
    'placement',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [matchId, userId, placement];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'result_placement_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResultPlacementTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('placement')) {
      context.handle(
        _placementMeta,
        placement.isAcceptableOrUnknown(data['placement']!, _placementMeta),
      );
    } else if (isInserting) {
      context.missing(_placementMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {matchId, userId};
  @override
  ResultPlacementTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResultPlacementTableData(
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      placement: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}placement'],
      )!,
    );
  }

  @override
  $ResultPlacementTableTable createAlias(String alias) {
    return $ResultPlacementTableTable(attachedDatabase, alias);
  }
}

class ResultPlacementTableData extends DataClass
    implements Insertable<ResultPlacementTableData> {
  final String matchId;
  final String userId;
  final int placement;
  const ResultPlacementTableData({
    required this.matchId,
    required this.userId,
    required this.placement,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['match_id'] = Variable<String>(matchId);
    map['user_id'] = Variable<String>(userId);
    map['placement'] = Variable<int>(placement);
    return map;
  }

  ResultPlacementTableCompanion toCompanion(bool nullToAbsent) {
    return ResultPlacementTableCompanion(
      matchId: Value(matchId),
      userId: Value(userId),
      placement: Value(placement),
    );
  }

  factory ResultPlacementTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResultPlacementTableData(
      matchId: serializer.fromJson<String>(json['matchId']),
      userId: serializer.fromJson<String>(json['userId']),
      placement: serializer.fromJson<int>(json['placement']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'matchId': serializer.toJson<String>(matchId),
      'userId': serializer.toJson<String>(userId),
      'placement': serializer.toJson<int>(placement),
    };
  }

  ResultPlacementTableData copyWith({
    String? matchId,
    String? userId,
    int? placement,
  }) => ResultPlacementTableData(
    matchId: matchId ?? this.matchId,
    userId: userId ?? this.userId,
    placement: placement ?? this.placement,
  );
  ResultPlacementTableData copyWithCompanion(
    ResultPlacementTableCompanion data,
  ) {
    return ResultPlacementTableData(
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      userId: data.userId.present ? data.userId.value : this.userId,
      placement: data.placement.present ? data.placement.value : this.placement,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResultPlacementTableData(')
          ..write('matchId: $matchId, ')
          ..write('userId: $userId, ')
          ..write('placement: $placement')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(matchId, userId, placement);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResultPlacementTableData &&
          other.matchId == this.matchId &&
          other.userId == this.userId &&
          other.placement == this.placement);
}

class ResultPlacementTableCompanion
    extends UpdateCompanion<ResultPlacementTableData> {
  final Value<String> matchId;
  final Value<String> userId;
  final Value<int> placement;
  final Value<int> rowid;
  const ResultPlacementTableCompanion({
    this.matchId = const Value.absent(),
    this.userId = const Value.absent(),
    this.placement = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ResultPlacementTableCompanion.insert({
    required String matchId,
    required String userId,
    required int placement,
    this.rowid = const Value.absent(),
  }) : matchId = Value(matchId),
       userId = Value(userId),
       placement = Value(placement);
  static Insertable<ResultPlacementTableData> custom({
    Expression<String>? matchId,
    Expression<String>? userId,
    Expression<int>? placement,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (matchId != null) 'match_id': matchId,
      if (userId != null) 'user_id': userId,
      if (placement != null) 'placement': placement,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ResultPlacementTableCompanion copyWith({
    Value<String>? matchId,
    Value<String>? userId,
    Value<int>? placement,
    Value<int>? rowid,
  }) {
    return ResultPlacementTableCompanion(
      matchId: matchId ?? this.matchId,
      userId: userId ?? this.userId,
      placement: placement ?? this.placement,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (matchId.present) {
      map['match_id'] = Variable<String>(matchId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (placement.present) {
      map['placement'] = Variable<int>(placement.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResultPlacementTableCompanion(')
          ..write('matchId: $matchId, ')
          ..write('userId: $userId, ')
          ..write('placement: $placement, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $GroupTableTable groupTable = $GroupTableTable(this);
  late final $UserGroupTableTable userGroupTable = $UserGroupTableTable(this);
  late final $GameTableTable gameTable = $GameTableTable(this);
  late final $MatchTableTable matchTable = $MatchTableTable(this);
  late final $ResultScoreTableTable resultScoreTable = $ResultScoreTableTable(
    this,
  );
  late final $ResultWinTableTable resultWinTable = $ResultWinTableTable(this);
  late final $ResultPlacementTableTable resultPlacementTable =
      $ResultPlacementTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userTable,
    groupTable,
    userGroupTable,
    gameTable,
    matchTable,
    resultScoreTable,
    resultWinTable,
    resultPlacementTable,
  ];
}

typedef $$UserTableTableCreateCompanionBuilder =
    UserTableCompanion Function({
      required String id,
      required String name,
      Value<String?> surname,
      Value<int> rowid,
    });
typedef $$UserTableTableUpdateCompanionBuilder =
    UserTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> surname,
      Value<int> rowid,
    });

final class $$UserTableTableReferences
    extends BaseReferences<_$AppDatabase, $UserTableTable, UserTableData> {
  $$UserTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserGroupTableTable, List<UserGroupTableData>>
  _userGroupTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userGroupTable,
    aliasName: $_aliasNameGenerator(db.userTable.id, db.userGroupTable.userId),
  );

  $$UserGroupTableTableProcessedTableManager get userGroupTableRefs {
    final manager = $$UserGroupTableTableTableManager(
      $_db,
      $_db.userGroupTable,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userGroupTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ResultScoreTableTable, List<ResultScoreTableData>>
  _resultScoreTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.resultScoreTable,
    aliasName: $_aliasNameGenerator(
      db.userTable.id,
      db.resultScoreTable.userId,
    ),
  );

  $$ResultScoreTableTableProcessedTableManager get resultScoreTableRefs {
    final manager = $$ResultScoreTableTableTableManager(
      $_db,
      $_db.resultScoreTable,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _resultScoreTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ResultWinTableTable, List<ResultWinTableData>>
  _resultWinTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.resultWinTable,
    aliasName: $_aliasNameGenerator(
      db.userTable.id,
      db.resultWinTable.winnerId,
    ),
  );

  $$ResultWinTableTableProcessedTableManager get resultWinTableRefs {
    final manager = $$ResultWinTableTableTableManager(
      $_db,
      $_db.resultWinTable,
    ).filter((f) => f.winnerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_resultWinTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ResultPlacementTableTable,
    List<ResultPlacementTableData>
  >
  _resultPlacementTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.resultPlacementTable,
        aliasName: $_aliasNameGenerator(
          db.userTable.id,
          db.resultPlacementTable.userId,
        ),
      );

  $$ResultPlacementTableTableProcessedTableManager
  get resultPlacementTableRefs {
    final manager = $$ResultPlacementTableTableTableManager(
      $_db,
      $_db.resultPlacementTable,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _resultPlacementTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableFilterComposer({
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

  ColumnFilters<String> get surname => $composableBuilder(
    column: $table.surname,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userGroupTableRefs(
    Expression<bool> Function($$UserGroupTableTableFilterComposer f) f,
  ) {
    final $$UserGroupTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userGroupTable,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserGroupTableTableFilterComposer(
            $db: $db,
            $table: $db.userGroupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> resultScoreTableRefs(
    Expression<bool> Function($$ResultScoreTableTableFilterComposer f) f,
  ) {
    final $$ResultScoreTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultScoreTable,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultScoreTableTableFilterComposer(
            $db: $db,
            $table: $db.resultScoreTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> resultWinTableRefs(
    Expression<bool> Function($$ResultWinTableTableFilterComposer f) f,
  ) {
    final $$ResultWinTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultWinTable,
      getReferencedColumn: (t) => t.winnerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultWinTableTableFilterComposer(
            $db: $db,
            $table: $db.resultWinTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> resultPlacementTableRefs(
    Expression<bool> Function($$ResultPlacementTableTableFilterComposer f) f,
  ) {
    final $$ResultPlacementTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultPlacementTable,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultPlacementTableTableFilterComposer(
            $db: $db,
            $table: $db.resultPlacementTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableOrderingComposer({
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

  ColumnOrderings<String> get surname => $composableBuilder(
    column: $table.surname,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
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

  GeneratedColumn<String> get surname =>
      $composableBuilder(column: $table.surname, builder: (column) => column);

  Expression<T> userGroupTableRefs<T extends Object>(
    Expression<T> Function($$UserGroupTableTableAnnotationComposer a) f,
  ) {
    final $$UserGroupTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userGroupTable,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserGroupTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userGroupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> resultScoreTableRefs<T extends Object>(
    Expression<T> Function($$ResultScoreTableTableAnnotationComposer a) f,
  ) {
    final $$ResultScoreTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultScoreTable,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultScoreTableTableAnnotationComposer(
            $db: $db,
            $table: $db.resultScoreTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> resultWinTableRefs<T extends Object>(
    Expression<T> Function($$ResultWinTableTableAnnotationComposer a) f,
  ) {
    final $$ResultWinTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultWinTable,
      getReferencedColumn: (t) => t.winnerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultWinTableTableAnnotationComposer(
            $db: $db,
            $table: $db.resultWinTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> resultPlacementTableRefs<T extends Object>(
    Expression<T> Function($$ResultPlacementTableTableAnnotationComposer a) f,
  ) {
    final $$ResultPlacementTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.resultPlacementTable,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ResultPlacementTableTableAnnotationComposer(
                $db: $db,
                $table: $db.resultPlacementTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UserTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserTableTable,
          UserTableData,
          $$UserTableTableFilterComposer,
          $$UserTableTableOrderingComposer,
          $$UserTableTableAnnotationComposer,
          $$UserTableTableCreateCompanionBuilder,
          $$UserTableTableUpdateCompanionBuilder,
          (UserTableData, $$UserTableTableReferences),
          UserTableData,
          PrefetchHooks Function({
            bool userGroupTableRefs,
            bool resultScoreTableRefs,
            bool resultWinTableRefs,
            bool resultPlacementTableRefs,
          })
        > {
  $$UserTableTableTableManager(_$AppDatabase db, $UserTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> surname = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserTableCompanion(
                id: id,
                name: name,
                surname: surname,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> surname = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserTableCompanion.insert(
                id: id,
                name: name,
                surname: surname,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userGroupTableRefs = false,
                resultScoreTableRefs = false,
                resultWinTableRefs = false,
                resultPlacementTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userGroupTableRefs) db.userGroupTable,
                    if (resultScoreTableRefs) db.resultScoreTable,
                    if (resultWinTableRefs) db.resultWinTable,
                    if (resultPlacementTableRefs) db.resultPlacementTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userGroupTableRefs)
                        await $_getPrefetchedData<
                          UserTableData,
                          $UserTableTable,
                          UserGroupTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserTableTableReferences
                              ._userGroupTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserTableTableReferences(
                                db,
                                table,
                                p0,
                              ).userGroupTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (resultScoreTableRefs)
                        await $_getPrefetchedData<
                          UserTableData,
                          $UserTableTable,
                          ResultScoreTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserTableTableReferences
                              ._resultScoreTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserTableTableReferences(
                                db,
                                table,
                                p0,
                              ).resultScoreTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (resultWinTableRefs)
                        await $_getPrefetchedData<
                          UserTableData,
                          $UserTableTable,
                          ResultWinTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserTableTableReferences
                              ._resultWinTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserTableTableReferences(
                                db,
                                table,
                                p0,
                              ).resultWinTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.winnerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (resultPlacementTableRefs)
                        await $_getPrefetchedData<
                          UserTableData,
                          $UserTableTable,
                          ResultPlacementTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserTableTableReferences
                              ._resultPlacementTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserTableTableReferences(
                                db,
                                table,
                                p0,
                              ).resultPlacementTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
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

typedef $$UserTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserTableTable,
      UserTableData,
      $$UserTableTableFilterComposer,
      $$UserTableTableOrderingComposer,
      $$UserTableTableAnnotationComposer,
      $$UserTableTableCreateCompanionBuilder,
      $$UserTableTableUpdateCompanionBuilder,
      (UserTableData, $$UserTableTableReferences),
      UserTableData,
      PrefetchHooks Function({
        bool userGroupTableRefs,
        bool resultScoreTableRefs,
        bool resultWinTableRefs,
        bool resultPlacementTableRefs,
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

  static MultiTypedResultKey<$UserGroupTableTable, List<UserGroupTableData>>
  _userGroupTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userGroupTable,
    aliasName: $_aliasNameGenerator(
      db.groupTable.id,
      db.userGroupTable.groupId,
    ),
  );

  $$UserGroupTableTableProcessedTableManager get userGroupTableRefs {
    final manager = $$UserGroupTableTableTableManager(
      $_db,
      $_db.userGroupTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userGroupTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MatchTableTable, List<MatchTableData>>
  _matchTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchTable,
    aliasName: $_aliasNameGenerator(db.groupTable.id, db.matchTable.groupId),
  );

  $$MatchTableTableProcessedTableManager get matchTableRefs {
    final manager = $$MatchTableTableTableManager(
      $_db,
      $_db.matchTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchTableRefsTable($_db));
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

  Expression<bool> userGroupTableRefs(
    Expression<bool> Function($$UserGroupTableTableFilterComposer f) f,
  ) {
    final $$UserGroupTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userGroupTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserGroupTableTableFilterComposer(
            $db: $db,
            $table: $db.userGroupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> matchTableRefs(
    Expression<bool> Function($$MatchTableTableFilterComposer f) f,
  ) {
    final $$MatchTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableFilterComposer(
            $db: $db,
            $table: $db.matchTable,
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

  Expression<T> userGroupTableRefs<T extends Object>(
    Expression<T> Function($$UserGroupTableTableAnnotationComposer a) f,
  ) {
    final $$UserGroupTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userGroupTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserGroupTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userGroupTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> matchTableRefs<T extends Object>(
    Expression<T> Function($$MatchTableTableAnnotationComposer a) f,
  ) {
    final $$MatchTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableAnnotationComposer(
            $db: $db,
            $table: $db.matchTable,
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
          PrefetchHooks Function({bool userGroupTableRefs, bool matchTableRefs})
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
              ({userGroupTableRefs = false, matchTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userGroupTableRefs) db.userGroupTable,
                    if (matchTableRefs) db.matchTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userGroupTableRefs)
                        await $_getPrefetchedData<
                          GroupTableData,
                          $GroupTableTable,
                          UserGroupTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GroupTableTableReferences
                              ._userGroupTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupTableTableReferences(
                                db,
                                table,
                                p0,
                              ).userGroupTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (matchTableRefs)
                        await $_getPrefetchedData<
                          GroupTableData,
                          $GroupTableTable,
                          MatchTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GroupTableTableReferences
                              ._matchTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupTableTableReferences(
                                db,
                                table,
                                p0,
                              ).matchTableRefs,
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
      PrefetchHooks Function({bool userGroupTableRefs, bool matchTableRefs})
    >;
typedef $$UserGroupTableTableCreateCompanionBuilder =
    UserGroupTableCompanion Function({
      required String userId,
      required String groupId,
      Value<int> rowid,
    });
typedef $$UserGroupTableTableUpdateCompanionBuilder =
    UserGroupTableCompanion Function({
      Value<String> userId,
      Value<String> groupId,
      Value<int> rowid,
    });

final class $$UserGroupTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserGroupTableTable,
          UserGroupTableData
        > {
  $$UserGroupTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserTableTable _userIdTable(_$AppDatabase db) =>
      db.userTable.createAlias(
        $_aliasNameGenerator(db.userGroupTable.userId, db.userTable.id),
      );

  $$UserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableTableManager(
      $_db,
      $_db.userTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GroupTableTable _groupIdTable(_$AppDatabase db) =>
      db.groupTable.createAlias(
        $_aliasNameGenerator(db.userGroupTable.groupId, db.groupTable.id),
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

class $$UserGroupTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserGroupTableTable> {
  $$UserGroupTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableFilterComposer(
            $db: $db,
            $table: $db.userTable,
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

class $$UserGroupTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserGroupTableTable> {
  $$UserGroupTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableOrderingComposer(
            $db: $db,
            $table: $db.userTable,
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

class $$UserGroupTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserGroupTableTable> {
  $$UserGroupTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userTable,
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

class $$UserGroupTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserGroupTableTable,
          UserGroupTableData,
          $$UserGroupTableTableFilterComposer,
          $$UserGroupTableTableOrderingComposer,
          $$UserGroupTableTableAnnotationComposer,
          $$UserGroupTableTableCreateCompanionBuilder,
          $$UserGroupTableTableUpdateCompanionBuilder,
          (UserGroupTableData, $$UserGroupTableTableReferences),
          UserGroupTableData,
          PrefetchHooks Function({bool userId, bool groupId})
        > {
  $$UserGroupTableTableTableManager(
    _$AppDatabase db,
    $UserGroupTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserGroupTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserGroupTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserGroupTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserGroupTableCompanion(
                userId: userId,
                groupId: groupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String groupId,
                Value<int> rowid = const Value.absent(),
              }) => UserGroupTableCompanion.insert(
                userId: userId,
                groupId: groupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserGroupTableTableReferences(db, table, e),
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
                                referencedTable: $$UserGroupTableTableReferences
                                    ._userIdTable(db),
                                referencedColumn:
                                    $$UserGroupTableTableReferences
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
                                referencedTable: $$UserGroupTableTableReferences
                                    ._groupIdTable(db),
                                referencedColumn:
                                    $$UserGroupTableTableReferences
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

typedef $$UserGroupTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserGroupTableTable,
      UserGroupTableData,
      $$UserGroupTableTableFilterComposer,
      $$UserGroupTableTableOrderingComposer,
      $$UserGroupTableTableAnnotationComposer,
      $$UserGroupTableTableCreateCompanionBuilder,
      $$UserGroupTableTableUpdateCompanionBuilder,
      (UserGroupTableData, $$UserGroupTableTableReferences),
      UserGroupTableData,
      PrefetchHooks Function({bool userId, bool groupId})
    >;
typedef $$GameTableTableCreateCompanionBuilder =
    GameTableCompanion Function({Value<int> id, required String name});
typedef $$GameTableTableUpdateCompanionBuilder =
    GameTableCompanion Function({Value<int> id, Value<String> name});

final class $$GameTableTableReferences
    extends BaseReferences<_$AppDatabase, $GameTableTable, GameTableData> {
  $$GameTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MatchTableTable, List<MatchTableData>>
  _matchTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchTable,
    aliasName: $_aliasNameGenerator(db.gameTable.id, db.matchTable.gameId),
  );

  $$MatchTableTableProcessedTableManager get matchTableRefs {
    final manager = $$MatchTableTableTableManager(
      $_db,
      $_db.matchTable,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchTableRefsTable($_db));
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
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> matchTableRefs(
    Expression<bool> Function($$MatchTableTableFilterComposer f) f,
  ) {
    final $$MatchTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableFilterComposer(
            $db: $db,
            $table: $db.matchTable,
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
  ColumnOrderings<int> get id => $composableBuilder(
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> matchTableRefs<T extends Object>(
    Expression<T> Function($$MatchTableTableAnnotationComposer a) f,
  ) {
    final $$MatchTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableAnnotationComposer(
            $db: $db,
            $table: $db.matchTable,
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
          PrefetchHooks Function({bool matchTableRefs})
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
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => GameTableCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  GameTableCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GameTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({matchTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (matchTableRefs) db.matchTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchTableRefs)
                    await $_getPrefetchedData<
                      GameTableData,
                      $GameTableTable,
                      MatchTableData
                    >(
                      currentTable: table,
                      referencedTable: $$GameTableTableReferences
                          ._matchTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GameTableTableReferences(
                            db,
                            table,
                            p0,
                          ).matchTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.gameId == item.id),
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
      PrefetchHooks Function({bool matchTableRefs})
    >;
typedef $$MatchTableTableCreateCompanionBuilder =
    MatchTableCompanion Function({
      required String id,
      required int gameId,
      Value<String?> groupId,
      Value<int> rowid,
    });
typedef $$MatchTableTableUpdateCompanionBuilder =
    MatchTableCompanion Function({
      Value<String> id,
      Value<int> gameId,
      Value<String?> groupId,
      Value<int> rowid,
    });

final class $$MatchTableTableReferences
    extends BaseReferences<_$AppDatabase, $MatchTableTable, MatchTableData> {
  $$MatchTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameTableTable _gameIdTable(_$AppDatabase db) => db.gameTable
      .createAlias($_aliasNameGenerator(db.matchTable.gameId, db.gameTable.id));

  $$GameTableTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<int>('game_id')!;

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

  static $GroupTableTable _groupIdTable(_$AppDatabase db) =>
      db.groupTable.createAlias(
        $_aliasNameGenerator(db.matchTable.groupId, db.groupTable.id),
      );

  $$GroupTableTableProcessedTableManager? get groupId {
    final $_column = $_itemColumn<String>('group_id');
    if ($_column == null) return null;
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

  static MultiTypedResultKey<$ResultScoreTableTable, List<ResultScoreTableData>>
  _resultScoreTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.resultScoreTable,
    aliasName: $_aliasNameGenerator(
      db.matchTable.id,
      db.resultScoreTable.matchId,
    ),
  );

  $$ResultScoreTableTableProcessedTableManager get resultScoreTableRefs {
    final manager = $$ResultScoreTableTableTableManager(
      $_db,
      $_db.resultScoreTable,
    ).filter((f) => f.matchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _resultScoreTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ResultWinTableTable, List<ResultWinTableData>>
  _resultWinTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.resultWinTable,
    aliasName: $_aliasNameGenerator(
      db.matchTable.id,
      db.resultWinTable.matchId,
    ),
  );

  $$ResultWinTableTableProcessedTableManager get resultWinTableRefs {
    final manager = $$ResultWinTableTableTableManager(
      $_db,
      $_db.resultWinTable,
    ).filter((f) => f.matchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_resultWinTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ResultPlacementTableTable,
    List<ResultPlacementTableData>
  >
  _resultPlacementTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.resultPlacementTable,
        aliasName: $_aliasNameGenerator(
          db.matchTable.id,
          db.resultPlacementTable.matchId,
        ),
      );

  $$ResultPlacementTableTableProcessedTableManager
  get resultPlacementTableRefs {
    final manager = $$ResultPlacementTableTableTableManager(
      $_db,
      $_db.resultPlacementTable,
    ).filter((f) => f.matchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _resultPlacementTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MatchTableTableFilterComposer
    extends Composer<_$AppDatabase, $MatchTableTable> {
  $$MatchTableTableFilterComposer({
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

  Expression<bool> resultScoreTableRefs(
    Expression<bool> Function($$ResultScoreTableTableFilterComposer f) f,
  ) {
    final $$ResultScoreTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultScoreTable,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultScoreTableTableFilterComposer(
            $db: $db,
            $table: $db.resultScoreTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> resultWinTableRefs(
    Expression<bool> Function($$ResultWinTableTableFilterComposer f) f,
  ) {
    final $$ResultWinTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultWinTable,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultWinTableTableFilterComposer(
            $db: $db,
            $table: $db.resultWinTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> resultPlacementTableRefs(
    Expression<bool> Function($$ResultPlacementTableTableFilterComposer f) f,
  ) {
    final $$ResultPlacementTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultPlacementTable,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultPlacementTableTableFilterComposer(
            $db: $db,
            $table: $db.resultPlacementTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchTableTable> {
  $$MatchTableTableOrderingComposer({
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

class $$MatchTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchTableTable> {
  $$MatchTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

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

  Expression<T> resultScoreTableRefs<T extends Object>(
    Expression<T> Function($$ResultScoreTableTableAnnotationComposer a) f,
  ) {
    final $$ResultScoreTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultScoreTable,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultScoreTableTableAnnotationComposer(
            $db: $db,
            $table: $db.resultScoreTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> resultWinTableRefs<T extends Object>(
    Expression<T> Function($$ResultWinTableTableAnnotationComposer a) f,
  ) {
    final $$ResultWinTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.resultWinTable,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ResultWinTableTableAnnotationComposer(
            $db: $db,
            $table: $db.resultWinTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> resultPlacementTableRefs<T extends Object>(
    Expression<T> Function($$ResultPlacementTableTableAnnotationComposer a) f,
  ) {
    final $$ResultPlacementTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.resultPlacementTable,
          getReferencedColumn: (t) => t.matchId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ResultPlacementTableTableAnnotationComposer(
                $db: $db,
                $table: $db.resultPlacementTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MatchTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchTableTable,
          MatchTableData,
          $$MatchTableTableFilterComposer,
          $$MatchTableTableOrderingComposer,
          $$MatchTableTableAnnotationComposer,
          $$MatchTableTableCreateCompanionBuilder,
          $$MatchTableTableUpdateCompanionBuilder,
          (MatchTableData, $$MatchTableTableReferences),
          MatchTableData,
          PrefetchHooks Function({
            bool gameId,
            bool groupId,
            bool resultScoreTableRefs,
            bool resultWinTableRefs,
            bool resultPlacementTableRefs,
          })
        > {
  $$MatchTableTableTableManager(_$AppDatabase db, $MatchTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> gameId = const Value.absent(),
                Value<String?> groupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MatchTableCompanion(
                id: id,
                gameId: gameId,
                groupId: groupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int gameId,
                Value<String?> groupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MatchTableCompanion.insert(
                id: id,
                gameId: gameId,
                groupId: groupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatchTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                gameId = false,
                groupId = false,
                resultScoreTableRefs = false,
                resultWinTableRefs = false,
                resultPlacementTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (resultScoreTableRefs) db.resultScoreTable,
                    if (resultWinTableRefs) db.resultWinTable,
                    if (resultPlacementTableRefs) db.resultPlacementTable,
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
                        if (gameId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.gameId,
                                    referencedTable: $$MatchTableTableReferences
                                        ._gameIdTable(db),
                                    referencedColumn:
                                        $$MatchTableTableReferences
                                            ._gameIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable: $$MatchTableTableReferences
                                        ._groupIdTable(db),
                                    referencedColumn:
                                        $$MatchTableTableReferences
                                            ._groupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (resultScoreTableRefs)
                        await $_getPrefetchedData<
                          MatchTableData,
                          $MatchTableTable,
                          ResultScoreTableData
                        >(
                          currentTable: table,
                          referencedTable: $$MatchTableTableReferences
                              ._resultScoreTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatchTableTableReferences(
                                db,
                                table,
                                p0,
                              ).resultScoreTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.matchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (resultWinTableRefs)
                        await $_getPrefetchedData<
                          MatchTableData,
                          $MatchTableTable,
                          ResultWinTableData
                        >(
                          currentTable: table,
                          referencedTable: $$MatchTableTableReferences
                              ._resultWinTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatchTableTableReferences(
                                db,
                                table,
                                p0,
                              ).resultWinTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.matchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (resultPlacementTableRefs)
                        await $_getPrefetchedData<
                          MatchTableData,
                          $MatchTableTable,
                          ResultPlacementTableData
                        >(
                          currentTable: table,
                          referencedTable: $$MatchTableTableReferences
                              ._resultPlacementTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatchTableTableReferences(
                                db,
                                table,
                                p0,
                              ).resultPlacementTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.matchId == item.id,
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

typedef $$MatchTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchTableTable,
      MatchTableData,
      $$MatchTableTableFilterComposer,
      $$MatchTableTableOrderingComposer,
      $$MatchTableTableAnnotationComposer,
      $$MatchTableTableCreateCompanionBuilder,
      $$MatchTableTableUpdateCompanionBuilder,
      (MatchTableData, $$MatchTableTableReferences),
      MatchTableData,
      PrefetchHooks Function({
        bool gameId,
        bool groupId,
        bool resultScoreTableRefs,
        bool resultWinTableRefs,
        bool resultPlacementTableRefs,
      })
    >;
typedef $$ResultScoreTableTableCreateCompanionBuilder =
    ResultScoreTableCompanion Function({
      required String matchId,
      required String userId,
      required int score,
      Value<int> rowid,
    });
typedef $$ResultScoreTableTableUpdateCompanionBuilder =
    ResultScoreTableCompanion Function({
      Value<String> matchId,
      Value<String> userId,
      Value<int> score,
      Value<int> rowid,
    });

final class $$ResultScoreTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ResultScoreTableTable,
          ResultScoreTableData
        > {
  $$ResultScoreTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MatchTableTable _matchIdTable(_$AppDatabase db) =>
      db.matchTable.createAlias(
        $_aliasNameGenerator(db.resultScoreTable.matchId, db.matchTable.id),
      );

  $$MatchTableTableProcessedTableManager get matchId {
    final $_column = $_itemColumn<String>('match_id')!;

    final manager = $$MatchTableTableTableManager(
      $_db,
      $_db.matchTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserTableTable _userIdTable(_$AppDatabase db) =>
      db.userTable.createAlias(
        $_aliasNameGenerator(db.resultScoreTable.userId, db.userTable.id),
      );

  $$UserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableTableManager(
      $_db,
      $_db.userTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ResultScoreTableTableFilterComposer
    extends Composer<_$AppDatabase, $ResultScoreTableTable> {
  $$ResultScoreTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  $$MatchTableTableFilterComposer get matchId {
    final $$MatchTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableFilterComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableFilterComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultScoreTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ResultScoreTableTable> {
  $$ResultScoreTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatchTableTableOrderingComposer get matchId {
    final $$MatchTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableOrderingComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableOrderingComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultScoreTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResultScoreTableTable> {
  $$ResultScoreTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  $$MatchTableTableAnnotationComposer get matchId {
    final $$MatchTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableAnnotationComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultScoreTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResultScoreTableTable,
          ResultScoreTableData,
          $$ResultScoreTableTableFilterComposer,
          $$ResultScoreTableTableOrderingComposer,
          $$ResultScoreTableTableAnnotationComposer,
          $$ResultScoreTableTableCreateCompanionBuilder,
          $$ResultScoreTableTableUpdateCompanionBuilder,
          (ResultScoreTableData, $$ResultScoreTableTableReferences),
          ResultScoreTableData,
          PrefetchHooks Function({bool matchId, bool userId})
        > {
  $$ResultScoreTableTableTableManager(
    _$AppDatabase db,
    $ResultScoreTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResultScoreTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResultScoreTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResultScoreTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> matchId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResultScoreTableCompanion(
                matchId: matchId,
                userId: userId,
                score: score,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String matchId,
                required String userId,
                required int score,
                Value<int> rowid = const Value.absent(),
              }) => ResultScoreTableCompanion.insert(
                matchId: matchId,
                userId: userId,
                score: score,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ResultScoreTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({matchId = false, userId = false}) {
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
                    if (matchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.matchId,
                                referencedTable:
                                    $$ResultScoreTableTableReferences
                                        ._matchIdTable(db),
                                referencedColumn:
                                    $$ResultScoreTableTableReferences
                                        ._matchIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$ResultScoreTableTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$ResultScoreTableTableReferences
                                        ._userIdTable(db)
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

typedef $$ResultScoreTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResultScoreTableTable,
      ResultScoreTableData,
      $$ResultScoreTableTableFilterComposer,
      $$ResultScoreTableTableOrderingComposer,
      $$ResultScoreTableTableAnnotationComposer,
      $$ResultScoreTableTableCreateCompanionBuilder,
      $$ResultScoreTableTableUpdateCompanionBuilder,
      (ResultScoreTableData, $$ResultScoreTableTableReferences),
      ResultScoreTableData,
      PrefetchHooks Function({bool matchId, bool userId})
    >;
typedef $$ResultWinTableTableCreateCompanionBuilder =
    ResultWinTableCompanion Function({
      required String matchId,
      required String winnerId,
      Value<int> rowid,
    });
typedef $$ResultWinTableTableUpdateCompanionBuilder =
    ResultWinTableCompanion Function({
      Value<String> matchId,
      Value<String> winnerId,
      Value<int> rowid,
    });

final class $$ResultWinTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ResultWinTableTable,
          ResultWinTableData
        > {
  $$ResultWinTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MatchTableTable _matchIdTable(_$AppDatabase db) =>
      db.matchTable.createAlias(
        $_aliasNameGenerator(db.resultWinTable.matchId, db.matchTable.id),
      );

  $$MatchTableTableProcessedTableManager get matchId {
    final $_column = $_itemColumn<String>('match_id')!;

    final manager = $$MatchTableTableTableManager(
      $_db,
      $_db.matchTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserTableTable _winnerIdTable(_$AppDatabase db) =>
      db.userTable.createAlias(
        $_aliasNameGenerator(db.resultWinTable.winnerId, db.userTable.id),
      );

  $$UserTableTableProcessedTableManager get winnerId {
    final $_column = $_itemColumn<String>('winner_id')!;

    final manager = $$UserTableTableTableManager(
      $_db,
      $_db.userTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_winnerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ResultWinTableTableFilterComposer
    extends Composer<_$AppDatabase, $ResultWinTableTable> {
  $$ResultWinTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MatchTableTableFilterComposer get matchId {
    final $$MatchTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableFilterComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableFilterComposer get winnerId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.winnerId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableFilterComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultWinTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ResultWinTableTable> {
  $$ResultWinTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MatchTableTableOrderingComposer get matchId {
    final $$MatchTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableOrderingComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableOrderingComposer get winnerId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.winnerId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableOrderingComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultWinTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResultWinTableTable> {
  $$ResultWinTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MatchTableTableAnnotationComposer get matchId {
    final $$MatchTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableAnnotationComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableAnnotationComposer get winnerId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.winnerId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultWinTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResultWinTableTable,
          ResultWinTableData,
          $$ResultWinTableTableFilterComposer,
          $$ResultWinTableTableOrderingComposer,
          $$ResultWinTableTableAnnotationComposer,
          $$ResultWinTableTableCreateCompanionBuilder,
          $$ResultWinTableTableUpdateCompanionBuilder,
          (ResultWinTableData, $$ResultWinTableTableReferences),
          ResultWinTableData,
          PrefetchHooks Function({bool matchId, bool winnerId})
        > {
  $$ResultWinTableTableTableManager(
    _$AppDatabase db,
    $ResultWinTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResultWinTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResultWinTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResultWinTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> matchId = const Value.absent(),
                Value<String> winnerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResultWinTableCompanion(
                matchId: matchId,
                winnerId: winnerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String matchId,
                required String winnerId,
                Value<int> rowid = const Value.absent(),
              }) => ResultWinTableCompanion.insert(
                matchId: matchId,
                winnerId: winnerId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ResultWinTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({matchId = false, winnerId = false}) {
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
                    if (matchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.matchId,
                                referencedTable: $$ResultWinTableTableReferences
                                    ._matchIdTable(db),
                                referencedColumn:
                                    $$ResultWinTableTableReferences
                                        ._matchIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (winnerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.winnerId,
                                referencedTable: $$ResultWinTableTableReferences
                                    ._winnerIdTable(db),
                                referencedColumn:
                                    $$ResultWinTableTableReferences
                                        ._winnerIdTable(db)
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

typedef $$ResultWinTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResultWinTableTable,
      ResultWinTableData,
      $$ResultWinTableTableFilterComposer,
      $$ResultWinTableTableOrderingComposer,
      $$ResultWinTableTableAnnotationComposer,
      $$ResultWinTableTableCreateCompanionBuilder,
      $$ResultWinTableTableUpdateCompanionBuilder,
      (ResultWinTableData, $$ResultWinTableTableReferences),
      ResultWinTableData,
      PrefetchHooks Function({bool matchId, bool winnerId})
    >;
typedef $$ResultPlacementTableTableCreateCompanionBuilder =
    ResultPlacementTableCompanion Function({
      required String matchId,
      required String userId,
      required int placement,
      Value<int> rowid,
    });
typedef $$ResultPlacementTableTableUpdateCompanionBuilder =
    ResultPlacementTableCompanion Function({
      Value<String> matchId,
      Value<String> userId,
      Value<int> placement,
      Value<int> rowid,
    });

final class $$ResultPlacementTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ResultPlacementTableTable,
          ResultPlacementTableData
        > {
  $$ResultPlacementTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MatchTableTable _matchIdTable(_$AppDatabase db) =>
      db.matchTable.createAlias(
        $_aliasNameGenerator(db.resultPlacementTable.matchId, db.matchTable.id),
      );

  $$MatchTableTableProcessedTableManager get matchId {
    final $_column = $_itemColumn<String>('match_id')!;

    final manager = $$MatchTableTableTableManager(
      $_db,
      $_db.matchTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserTableTable _userIdTable(_$AppDatabase db) =>
      db.userTable.createAlias(
        $_aliasNameGenerator(db.resultPlacementTable.userId, db.userTable.id),
      );

  $$UserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableTableManager(
      $_db,
      $_db.userTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ResultPlacementTableTableFilterComposer
    extends Composer<_$AppDatabase, $ResultPlacementTableTable> {
  $$ResultPlacementTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get placement => $composableBuilder(
    column: $table.placement,
    builder: (column) => ColumnFilters(column),
  );

  $$MatchTableTableFilterComposer get matchId {
    final $$MatchTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableFilterComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableFilterComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultPlacementTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ResultPlacementTableTable> {
  $$ResultPlacementTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get placement => $composableBuilder(
    column: $table.placement,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatchTableTableOrderingComposer get matchId {
    final $$MatchTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableOrderingComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableOrderingComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultPlacementTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResultPlacementTableTable> {
  $$ResultPlacementTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get placement =>
      $composableBuilder(column: $table.placement, builder: (column) => column);

  $$MatchTableTableAnnotationComposer get matchId {
    final $$MatchTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.matchTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableTableAnnotationComposer(
            $db: $db,
            $table: $db.matchTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.userTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ResultPlacementTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResultPlacementTableTable,
          ResultPlacementTableData,
          $$ResultPlacementTableTableFilterComposer,
          $$ResultPlacementTableTableOrderingComposer,
          $$ResultPlacementTableTableAnnotationComposer,
          $$ResultPlacementTableTableCreateCompanionBuilder,
          $$ResultPlacementTableTableUpdateCompanionBuilder,
          (ResultPlacementTableData, $$ResultPlacementTableTableReferences),
          ResultPlacementTableData,
          PrefetchHooks Function({bool matchId, bool userId})
        > {
  $$ResultPlacementTableTableTableManager(
    _$AppDatabase db,
    $ResultPlacementTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResultPlacementTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResultPlacementTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ResultPlacementTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> matchId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> placement = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResultPlacementTableCompanion(
                matchId: matchId,
                userId: userId,
                placement: placement,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String matchId,
                required String userId,
                required int placement,
                Value<int> rowid = const Value.absent(),
              }) => ResultPlacementTableCompanion.insert(
                matchId: matchId,
                userId: userId,
                placement: placement,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ResultPlacementTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({matchId = false, userId = false}) {
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
                    if (matchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.matchId,
                                referencedTable:
                                    $$ResultPlacementTableTableReferences
                                        ._matchIdTable(db),
                                referencedColumn:
                                    $$ResultPlacementTableTableReferences
                                        ._matchIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$ResultPlacementTableTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$ResultPlacementTableTableReferences
                                        ._userIdTable(db)
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

typedef $$ResultPlacementTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResultPlacementTableTable,
      ResultPlacementTableData,
      $$ResultPlacementTableTableFilterComposer,
      $$ResultPlacementTableTableOrderingComposer,
      $$ResultPlacementTableTableAnnotationComposer,
      $$ResultPlacementTableTableCreateCompanionBuilder,
      $$ResultPlacementTableTableUpdateCompanionBuilder,
      (ResultPlacementTableData, $$ResultPlacementTableTableReferences),
      ResultPlacementTableData,
      PrefetchHooks Function({bool matchId, bool userId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
  $$GroupTableTableTableManager get groupTable =>
      $$GroupTableTableTableManager(_db, _db.groupTable);
  $$UserGroupTableTableTableManager get userGroupTable =>
      $$UserGroupTableTableTableManager(_db, _db.userGroupTable);
  $$GameTableTableTableManager get gameTable =>
      $$GameTableTableTableManager(_db, _db.gameTable);
  $$MatchTableTableTableManager get matchTable =>
      $$MatchTableTableTableManager(_db, _db.matchTable);
  $$ResultScoreTableTableTableManager get resultScoreTable =>
      $$ResultScoreTableTableTableManager(_db, _db.resultScoreTable);
  $$ResultWinTableTableTableManager get resultWinTable =>
      $$ResultWinTableTableTableManager(_db, _db.resultWinTable);
  $$ResultPlacementTableTableTableManager get resultPlacementTable =>
      $$ResultPlacementTableTableTableManager(_db, _db.resultPlacementTable);
}
