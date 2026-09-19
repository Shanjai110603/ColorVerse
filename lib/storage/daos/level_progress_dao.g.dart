// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'level_progress_dao.dart';

// ignore_for_file: type=lint
mixin _$LevelProgressDaoMixin on DatabaseAccessor<AppDatabase> {
  $LevelProgressEntriesTable get levelProgressEntries =>
      attachedDatabase.levelProgressEntries;
  LevelProgressDaoManager get managers => LevelProgressDaoManager(this);
}

class LevelProgressDaoManager {
  final _$LevelProgressDaoMixin _db;
  LevelProgressDaoManager(this._db);
  $$LevelProgressEntriesTableTableManager get levelProgressEntries =>
      $$LevelProgressEntriesTableTableManager(
        _db.attachedDatabase,
        _db.levelProgressEntries,
      );
}
