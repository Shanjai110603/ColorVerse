# 🖌️ ColorVerse Level Editor

> Standalone desktop authoring tool for ColorVerse level creation, region detection, mask encoding, and event sequencing.

---

## 🚀 Features

- **Image Import**: Load line art PNG and optional colored reference overlays.
- **Automated Region Detection**: Flood-fill segmentation with boundary calculation and centroid pinpointing.
- **Mask Encoder**: Encodes 24-bit RGB region masks: `RGB(0, n >> 8, n & 0xFF)`.
- **Trigger & Chain Sequencer**: Assign Rive animations, SFX assets, and cascading auto-fill chains.
- **Hidden Event Builder**: Define condition rules (`allRegionsFilled`, `anyRegionFilled`, time limits) and secret reveal triggers.
- **Integrity Validation**: Automated check for cyclical chains, missing assets, and unassigned slots before exporting.

---

## 💻 Running the Editor

```bash
# From tools/level_editor directory:
flutter pub get
flutter run -d windows # or macos / linux
```

## 🧪 Testing

```bash
flutter test
```
