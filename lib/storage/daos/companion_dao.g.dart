// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'companion_dao.dart';

// ignore_for_file: type=lint
mixin _$CompanionDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanionsTable get companions => attachedDatabase.companions;
  CompanionDaoManager get managers => CompanionDaoManager(this);
}

class CompanionDaoManager {
  final _$CompanionDaoMixin _db;
  CompanionDaoManager(this._db);
  $$CompanionsTableTableManager get companions =>
      $$CompanionsTableTableManager(_db.attachedDatabase, _db.companions);
}
