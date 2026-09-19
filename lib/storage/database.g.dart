// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'database.dart';

// ignore_for_file: type=lint
class $PlayerProfilesTable extends PlayerProfiles
    with TableInfo<$PlayerProfilesTable, PlayerProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerProfilesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _coinsMeta = const VerificationMeta('coins');
  @override
  late final GeneratedColumn<int> coins = GeneratedColumn<int>(
    'coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gemsMeta = const VerificationMeta('gems');
  @override
  late final GeneratedColumn<int> gems = GeneratedColumn<int>(
    'gems',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _colorblindModeMeta = const VerificationMeta(
    'colorblindMode',
  );
  @override
  late final GeneratedColumn<bool> colorblindMode = GeneratedColumn<bool>(
    'colorblind_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("colorblind_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _soundOnMeta = const VerificationMeta(
    'soundOn',
  );
  @override
  late final GeneratedColumn<bool> soundOn = GeneratedColumn<bool>(
    'sound_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_on" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _hapticsOnMeta = const VerificationMeta(
    'hapticsOn',
  );
  @override
  late final GeneratedColumn<bool> hapticsOn = GeneratedColumn<bool>(
    'haptics_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("haptics_on" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coins,
    gems,
    xp,
    colorblindMode,
    soundOn,
    hapticsOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('coins')) {
      context.handle(
        _coinsMeta,
        coins.isAcceptableOrUnknown(data['coins']!, _coinsMeta),
      );
    }
    if (data.containsKey('gems')) {
      context.handle(
        _gemsMeta,
        gems.isAcceptableOrUnknown(data['gems']!, _gemsMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('colorblind_mode')) {
      context.handle(
        _colorblindModeMeta,
        colorblindMode.isAcceptableOrUnknown(
          data['colorblind_mode']!,
          _colorblindModeMeta,
        ),
      );
    }
    if (data.containsKey('sound_on')) {
      context.handle(
        _soundOnMeta,
        soundOn.isAcceptableOrUnknown(data['sound_on']!, _soundOnMeta),
      );
    }
    if (data.containsKey('haptics_on')) {
      context.handle(
        _hapticsOnMeta,
        hapticsOn.isAcceptableOrUnknown(data['haptics_on']!, _hapticsOnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      coins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coins'],
      )!,
      gems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gems'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      colorblindMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}colorblind_mode'],
      )!,
      soundOn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_on'],
      )!,
      hapticsOn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}haptics_on'],
      )!,
    );
  }

  @override
  $PlayerProfilesTable createAlias(String alias) {
    return $PlayerProfilesTable(attachedDatabase, alias);
  }
}

