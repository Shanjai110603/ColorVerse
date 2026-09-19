// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'island_resources_dao.dart';

// ignore_for_file: type=lint
mixin _$IslandResourcesDaoMixin on DatabaseAccessor<AppDatabase> {
  $IslandResourceEntriesTable get islandResourceEntries =>
      attachedDatabase.islandResourceEntries;
  IslandResourcesDaoManager get managers => IslandResourcesDaoManager(this);
}

class IslandResourcesDaoManager {
  final _$IslandResourcesDaoMixin _db;
  IslandResourcesDaoManager(this._db);
  $$IslandResourceEntriesTableTableManager get islandResourceEntries =>
      $$IslandResourceEntriesTableTableManager(
        _db.attachedDatabase,
        _db.islandResourceEntries,
      );
}
