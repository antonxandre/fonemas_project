---
name: fonokit-flutter-best-practices
description: Strict FonoKit-specific Flutter/Dart code best practices checklist enforcing Clean Architecture, BLoC state management, Isolate-based ML audio processing, Drift offline-first persistence, and the Miki Design System standards.
origin: FonoKit Architecture
---

# FonoKit Flutter/Dart Code Best Practices

Comprehensive checklist for reviewing the FonoKit Flutter application. This ensures strict adherence to Clean Architecture, offline-first reliability, clinical-grade performance, and the aesthetic guidelines of the project.

---

## 1. Clean Architecture & Project Health

- [ ] `lib/` directory strictly follows feature-first Clean Architecture (`core/` and `features/`).
- [ ] Each feature contains `domain/`, `data/`, and `presentation/` layers.
- [ ] **Domain Layer** is pure Dart (no `package:flutter` imports). Contains only Entities, UseCases, and Repository Interfaces.
- [ ] **Data Layer** contains Models (DTOs), Drift data sources, and Repository implementations.
- [ ] **Presentation Layer** contains only UI (Widgets) and State Management (BLoC/Cubit).
- [ ] No business logic exists inside Widgets. Widgets are purely presentational.
- [ ] Dependencies are injected via constructor (using `get_it` or Riverpod providers for DI), never instantiated inside classes.

---

## 2. Dart 3 Language & Immutability

- [ ] **Strict Null Safety**: No use of the bang operator (`!`). Use safe navigation (`?.`) or explicit null checks with early returns.
- [ ] **Records & Pattern Matching**: Use Dart 3 records `(String, int)` instead of throwaway classes for multiple return values.
- [ ] **Immutability**: All Models, Entities, and States are immutable. Use the `freezed` package for `copyWith` and value equality.
- [ ] **Sealed Classes**: Use `sealed` classes for BLoC states and events to ensure exhaustive `switch` statements at compile time.
- [ ] **No `print()`**: Use `dart:developer` `log()` or a custom logging service. No raw print statements in production code.

---

## 3. Miki Design System & Widget Best Practices

### Theming & Aesthetics:
- [ ] Colors strictly follow the Japanese pastel palette (`#F6F6F6`, `#373D4A`, `#C9CBF4`, `#D0EEF4`, `#F6C9C9`).
- [ ] No hardcoded colors (e.g., `Colors.red`). All colors must be referenced from the centralized Miki Design System theme.
- [ ] Text styles come from the central typography configuration (Plus Jakarta Sans) — no inline `TextStyle` with raw configurations.
- [ ] Fluidity: Use `ImplicitlyAnimatedWidget`s or `flutter_animate` for state transitions (e.g., error feedback, success celebrations). No harsh, instant UI cuts.

### Widget Performance:
- [ ] `const` constructors used wherever possible to prevent unnecessary rebuilds.
- [ ] Large `build()` methods (> 80 lines) are broken down into smaller, private `StatelessWidget` classes (not methods returning widgets).
- [ ] `build()` methods contain zero network calls, file I/O, or heavy computations.

---

## 4. State Management (BLoC / Cubit)

- [ ] **Cubit** is used for simple UI state flows (e.g., toggling tabs, expanding cards).
- [ ] **BLoC** is used for complex, event-driven state machines (e.g., Audio Pipeline: `StartRecording` → `ProcessInference` → `EmitResult`).
- [ ] Mutually exclusive states use sealed types (e.g., `ExerciseInitial`, `ExerciseRecording`, `ExerciseSuccess`), not boolean flags (`isRecording`, `isSuccess`).
- [ ] BLoCs/Cubits do not depend directly on other BLoCs. They communicate via shared repositories or Presentation-layer listeners.
- [ ] All manual subscriptions (Streams, Timers, Audio Controllers) are explicitly closed/cancelled in the `close()` method.
- [ ] UI state is scoped as narrowly as possible using `BlocBuilder` with strict `buildWhen` conditions to prevent rebuilding the entire screen.

```dart
// GOOD: Sealed types make impossible states unrepresentable
sealed class AudioExerciseState {}
class AudioExerciseInitial extends AudioExerciseState {}
class AudioExerciseRecording extends AudioExerciseState {}
class AudioExerciseSuccess extends AudioExerciseState {
  final double confidenceScore;
  const AudioExerciseSuccess(this.confidenceScore);
}
class AudioExerciseError extends AudioExerciseState {
  final String message;
  const AudioExerciseError(this.message);
}