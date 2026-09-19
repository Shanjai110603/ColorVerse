// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'player_profile_dao.dart';

// ignore_for_file: type=lint
mixin _$PlayerProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $PlayerProfilesTable get playerProfiles => attachedDatabase.playerProfiles;
  PlayerProfileDaoManager get managers => PlayerProfileDaoManager(this);
}

class PlayerProfileDaoManager {
  final _$PlayerProfileDaoMixin _db;
  PlayerProfileDaoManager(this._db);
  $$PlayerProfilesTableTableManager get playerProfiles =>
      $$PlayerProfilesTableTableManager(
        _db.attachedDatabase,
        _db.playerProfiles,
      );
}
