// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'entitlement_dao.dart';

// ignore_for_file: type=lint
mixin _$EntitlementDaoMixin on DatabaseAccessor<AppDatabase> {
  $EntitlementsTable get entitlements => attachedDatabase.entitlements;
  EntitlementDaoManager get managers => EntitlementDaoManager(this);
}

class EntitlementDaoManager {
  final _$EntitlementDaoMixin _db;
  EntitlementDaoManager(this._db);
  $$EntitlementsTableTableManager get entitlements =>
      $$EntitlementsTableTableManager(_db.attachedDatabase, _db.entitlements);
}
