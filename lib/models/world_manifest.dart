/// Metadata definition for a level entry in the world manifest.
class LevelManifestEntry {
  final String levelId;
  final String displayName;
  final String world;
  final String difficulty;
  final int regionCount;
  final int requiredXp;
  final String? requiredLevelId;

  const LevelManifestEntry({
    required this.levelId,
    required this.displayName,
    required this.world,
    required this.difficulty,
    required this.regionCount,
    this.requiredXp = 0,
    this.requiredLevelId,
  });

  factory LevelManifestEntry.fromJson(Map<String, dynamic> json) {
    return LevelManifestEntry(
      levelId: json['levelId'] as String,
      displayName: json['displayName'] as String,
      world: json['world'] as String,
      difficulty: json['difficulty'] as String,
      regionCount: json['regionCount'] as int,
      requiredXp: json['requiredXp'] as int? ?? 0,
      requiredLevelId: json['requiredLevelId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'levelId': levelId,
        'displayName': displayName,
        'world': world,
        'difficulty': difficulty,
        'regionCount': regionCount,
        'requiredXp': requiredXp,
        'requiredLevelId': requiredLevelId,
      };
}

/// Metadata definition for a world (zone/biome) in the world manifest.
class WorldEntry {
  final String id;
  final String displayName;
  final int order;
  final String iconAsset;
  final List<LevelManifestEntry> levels;

  const WorldEntry({
    required this.id,
    required this.displayName,
    required this.order,
    required this.iconAsset,
    required this.levels,
  });

  factory WorldEntry.fromJson(Map<String, dynamic> json) {
    final levelsList = (json['levels'] as List<dynamic>)
        .map((e) => LevelManifestEntry.fromJson(e as Map<String, dynamic>))
        .toList();

    return WorldEntry(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      order: json['order'] as int,
      iconAsset: json['iconAsset'] as String,
      levels: levelsList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'order': order,
        'iconAsset': iconAsset,
        'levels': levels.map((e) => e.toJson()).toList(),
      };
}

/// Complete world manifest container.
class WorldManifest {
  final List<WorldEntry> worlds;

  const WorldManifest({required this.worlds});

  factory WorldManifest.fromJson(Map<String, dynamic> json) {
    final worldsList = (json['worlds'] as List<dynamic>)
        .map((e) => WorldEntry.fromJson(e as Map<String, dynamic>))
        .toList();

    return WorldManifest(worlds: worldsList);
  }

  Map<String, dynamic> toJson() => {
        'worlds': worlds.map((e) => e.toJson()).toList(),
      };
}
