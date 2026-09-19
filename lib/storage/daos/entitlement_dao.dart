import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'entitlement_dao.g.dart';

/// Data Access Object for the [Entitlements] table.
///
/// Mirrors IAP entitlement state for reactive UI queries.
/// The actual purchase receipt validation happens via flutter_secure_storage
/// and the in_app_purchase plugin (Phase 10); this table is the reactive
/// query surface for UI (e.g., "show/hide ads" based on entitlement state).
@DriftAccessor(tables: [Entitlements])
class EntitlementDao extends DatabaseAccessor<AppDatabase>
    with _$EntitlementDaoMixin {
  EntitlementDao(super.db);

  /// Watch all entitlements reactively.
  Stream<List<Entitlement>> watchAll() => select(entitlements).watch();

  /// Check if a specific entitlement is active.
  Future<bool> isActive(String sku) async {
    final entry = await (select(entitlements)
          ..where((t) => t.sku.equals(sku)))
        .getSingleOrNull();
    return entry?.active ?? false;
  }

  /// Watch a specific entitlement's active state.
  Stream<bool> watchIsActive(String sku) =>
      (select(entitlements)..where((t) => t.sku.equals(sku)))
          .watchSingleOrNull()
          .map((entry) => entry?.active ?? false);

  /// Record a new purchase entitlement.
  Future<void> recordPurchase(String sku) async {
    await into(entitlements).insertOnConflictUpdate(
      EntitlementsCompanion.insert(
        sku: sku,
        purchasedAt: DateTime.now(),
      ),
    );
  }

  /// Deactivate an entitlement (e.g., subscription expired).
  Future<void> deactivate(String sku) async {
    await (update(entitlements)..where((t) => t.sku.equals(sku))).write(
      const EntitlementsCompanion(active: Value(false)),
    );
  }

  /// Reactivate an entitlement (e.g., subscription renewed).
  Future<void> reactivate(String sku) async {
    await (update(entitlements)..where((t) => t.sku.equals(sku))).write(
      const EntitlementsCompanion(active: Value(true)),
    );
  }
}
