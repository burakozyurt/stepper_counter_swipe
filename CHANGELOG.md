# Changelog

## [2.0.0] - 2026-02-28

#### Breaking — Migration Required

- **`stepperValue` parameter removed.**
  The widget now manages its own counter state internally, starting from `initialValue`.
  If you were passing `stepperValue` separately, simply remove it — `initialValue` is sufficient to set the starting value.
  The current value is still reported on every change via the `onChanged` callback.

- **Dart SDK constraint updated to `>=3.0.0 <4.0.0`.**
  Dart 2.x is no longer supported. Make sure your project targets Dart 3 or higher.

#### Added

- New `step` parameter to control the increment/decrement amount per swipe (default: `1`).
  For example, `step: 10` makes the counter increase/decrease by 10 each time.
  The value is automatically clamped to `minValue`/`maxValue` boundaries even when using large step values.

#### Changed

- Widget fields are now fully immutable (`final`), correctly following Flutter's `StatefulWidget` contract.
  Previously, `stepperValue` and `minValue` were mutable widget fields, which is against Flutter's design principles.
  Both are now properly managed inside the widget's `State`.

- Replaced deprecated `Colors.withOpacity()` with `Colors.withAlpha()` to stay compatible with current Flutter versions.

#### Fixed

- `flutter analyze` now reports zero issues and zero warnings across the entire package.

---

## [1.0.2] - 2022-03-05

- Migrated to null-safety (Dart >= 2.12)

---

## [1.0.0] - 2020-11-23

- Stable version released

---

## [0.0.6] - 2020-07-08

- Fast count hit zone feature added

---

## [0.0.1] - Initial release