class PlayerProfile extends DataClass implements Insertable<PlayerProfile> {
  final int id;
  final int coins;
  final int gems;
  final int xp;
  final bool colorblindMode;
  final bool soundOn;
  final bool hapticsOn;
  const PlayerProfile({
    required this.id,
    required this.coins,
    required this.gems,
    required this.xp,
    required this.colorblindMode,
    required this.soundOn,
    required this.hapticsOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['coins'] = Variable<int>(coins);
    map['gems'] = Variable<int>(gems);
    map['xp'] = Variable<int>(xp);
    map['colorblind_mode'] = Variable<bool>(colorblindMode);
    map['sound_on'] = Variable<bool>(soundOn);
    map['haptics_on'] = Variable<bool>(hapticsOn);
    return map;
  }

  PlayerProfilesCompanion toCompanion(bool nullToAbsent) {
    return PlayerProfilesCompanion(
      id: Value(id),
      coins: Value(coins),
      gems: Value(gems),
      xp: Value(xp),
      colorblindMode: Value(colorblindMode),
      soundOn: Value(soundOn),
      hapticsOn: Value(hapticsOn),
    );
  }

  factory PlayerProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerProfile(
      id: serializer.fromJson<int>(json['id']),
      coins: serializer.fromJson<int>(json['coins']),
      gems: serializer.fromJson<int>(json['gems']),
      xp: serializer.fromJson<int>(json['xp']),
      colorblindMode: serializer.fromJson<bool>(json['colorblindMode']),
      soundOn: serializer.fromJson<bool>(json['soundOn']),
      hapticsOn: serializer.fromJson<bool>(json['hapticsOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'coins': serializer.toJson<int>(coins),
      'gems': serializer.toJson<int>(gems),
      'xp': serializer.toJson<int>(xp),
      'colorblindMode': serializer.toJson<bool>(colorblindMode),
      'soundOn': serializer.toJson<bool>(soundOn),
      'hapticsOn': serializer.toJson<bool>(hapticsOn),
    };
  }

  PlayerProfile copyWith({
    int? id,
    int? coins,
    int? gems,
    int? xp,
    bool? colorblindMode,
    bool? soundOn,
    bool? hapticsOn,
  }) => PlayerProfile(
    id: id ?? this.id,
    coins: coins ?? this.coins,
    gems: gems ?? this.gems,
    xp: xp ?? this.xp,
    colorblindMode: colorblindMode ?? this.colorblindMode,
    soundOn: soundOn ?? this.soundOn,
    hapticsOn: hapticsOn ?? this.hapticsOn,
  );
  PlayerProfile copyWithCompanion(PlayerProfilesCompanion data) {
    return PlayerProfile(
      id: data.id.present ? data.id.value : this.id,
      coins: data.coins.present ? data.coins.value : this.coins,
      gems: data.gems.present ? data.gems.value : this.gems,
      xp: data.xp.present ? data.xp.value : this.xp,
      colorblindMode: data.colorblindMode.present
          ? data.colorblindMode.value
          : this.colorblindMode,
      soundOn: data.soundOn.present ? data.soundOn.value : this.soundOn,
      hapticsOn: data.hapticsOn.present ? data.hapticsOn.value : this.hapticsOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerProfile(')
          ..write('id: $id, ')
          ..write('coins: $coins, ')
          ..write('gems: $gems, ')
          ..write('xp: $xp, ')
          ..write('colorblindMode: $colorblindMode, ')
          ..write('soundOn: $soundOn, ')
          ..write('hapticsOn: $hapticsOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, coins, gems, xp, colorblindMode, soundOn, hapticsOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerProfile &&
          other.id == this.id &&
          other.coins == this.coins &&
          other.gems == this.gems &&
          other.xp == this.xp &&
          other.colorblindMode == this.colorblindMode &&
          other.soundOn == this.soundOn &&
          other.hapticsOn == this.hapticsOn);
}

class PlayerProfilesCompanion extends UpdateCompanion<PlayerProfile> {
  final Value<int> id;
  final Value<int> coins;
  final Value<int> gems;
  final Value<int> xp;
  final Value<bool> colorblindMode;
  final Value<bool> soundOn;
  final Value<bool> hapticsOn;
  const PlayerProfilesCompanion({
    this.id = const Value.absent(),
    this.coins = const Value.absent(),
    this.gems = const Value.absent(),
    this.xp = const Value.absent(),
    this.colorblindMode = const Value.absent(),
    this.soundOn = const Value.absent(),
    this.hapticsOn = const Value.absent(),
  });
  PlayerProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.coins = const Value.absent(),
    this.gems = const Value.absent(),
    this.xp = const Value.absent(),
    this.colorblindMode = const Value.absent(),
    this.soundOn = const Value.absent(),
    this.hapticsOn = const Value.absent(),
  });
  static Insertable<PlayerProfile> custom({
    Expression<int>? id,
    Expression<int>? coins,
    Expression<int>? gems,
    Expression<int>? xp,
    Expression<bool>? colorblindMode,
    Expression<bool>? soundOn,
    Expression<bool>? hapticsOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coins != null) 'coins': coins,
      if (gems != null) 'gems': gems,
      if (xp != null) 'xp': xp,
      if (colorblindMode != null) 'colorblind_mode': colorblindMode,
      if (soundOn != null) 'sound_on': soundOn,
      if (hapticsOn != null) 'haptics_on': hapticsOn,
    });
  }

  PlayerProfilesCompanion copyWith({
    Value<int>? id,
    Value<int>? coins,
    Value<int>? gems,
    Value<int>? xp,
    Value<bool>? colorblindMode,
    Value<bool>? soundOn,
    Value<bool>? hapticsOn,
  }) {
    return PlayerProfilesCompanion(
      id: id ?? this.id,
      coins: coins ?? this.coins,
      gems: gems ?? this.gems,
      xp: xp ?? this.xp,
      colorblindMode: colorblindMode ?? this.colorblindMode,
      soundOn: soundOn ?? this.soundOn,
      hapticsOn: hapticsOn ?? this.hapticsOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (coins.present) {
      map['coins'] = Variable<int>(coins.value);
    }
    if (gems.present) {
      map['gems'] = Variable<int>(gems.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (colorblindMode.present) {
      map['colorblind_mode'] = Variable<bool>(colorblindMode.value);
    }
    if (soundOn.present) {
      map['sound_on'] = Variable<bool>(soundOn.value);
    }
    if (hapticsOn.present) {
      map['haptics_on'] = Variable<bool>(hapticsOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerProfilesCompanion(')
          ..write('id: $id, ')
          ..write('coins: $coins, ')
          ..write('gems: $gems, ')
          ..write('xp: $xp, ')
          ..write('colorblindMode: $colorblindMode, ')
          ..write('soundOn: $soundOn, ')
          ..write('hapticsOn: $hapticsOn')
          ..write(')'))
        .toString();
  }
}

class $LevelProgressEntriesTable extends LevelProgressEntries
    with TableInfo<$LevelProgressEntriesTable, LevelProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LevelProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _levelIdMeta = const VerificationMeta(
    'levelId',
  );
  @override
  late final GeneratedColumn<String> levelId = GeneratedColumn<String>(
    'level_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('not_started'),
  );
  static const VerificationMeta _filledRegionIdsMeta = const VerificationMeta(
    'filledRegionIds',
  );
  @override
  late final GeneratedColumn<String> filledRegionIds = GeneratedColumn<String>(
    'filled_region_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _starRatingMeta = const VerificationMeta(
    'starRating',
  );
  @override
  late final GeneratedColumn<int> starRating = GeneratedColumn<int>(
    'star_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    levelId,
    status,
    filledRegionIds,
    completedAt,
    starRating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'level_progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LevelProgressEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('level_id')) {
      context.handle(
        _levelIdMeta,
        levelId.isAcceptableOrUnknown(data['level_id']!, _levelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_levelIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('filled_region_ids')) {
      context.handle(
        _filledRegionIdsMeta,
        filledRegionIds.isAcceptableOrUnknown(
          data['filled_region_ids']!,
          _filledRegionIdsMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('star_rating')) {
      context.handle(
        _starRatingMeta,
        starRating.isAcceptableOrUnknown(data['star_rating']!, _starRatingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {levelId};
  @override
  LevelProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LevelProgressEntry(
      levelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      filledRegionIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}filled_region_ids'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      starRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}star_rating'],
      ),
    );
  }

  @override
  $LevelProgressEntriesTable createAlias(String alias) {
    return $LevelProgressEntriesTable(attachedDatabase, alias);
  }
}

class LevelProgressEntry extends DataClass
    implements Insertable<LevelProgressEntry> {
  final String levelId;
  final String status;
  final String filledRegionIds;
  final DateTime? completedAt;
  final int? starRating;
  const LevelProgressEntry({
    required this.levelId,
    required this.status,
    required this.filledRegionIds,
    this.completedAt,
    this.starRating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['level_id'] = Variable<String>(levelId);
    map['status'] = Variable<String>(status);
    map['filled_region_ids'] = Variable<String>(filledRegionIds);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || starRating != null) {
      map['star_rating'] = Variable<int>(starRating);
    }
    return map;
  }

  LevelProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return LevelProgressEntriesCompanion(
      levelId: Value(levelId),
      status: Value(status),
      filledRegionIds: Value(filledRegionIds),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      starRating: starRating == null && nullToAbsent
          ? const Value.absent()
          : Value(starRating),
    );
  }

  factory LevelProgressEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LevelProgressEntry(
      levelId: serializer.fromJson<String>(json['levelId']),
      status: serializer.fromJson<String>(json['status']),
      filledRegionIds: serializer.fromJson<String>(json['filledRegionIds']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      starRating: serializer.fromJson<int?>(json['starRating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'levelId': serializer.toJson<String>(levelId),
      'status': serializer.toJson<String>(status),
      'filledRegionIds': serializer.toJson<String>(filledRegionIds),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'starRating': serializer.toJson<int?>(starRating),
    };
  }

  LevelProgressEntry copyWith({
    String? levelId,
    String? status,
    String? filledRegionIds,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<int?> starRating = const Value.absent(),
  }) => LevelProgressEntry(
    levelId: levelId ?? this.levelId,
    status: status ?? this.status,
    filledRegionIds: filledRegionIds ?? this.filledRegionIds,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    starRating: starRating.present ? starRating.value : this.starRating,
  );
  LevelProgressEntry copyWithCompanion(LevelProgressEntriesCompanion data) {
    return LevelProgressEntry(
      levelId: data.levelId.present ? data.levelId.value : this.levelId,
      status: data.status.present ? data.status.value : this.status,
      filledRegionIds: data.filledRegionIds.present
          ? data.filledRegionIds.value
          : this.filledRegionIds,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      starRating: data.starRating.present
          ? data.starRating.value
          : this.starRating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LevelProgressEntry(')
          ..write('levelId: $levelId, ')
          ..write('status: $status, ')
          ..write('filledRegionIds: $filledRegionIds, ')
          ..write('completedAt: $completedAt, ')
          ..write('starRating: $starRating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(levelId, status, filledRegionIds, completedAt, starRating);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LevelProgressEntry &&
          other.levelId == this.levelId &&
          other.status == this.status &&
          other.filledRegionIds == this.filledRegionIds &&
          other.completedAt == this.completedAt &&
          other.starRating == this.starRating);
}

class LevelProgressEntriesCompanion
    extends UpdateCompanion<LevelProgressEntry> {
  final Value<String> levelId;
  final Value<String> status;
  final Value<String> filledRegionIds;
  final Value<DateTime?> completedAt;
  final Value<int?> starRating;
  final Value<int> rowid;
  const LevelProgressEntriesCompanion({
    this.levelId = const Value.absent(),
    this.status = const Value.absent(),
    this.filledRegionIds = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.starRating = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LevelProgressEntriesCompanion.insert({
    required String levelId,
    this.status = const Value.absent(),
    this.filledRegionIds = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.starRating = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : levelId = Value(levelId);
  static Insertable<LevelProgressEntry> custom({
    Expression<String>? levelId,
    Expression<String>? status,
    Expression<String>? filledRegionIds,
    Expression<DateTime>? completedAt,
    Expression<int>? starRating,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (levelId != null) 'level_id': levelId,
      if (status != null) 'status': status,
      if (filledRegionIds != null) 'filled_region_ids': filledRegionIds,
      if (completedAt != null) 'completed_at': completedAt,
      if (starRating != null) 'star_rating': starRating,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LevelProgressEntriesCompanion copyWith({
    Value<String>? levelId,
    Value<String>? status,
    Value<String>? filledRegionIds,
    Value<DateTime?>? completedAt,
    Value<int?>? starRating,
    Value<int>? rowid,
  }) {
    return LevelProgressEntriesCompanion(
      levelId: levelId ?? this.levelId,
      status: status ?? this.status,
      filledRegionIds: filledRegionIds ?? this.filledRegionIds,
      completedAt: completedAt ?? this.completedAt,
      starRating: starRating ?? this.starRating,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (levelId.present) {
      map['level_id'] = Variable<String>(levelId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (filledRegionIds.present) {
      map['filled_region_ids'] = Variable<String>(filledRegionIds.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (starRating.present) {
      map['star_rating'] = Variable<int>(starRating.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LevelProgressEntriesCompanion(')
          ..write('levelId: $levelId, ')
          ..write('status: $status, ')
          ..write('filledRegionIds: $filledRegionIds, ')
          ..write('completedAt: $completedAt, ')
          ..write('starRating: $starRating, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompanionsTable extends Companions
    with TableInfo<$CompanionsTable, Companion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedMeta = const VerificationMeta(
    'unlocked',
  );
  @override
  late final GeneratedColumn<bool> unlocked = GeneratedColumn<bool>(
    'unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _evolutionStageMeta = const VerificationMeta(
    'evolutionStage',
  );
  @override
  late final GeneratedColumn<int> evolutionStage = GeneratedColumn<int>(
    'evolution_stage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, unlocked, evolutionStage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Companion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unlocked')) {
      context.handle(
        _unlockedMeta,
        unlocked.isAcceptableOrUnknown(data['unlocked']!, _unlockedMeta),
      );
    }
    if (data.containsKey('evolution_stage')) {
      context.handle(
        _evolutionStageMeta,
        evolutionStage.isAcceptableOrUnknown(
          data['evolution_stage']!,
          _evolutionStageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Companion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Companion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      unlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}unlocked'],
      )!,
      evolutionStage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolution_stage'],
      )!,
    );
  }

  @override
  $CompanionsTable createAlias(String alias) {
    return $CompanionsTable(attachedDatabase, alias);
  }
}

class Companion extends DataClass implements Insertable<Companion> {
  final String id;
  final bool unlocked;
  final int evolutionStage;
  const Companion({
    required this.id,
    required this.unlocked,
    required this.evolutionStage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unlocked'] = Variable<bool>(unlocked);
    map['evolution_stage'] = Variable<int>(evolutionStage);
    return map;
  }

  CompanionsCompanion toCompanion(bool nullToAbsent) {
    return CompanionsCompanion(
      id: Value(id),
      unlocked: Value(unlocked),
      evolutionStage: Value(evolutionStage),
    );
  }

  factory Companion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Companion(
      id: serializer.fromJson<String>(json['id']),
      unlocked: serializer.fromJson<bool>(json['unlocked']),
      evolutionStage: serializer.fromJson<int>(json['evolutionStage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unlocked': serializer.toJson<bool>(unlocked),
      'evolutionStage': serializer.toJson<int>(evolutionStage),
    };
  }

  Companion copyWith({String? id, bool? unlocked, int? evolutionStage}) =>
      Companion(
        id: id ?? this.id,
        unlocked: unlocked ?? this.unlocked,
        evolutionStage: evolutionStage ?? this.evolutionStage,
      );
  Companion copyWithCompanion(CompanionsCompanion data) {
    return Companion(
      id: data.id.present ? data.id.value : this.id,
      unlocked: data.unlocked.present ? data.unlocked.value : this.unlocked,
      evolutionStage: data.evolutionStage.present
          ? data.evolutionStage.value
          : this.evolutionStage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Companion(')
          ..write('id: $id, ')
          ..write('unlocked: $unlocked, ')
          ..write('evolutionStage: $evolutionStage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, unlocked, evolutionStage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Companion &&
          other.id == this.id &&
          other.unlocked == this.unlocked &&
          other.evolutionStage == this.evolutionStage);
}

class CompanionsCompanion extends UpdateCompanion<Companion> {
  final Value<String> id;
  final Value<bool> unlocked;
  final Value<int> evolutionStage;
  final Value<int> rowid;
  const CompanionsCompanion({
    this.id = const Value.absent(),
    this.unlocked = const Value.absent(),
    this.evolutionStage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompanionsCompanion.insert({
    required String id,
    this.unlocked = const Value.absent(),
    this.evolutionStage = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Companion> custom({
    Expression<String>? id,
    Expression<bool>? unlocked,
    Expression<int>? evolutionStage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unlocked != null) 'unlocked': unlocked,
      if (evolutionStage != null) 'evolution_stage': evolutionStage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompanionsCompanion copyWith({
    Value<String>? id,
    Value<bool>? unlocked,
    Value<int>? evolutionStage,
    Value<int>? rowid,
  }) {
    return CompanionsCompanion(
      id: id ?? this.id,
      unlocked: unlocked ?? this.unlocked,
      evolutionStage: evolutionStage ?? this.evolutionStage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unlocked.present) {
      map['unlocked'] = Variable<bool>(unlocked.value);
    }
    if (evolutionStage.present) {
      map['evolution_stage'] = Variable<int>(evolutionStage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanionsCompanion(')
          ..write('id: $id, ')
          ..write('unlocked: $unlocked, ')
          ..write('evolutionStage: $evolutionStage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IslandResourceEntriesTable extends IslandResourceEntries
    with TableInfo<$IslandResourceEntriesTable, IslandResourceEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IslandResourceEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _woodMeta = const VerificationMeta('wood');
  @override
  late final GeneratedColumn<int> wood = GeneratedColumn<int>(
    'wood',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stoneMeta = const VerificationMeta('stone');
  @override
  late final GeneratedColumn<int> stone = GeneratedColumn<int>(
    'stone',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _crystalMeta = const VerificationMeta(
    'crystal',
  );
  @override
  late final GeneratedColumn<int> crystal = GeneratedColumn<int>(
    'crystal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _foodMeta = const VerificationMeta('food');
  @override
  late final GeneratedColumn<int> food = GeneratedColumn<int>(
    'food',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goldMeta = const VerificationMeta('gold');
  @override
  late final GeneratedColumn<int> gold = GeneratedColumn<int>(
    'gold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, wood, stone, crystal, food, gold];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'island_resource_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<IslandResourceEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wood')) {
      context.handle(
        _woodMeta,
        wood.isAcceptableOrUnknown(data['wood']!, _woodMeta),
      );
    }
    if (data.containsKey('stone')) {
      context.handle(
        _stoneMeta,
        stone.isAcceptableOrUnknown(data['stone']!, _stoneMeta),
      );
    }
    if (data.containsKey('crystal')) {
      context.handle(
        _crystalMeta,
        crystal.isAcceptableOrUnknown(data['crystal']!, _crystalMeta),
      );
    }
    if (data.containsKey('food')) {
      context.handle(
        _foodMeta,
        food.isAcceptableOrUnknown(data['food']!, _foodMeta),
      );
    }
    if (data.containsKey('gold')) {
      context.handle(
        _goldMeta,
        gold.isAcceptableOrUnknown(data['gold']!, _goldMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IslandResourceEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IslandResourceEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wood: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wood'],
      )!,
      stone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stone'],
      )!,
      crystal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}crystal'],
      )!,
      food: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}food'],
      )!,
      gold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gold'],
      )!,
    );
  }

  @override
  $IslandResourceEntriesTable createAlias(String alias) {
    return $IslandResourceEntriesTable(attachedDatabase, alias);
  }
}

class IslandResourceEntry extends DataClass
    implements Insertable<IslandResourceEntry> {
  final int id;
  final int wood;
  final int stone;
  final int crystal;
  final int food;
  final int gold;
  const IslandResourceEntry({
    required this.id,
    required this.wood,
    required this.stone,
    required this.crystal,
    required this.food,
    required this.gold,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wood'] = Variable<int>(wood);
    map['stone'] = Variable<int>(stone);
    map['crystal'] = Variable<int>(crystal);
    map['food'] = Variable<int>(food);
    map['gold'] = Variable<int>(gold);
    return map;
  }

  IslandResourceEntriesCompanion toCompanion(bool nullToAbsent) {
    return IslandResourceEntriesCompanion(
      id: Value(id),
      wood: Value(wood),
      stone: Value(stone),
      crystal: Value(crystal),
      food: Value(food),
      gold: Value(gold),
    );
  }

  factory IslandResourceEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IslandResourceEntry(
      id: serializer.fromJson<int>(json['id']),
      wood: serializer.fromJson<int>(json['wood']),
      stone: serializer.fromJson<int>(json['stone']),
      crystal: serializer.fromJson<int>(json['crystal']),
      food: serializer.fromJson<int>(json['food']),
      gold: serializer.fromJson<int>(json['gold']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wood': serializer.toJson<int>(wood),
      'stone': serializer.toJson<int>(stone),
      'crystal': serializer.toJson<int>(crystal),
      'food': serializer.toJson<int>(food),
      'gold': serializer.toJson<int>(gold),
    };
  }

  IslandResourceEntry copyWith({
    int? id,
    int? wood,
    int? stone,
    int? crystal,
    int? food,
    int? gold,
  }) => IslandResourceEntry(
    id: id ?? this.id,
    wood: wood ?? this.wood,
    stone: stone ?? this.stone,
    crystal: crystal ?? this.crystal,
    food: food ?? this.food,
    gold: gold ?? this.gold,
  );
  IslandResourceEntry copyWithCompanion(IslandResourceEntriesCompanion data) {
    return IslandResourceEntry(
      id: data.id.present ? data.id.value : this.id,
      wood: data.wood.present ? data.wood.value : this.wood,
      stone: data.stone.present ? data.stone.value : this.stone,
      crystal: data.crystal.present ? data.crystal.value : this.crystal,
      food: data.food.present ? data.food.value : this.food,
      gold: data.gold.present ? data.gold.value : this.gold,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IslandResourceEntry(')
          ..write('id: $id, ')
          ..write('wood: $wood, ')
          ..write('stone: $stone, ')
          ..write('crystal: $crystal, ')
          ..write('food: $food, ')
          ..write('gold: $gold')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wood, stone, crystal, food, gold);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IslandResourceEntry &&
          other.id == this.id &&
          other.wood == this.wood &&
          other.stone == this.stone &&
          other.crystal == this.crystal &&
          other.food == this.food &&
          other.gold == this.gold);
}

class IslandResourceEntriesCompanion
    extends UpdateCompanion<IslandResourceEntry> {
  final Value<int> id;
  final Value<int> wood;
  final Value<int> stone;
  final Value<int> crystal;
  final Value<int> food;
  final Value<int> gold;
  const IslandResourceEntriesCompanion({
    this.id = const Value.absent(),
    this.wood = const Value.absent(),
    this.stone = const Value.absent(),
    this.crystal = const Value.absent(),
    this.food = const Value.absent(),
    this.gold = const Value.absent(),
  });
  IslandResourceEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.wood = const Value.absent(),
    this.stone = const Value.absent(),
    this.crystal = const Value.absent(),
    this.food = const Value.absent(),
    this.gold = const Value.absent(),
  });
  static Insertable<IslandResourceEntry> custom({
    Expression<int>? id,
    Expression<int>? wood,
    Expression<int>? stone,
    Expression<int>? crystal,
    Expression<int>? food,
    Expression<int>? gold,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wood != null) 'wood': wood,
      if (stone != null) 'stone': stone,
      if (crystal != null) 'crystal': crystal,
      if (food != null) 'food': food,
      if (gold != null) 'gold': gold,
    });
  }

  IslandResourceEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? wood,
    Value<int>? stone,
    Value<int>? crystal,
    Value<int>? food,
    Value<int>? gold,
  }) {
    return IslandResourceEntriesCompanion(
      id: id ?? this.id,
      wood: wood ?? this.wood,
      stone: stone ?? this.stone,
      crystal: crystal ?? this.crystal,
      food: food ?? this.food,
      gold: gold ?? this.gold,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wood.present) {
      map['wood'] = Variable<int>(wood.value);
    }
    if (stone.present) {
      map['stone'] = Variable<int>(stone.value);
    }
    if (crystal.present) {
      map['crystal'] = Variable<int>(crystal.value);
    }
    if (food.present) {
      map['food'] = Variable<int>(food.value);
    }
    if (gold.present) {
      map['gold'] = Variable<int>(gold.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IslandResourceEntriesCompanion(')
          ..write('id: $id, ')
          ..write('wood: $wood, ')
          ..write('stone: $stone, ')
          ..write('crystal: $crystal, ')
          ..write('food: $food, ')
          ..write('gold: $gold')
          ..write(')'))
        .toString();
  }
}

class $EntitlementsTable extends Entitlements
    with TableInfo<$EntitlementsTable, Entitlement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntitlementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasedAtMeta = const VerificationMeta(
    'purchasedAt',
  );
  @override
  late final GeneratedColumn<DateTime> purchasedAt = GeneratedColumn<DateTime>(
    'purchased_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [sku, purchasedAt, active];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entitlements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Entitlement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('purchased_at')) {
      context.handle(
        _purchasedAtMeta,
        purchasedAt.isAcceptableOrUnknown(
          data['purchased_at']!,
          _purchasedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasedAtMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sku};
  @override
  Entitlement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entitlement(
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      )!,
      purchasedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchased_at'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $EntitlementsTable createAlias(String alias) {
    return $EntitlementsTable(attachedDatabase, alias);
  }
}

class Entitlement extends DataClass implements Insertable<Entitlement> {
  final String sku;
  final DateTime purchasedAt;
  final bool active;
  const Entitlement({
    required this.sku,
    required this.purchasedAt,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sku'] = Variable<String>(sku);
    map['purchased_at'] = Variable<DateTime>(purchasedAt);
    map['active'] = Variable<bool>(active);
    return map;
  }

  EntitlementsCompanion toCompanion(bool nullToAbsent) {
    return EntitlementsCompanion(
      sku: Value(sku),
      purchasedAt: Value(purchasedAt),
      active: Value(active),
    );
  }

  factory Entitlement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entitlement(
      sku: serializer.fromJson<String>(json['sku']),
      purchasedAt: serializer.fromJson<DateTime>(json['purchasedAt']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sku': serializer.toJson<String>(sku),
      'purchasedAt': serializer.toJson<DateTime>(purchasedAt),
      'active': serializer.toJson<bool>(active),
    };
  }

  Entitlement copyWith({String? sku, DateTime? purchasedAt, bool? active}) =>
      Entitlement(
        sku: sku ?? this.sku,
        purchasedAt: purchasedAt ?? this.purchasedAt,
        active: active ?? this.active,
      );
  Entitlement copyWithCompanion(EntitlementsCompanion data) {
    return Entitlement(
      sku: data.sku.present ? data.sku.value : this.sku,
      purchasedAt: data.purchasedAt.present
          ? data.purchasedAt.value
          : this.purchasedAt,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entitlement(')
          ..write('sku: $sku, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sku, purchasedAt, active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entitlement &&
          other.sku == this.sku &&
          other.purchasedAt == this.purchasedAt &&
          other.active == this.active);
}

class EntitlementsCompanion extends UpdateCompanion<Entitlement> {
  final Value<String> sku;
  final Value<DateTime> purchasedAt;
  final Value<bool> active;
  final Value<int> rowid;
  const EntitlementsCompanion({
    this.sku = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntitlementsCompanion.insert({
    required String sku,
    required DateTime purchasedAt,
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sku = Value(sku),
       purchasedAt = Value(purchasedAt);
  static Insertable<Entitlement> custom({
    Expression<String>? sku,
    Expression<DateTime>? purchasedAt,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sku != null) 'sku': sku,
      if (purchasedAt != null) 'purchased_at': purchasedAt,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntitlementsCompanion copyWith({
    Value<String>? sku,
    Value<DateTime>? purchasedAt,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return EntitlementsCompanion(
      sku: sku ?? this.sku,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (purchasedAt.present) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntitlementsCompanion(')
          ..write('sku: $sku, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayerProfilesTable playerProfiles = $PlayerProfilesTable(this);
  late final $LevelProgressEntriesTable levelProgressEntries =
      $LevelProgressEntriesTable(this);
  late final $CompanionsTable companions = $CompanionsTable(this);
  late final $IslandResourceEntriesTable islandResourceEntries =
      $IslandResourceEntriesTable(this);
  late final $EntitlementsTable entitlements = $EntitlementsTable(this);
  late final PlayerProfileDao playerProfileDao = PlayerProfileDao(
    this as AppDatabase,
  );
  late final LevelProgressDao levelProgressDao = LevelProgressDao(
    this as AppDatabase,
  );
  late final CompanionDao companionDao = CompanionDao(this as AppDatabase);
  late final IslandResourcesDao islandResourcesDao = IslandResourcesDao(
    this as AppDatabase,
  );
  late final EntitlementDao entitlementDao = EntitlementDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    playerProfiles,
    levelProgressEntries,
    companions,
    islandResourceEntries,
    entitlements,
  ];
}

typedef $$PlayerProfilesTableCreateCompanionBuilder =
    PlayerProfilesCompanion Function({
      Value<int> id,
      Value<int> coins,
      Value<int> gems,
      Value<int> xp,
      Value<bool> colorblindMode,
      Value<bool> soundOn,
      Value<bool> hapticsOn,
    });
typedef $$PlayerProfilesTableUpdateCompanionBuilder =
    PlayerProfilesCompanion Function({
      Value<int> id,
      Value<int> coins,
      Value<int> gems,
      Value<int> xp,
      Value<bool> colorblindMode,
      Value<bool> soundOn,
      Value<bool> hapticsOn,
    });

class $$PlayerProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerProfilesTable> {
  $$PlayerProfilesTableFilterComposer({
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

  ColumnFilters<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gems => $composableBuilder(
    column: $table.gems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get colorblindMode => $composableBuilder(
    column: $table.colorblindMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soundOn => $composableBuilder(
    column: $table.soundOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hapticsOn => $composableBuilder(
    column: $table.hapticsOn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlayerProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerProfilesTable> {
  $$PlayerProfilesTableOrderingComposer({
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

  ColumnOrderings<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gems => $composableBuilder(
    column: $table.gems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get colorblindMode => $composableBuilder(
    column: $table.colorblindMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soundOn => $composableBuilder(
    column: $table.soundOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hapticsOn => $composableBuilder(
    column: $table.hapticsOn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayerProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerProfilesTable> {
  $$PlayerProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get coins =>
      $composableBuilder(column: $table.coins, builder: (column) => column);

  GeneratedColumn<int> get gems =>
      $composableBuilder(column: $table.gems, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<bool> get colorblindMode => $composableBuilder(
    column: $table.colorblindMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get soundOn =>
      $composableBuilder(column: $table.soundOn, builder: (column) => column);

  GeneratedColumn<bool> get hapticsOn =>
      $composableBuilder(column: $table.hapticsOn, builder: (column) => column);
}

class $$PlayerProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerProfilesTable,
          PlayerProfile,
          $$PlayerProfilesTableFilterComposer,
          $$PlayerProfilesTableOrderingComposer,
          $$PlayerProfilesTableAnnotationComposer,
          $$PlayerProfilesTableCreateCompanionBuilder,
          $$PlayerProfilesTableUpdateCompanionBuilder,
          (
            PlayerProfile,
            BaseReferences<_$AppDatabase, $PlayerProfilesTable, PlayerProfile>,
          ),
          PlayerProfile,
          PrefetchHooks Function()
        > {
  $$PlayerProfilesTableTableManager(
    _$AppDatabase db,
    $PlayerProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<int> gems = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<bool> colorblindMode = const Value.absent(),
                Value<bool> soundOn = const Value.absent(),
                Value<bool> hapticsOn = const Value.absent(),
              }) => PlayerProfilesCompanion(
                id: id,
                coins: coins,
                gems: gems,
                xp: xp,
                colorblindMode: colorblindMode,
                soundOn: soundOn,
                hapticsOn: hapticsOn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<int> gems = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<bool> colorblindMode = const Value.absent(),
                Value<bool> soundOn = const Value.absent(),
                Value<bool> hapticsOn = const Value.absent(),
              }) => PlayerProfilesCompanion.insert(
                id: id,
                coins: coins,
                gems: gems,
                xp: xp,
                colorblindMode: colorblindMode,
                soundOn: soundOn,
                hapticsOn: hapticsOn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlayerProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerProfilesTable,
      PlayerProfile,
      $$PlayerProfilesTableFilterComposer,
      $$PlayerProfilesTableOrderingComposer,
      $$PlayerProfilesTableAnnotationComposer,
      $$PlayerProfilesTableCreateCompanionBuilder,
      $$PlayerProfilesTableUpdateCompanionBuilder,
      (
        PlayerProfile,
        BaseReferences<_$AppDatabase, $PlayerProfilesTable, PlayerProfile>,
      ),
      PlayerProfile,
      PrefetchHooks Function()
    >;
typedef $$LevelProgressEntriesTableCreateCompanionBuilder =
    LevelProgressEntriesCompanion Function({
      required String levelId,
      Value<String> status,
      Value<String> filledRegionIds,
      Value<DateTime?> completedAt,
      Value<int?> starRating,
      Value<int> rowid,
    });
typedef $$LevelProgressEntriesTableUpdateCompanionBuilder =
    LevelProgressEntriesCompanion Function({
      Value<String> levelId,
      Value<String> status,
      Value<String> filledRegionIds,
      Value<DateTime?> completedAt,
      Value<int?> starRating,
      Value<int> rowid,
    });

class $$LevelProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LevelProgressEntriesTable> {
  $$LevelProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get levelId => $composableBuilder(
    column: $table.levelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filledRegionIds => $composableBuilder(
    column: $table.filledRegionIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get starRating => $composableBuilder(
    column: $table.starRating,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LevelProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LevelProgressEntriesTable> {
  $$LevelProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get levelId => $composableBuilder(
    column: $table.levelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filledRegionIds => $composableBuilder(
    column: $table.filledRegionIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get starRating => $composableBuilder(
    column: $table.starRating,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LevelProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LevelProgressEntriesTable> {
  $$LevelProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get levelId =>
      $composableBuilder(column: $table.levelId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get filledRegionIds => $composableBuilder(
    column: $table.filledRegionIds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get starRating => $composableBuilder(
    column: $table.starRating,
    builder: (column) => column,
  );
}

class $$LevelProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LevelProgressEntriesTable,
          LevelProgressEntry,
          $$LevelProgressEntriesTableFilterComposer,
          $$LevelProgressEntriesTableOrderingComposer,
          $$LevelProgressEntriesTableAnnotationComposer,
          $$LevelProgressEntriesTableCreateCompanionBuilder,
          $$LevelProgressEntriesTableUpdateCompanionBuilder,
          (
            LevelProgressEntry,
            BaseReferences<
              _$AppDatabase,
              $LevelProgressEntriesTable,
              LevelProgressEntry
            >,
          ),
          LevelProgressEntry,
          PrefetchHooks Function()
        > {
  $$LevelProgressEntriesTableTableManager(
    _$AppDatabase db,
    $LevelProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LevelProgressEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LevelProgressEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LevelProgressEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> levelId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> filledRegionIds = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int?> starRating = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LevelProgressEntriesCompanion(
                levelId: levelId,
                status: status,
                filledRegionIds: filledRegionIds,
                completedAt: completedAt,
                starRating: starRating,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String levelId,
                Value<String> status = const Value.absent(),
                Value<String> filledRegionIds = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int?> starRating = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LevelProgressEntriesCompanion.insert(
                levelId: levelId,
                status: status,
                filledRegionIds: filledRegionIds,
                completedAt: completedAt,
                starRating: starRating,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LevelProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LevelProgressEntriesTable,
      LevelProgressEntry,
      $$LevelProgressEntriesTableFilterComposer,
      $$LevelProgressEntriesTableOrderingComposer,
      $$LevelProgressEntriesTableAnnotationComposer,
      $$LevelProgressEntriesTableCreateCompanionBuilder,
      $$LevelProgressEntriesTableUpdateCompanionBuilder,
      (
        LevelProgressEntry,
        BaseReferences<
          _$AppDatabase,
          $LevelProgressEntriesTable,
          LevelProgressEntry
        >,
      ),
      LevelProgressEntry,
      PrefetchHooks Function()
    >;
typedef $$CompanionsTableCreateCompanionBuilder =
    CompanionsCompanion Function({
      required String id,
      Value<bool> unlocked,
      Value<int> evolutionStage,
      Value<int> rowid,
    });
typedef $$CompanionsTableUpdateCompanionBuilder =
    CompanionsCompanion Function({
      Value<String> id,
      Value<bool> unlocked,
      Value<int> evolutionStage,
      Value<int> rowid,
    });

class $$CompanionsTableFilterComposer
    extends Composer<_$AppDatabase, $CompanionsTable> {
  $$CompanionsTableFilterComposer({
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

  ColumnFilters<bool> get unlocked => $composableBuilder(
    column: $table.unlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evolutionStage => $composableBuilder(
    column: $table.evolutionStage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompanionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanionsTable> {
  $$CompanionsTableOrderingComposer({
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

  ColumnOrderings<bool> get unlocked => $composableBuilder(
    column: $table.unlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evolutionStage => $composableBuilder(
    column: $table.evolutionStage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompanionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanionsTable> {
  $$CompanionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get unlocked =>
      $composableBuilder(column: $table.unlocked, builder: (column) => column);

  GeneratedColumn<int> get evolutionStage => $composableBuilder(
    column: $table.evolutionStage,
    builder: (column) => column,
  );
}

class $$CompanionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompanionsTable,
          Companion,
          $$CompanionsTableFilterComposer,
          $$CompanionsTableOrderingComposer,
          $$CompanionsTableAnnotationComposer,
          $$CompanionsTableCreateCompanionBuilder,
          $$CompanionsTableUpdateCompanionBuilder,
          (
            Companion,
            BaseReferences<_$AppDatabase, $CompanionsTable, Companion>,
          ),
          Companion,
          PrefetchHooks Function()
        > {
  $$CompanionsTableTableManager(_$AppDatabase db, $CompanionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<bool> unlocked = const Value.absent(),
                Value<int> evolutionStage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompanionsCompanion(
                id: id,
                unlocked: unlocked,
                evolutionStage: evolutionStage,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<bool> unlocked = const Value.absent(),
                Value<int> evolutionStage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompanionsCompanion.insert(
                id: id,
                unlocked: unlocked,
                evolutionStage: evolutionStage,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompanionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompanionsTable,
      Companion,
      $$CompanionsTableFilterComposer,
      $$CompanionsTableOrderingComposer,
      $$CompanionsTableAnnotationComposer,
      $$CompanionsTableCreateCompanionBuilder,
      $$CompanionsTableUpdateCompanionBuilder,
      (Companion, BaseReferences<_$AppDatabase, $CompanionsTable, Companion>),
      Companion,
      PrefetchHooks Function()
    >;
typedef $$IslandResourceEntriesTableCreateCompanionBuilder =
    IslandResourceEntriesCompanion Function({
      Value<int> id,
      Value<int> wood,
      Value<int> stone,
      Value<int> crystal,
      Value<int> food,
      Value<int> gold,
    });
typedef $$IslandResourceEntriesTableUpdateCompanionBuilder =
    IslandResourceEntriesCompanion Function({
      Value<int> id,
      Value<int> wood,
      Value<int> stone,
      Value<int> crystal,
      Value<int> food,
      Value<int> gold,
    });

class $$IslandResourceEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $IslandResourceEntriesTable> {
  $$IslandResourceEntriesTableFilterComposer({
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

  ColumnFilters<int> get wood => $composableBuilder(
    column: $table.wood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stone => $composableBuilder(
    column: $table.stone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get crystal => $composableBuilder(
    column: $table.crystal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get food => $composableBuilder(
    column: $table.food,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IslandResourceEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $IslandResourceEntriesTable> {
  $$IslandResourceEntriesTableOrderingComposer({
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

  ColumnOrderings<int> get wood => $composableBuilder(
    column: $table.wood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stone => $composableBuilder(
    column: $table.stone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get crystal => $composableBuilder(
    column: $table.crystal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get food => $composableBuilder(
    column: $table.food,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IslandResourceEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IslandResourceEntriesTable> {
  $$IslandResourceEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get wood =>
      $composableBuilder(column: $table.wood, builder: (column) => column);

  GeneratedColumn<int> get stone =>
      $composableBuilder(column: $table.stone, builder: (column) => column);

  GeneratedColumn<int> get crystal =>
      $composableBuilder(column: $table.crystal, builder: (column) => column);

  GeneratedColumn<int> get food =>
      $composableBuilder(column: $table.food, builder: (column) => column);

  GeneratedColumn<int> get gold =>
      $composableBuilder(column: $table.gold, builder: (column) => column);
}

class $$IslandResourceEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IslandResourceEntriesTable,
          IslandResourceEntry,
          $$IslandResourceEntriesTableFilterComposer,
          $$IslandResourceEntriesTableOrderingComposer,
          $$IslandResourceEntriesTableAnnotationComposer,
          $$IslandResourceEntriesTableCreateCompanionBuilder,
          $$IslandResourceEntriesTableUpdateCompanionBuilder,
          (
            IslandResourceEntry,
            BaseReferences<
              _$AppDatabase,
              $IslandResourceEntriesTable,
              IslandResourceEntry
            >,
          ),
          IslandResourceEntry,
          PrefetchHooks Function()
        > {
  $$IslandResourceEntriesTableTableManager(
    _$AppDatabase db,
    $IslandResourceEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IslandResourceEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$IslandResourceEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$IslandResourceEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wood = const Value.absent(),
                Value<int> stone = const Value.absent(),
                Value<int> crystal = const Value.absent(),
                Value<int> food = const Value.absent(),
                Value<int> gold = const Value.absent(),
              }) => IslandResourceEntriesCompanion(
                id: id,
                wood: wood,
                stone: stone,
                crystal: crystal,
                food: food,
                gold: gold,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wood = const Value.absent(),
                Value<int> stone = const Value.absent(),
                Value<int> crystal = const Value.absent(),
                Value<int> food = const Value.absent(),
                Value<int> gold = const Value.absent(),
              }) => IslandResourceEntriesCompanion.insert(
                id: id,
                wood: wood,
                stone: stone,
                crystal: crystal,
                food: food,
                gold: gold,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IslandResourceEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IslandResourceEntriesTable,
      IslandResourceEntry,
      $$IslandResourceEntriesTableFilterComposer,
      $$IslandResourceEntriesTableOrderingComposer,
      $$IslandResourceEntriesTableAnnotationComposer,
      $$IslandResourceEntriesTableCreateCompanionBuilder,
      $$IslandResourceEntriesTableUpdateCompanionBuilder,
      (
        IslandResourceEntry,
        BaseReferences<
          _$AppDatabase,
          $IslandResourceEntriesTable,
          IslandResourceEntry
        >,
      ),
      IslandResourceEntry,
      PrefetchHooks Function()
    >;
typedef $$EntitlementsTableCreateCompanionBuilder =
    EntitlementsCompanion Function({
      required String sku,
      required DateTime purchasedAt,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$EntitlementsTableUpdateCompanionBuilder =
    EntitlementsCompanion Function({
      Value<String> sku,
      Value<DateTime> purchasedAt,
      Value<bool> active,
      Value<int> rowid,
    });

class $$EntitlementsTableFilterComposer
    extends Composer<_$AppDatabase, $EntitlementsTable> {
  $$EntitlementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EntitlementsTableOrderingComposer
    extends Composer<_$AppDatabase, $EntitlementsTable> {
  $$EntitlementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EntitlementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntitlementsTable> {
  $$EntitlementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$EntitlementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntitlementsTable,
          Entitlement,
          $$EntitlementsTableFilterComposer,
          $$EntitlementsTableOrderingComposer,
          $$EntitlementsTableAnnotationComposer,
          $$EntitlementsTableCreateCompanionBuilder,
          $$EntitlementsTableUpdateCompanionBuilder,
          (
            Entitlement,
            BaseReferences<_$AppDatabase, $EntitlementsTable, Entitlement>,
          ),
          Entitlement,
          PrefetchHooks Function()
        > {
  $$EntitlementsTableTableManager(_$AppDatabase db, $EntitlementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntitlementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntitlementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntitlementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sku = const Value.absent(),
                Value<DateTime> purchasedAt = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntitlementsCompanion(
                sku: sku,
                purchasedAt: purchasedAt,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sku,
                required DateTime purchasedAt,
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntitlementsCompanion.insert(
                sku: sku,
                purchasedAt: purchasedAt,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EntitlementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntitlementsTable,
      Entitlement,
      $$EntitlementsTableFilterComposer,
      $$EntitlementsTableOrderingComposer,
      $$EntitlementsTableAnnotationComposer,
      $$EntitlementsTableCreateCompanionBuilder,
      $$EntitlementsTableUpdateCompanionBuilder,
      (
        Entitlement,
        BaseReferences<_$AppDatabase, $EntitlementsTable, Entitlement>,
      ),
      Entitlement,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayerProfilesTableTableManager get playerProfiles =>
      $$PlayerProfilesTableTableManager(_db, _db.playerProfiles);
  $$LevelProgressEntriesTableTableManager get levelProgressEntries =>
      $$LevelProgressEntriesTableTableManager(_db, _db.levelProgressEntries);
  $$CompanionsTableTableManager get companions =>
      $$CompanionsTableTableManager(_db, _db.companions);
  $$IslandResourceEntriesTableTableManager get islandResourceEntries =>
      $$IslandResourceEntriesTableTableManager(_db, _db.islandResourceEntries);
  $$EntitlementsTableTableManager get entitlements =>
      $$EntitlementsTableTableManager(_db, _db.entitlements);
}
