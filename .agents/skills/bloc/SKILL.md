---
name: fonokit-bloc-state-management
description: Strict enforcement of BLoC and Cubit for state management in the FonoKit Flutter application. Forbids the use of setState for business logic. Defines clear boundaries between Cubit (simple state) and BLoC (complex, event-driven state with transformers).
origin: FonoKit Architecture
---

# FonoKit State Management Strict Guidelines (BLoC & Cubit)

This checklist and rule set strictly enforces the use of the `flutter_bloc` package for all state management in the application. The use of `setState` for business logic or data fetching is strictly forbidden.

---

## 1. The `setState` Ban
- [ ] **Zero Business Logic in UI**: Never use `setState` to handle API calls, database queries, ML inference, or audio processing.
- [ ] **Permitted `setState` Exceptions**: `setState` is ONLY allowed for purely ephemeral, isolated UI-only animations (e.g., a local `AnimationController` or tracking a local hover/drag gesture state that no other widget cares about). 

---

## 2. When to Use Cubit (Simple State)
Use **Cubit** when the state transitions are straightforward and do not require complex event transformations.
- [ ] **Direct Method Calls**: The UI triggers state changes by directly calling functions on the Cubit (e.g., `cubit.toggleTheme()`, `cubit.selectPhoneme()`).
- [ ] **Synchronous or Simple Async**: Ideal for forms, simple toggles, static data loading, and standard CRUD operations where events map 1:1 to state emissions.
- [ ] **No Streams/Transformers**: If you do not need to debounce, throttle, or orchestrate multiple incoming streams, default to Cubit to reduce boilerplate.

---

## 3. When to Use BLoC (Complex State)
Use **BLoC** (Business Logic Component) when the feature is heavily event-driven, requires event transformations, or manages complex async pipelines.
- [ ] **Event-Driven Architecture**: The UI must never call methods directly. It must add events (e.g., `bloc.add(StartAudioRecording())`).
- [ ] **Transformers**: You MUST use BLoC when event transformers are needed (e.g., using `package:bloc_concurrency` for `droppable`, `restartable`, or custom debouncing on search inputs).
- [ ] **Complex Pipelines**: Use BLoC for the ML Audio Pipeline (e.g., orchestrating the start of 16kHz audio streams, piping data to Isolates, and yielding confidence scores in real-time).
- [ ] **State Machine Enforcement**: Use BLoC when strict chronological state transitions must be guaranteed and audited (e.g., `Initial` -> `Recording` -> `Processing` -> `Success`).

---

## 4. Implementation Rules & Best Practices
- [ ] **Immutability**: All States and Events MUST be created using `freezed` or `equatable` to ensure proper value comparison and prevent redundant UI rebuilds.
- [ ] **Sealed Classes**: Use Dart 3 `sealed` classes for State and Event bases to ensure exhaustive pattern matching in the UI.
- [ ] **Widget Consumers**: 
  - Use `BlocBuilder` strictly for rebuilding UI components.
  - Use `BlocListener` strictly for one-off side effects (e.g., showing a SnackBar, navigation, playing a success sound).
  - Use `BlocConsumer` when both rebuilding and side effects are needed simultaneously.
- [ ] **Scoping**: Provide BLoCs/Cubits as low in the widget tree as possible using `BlocProvider`. Do not pollute the global scope unless the state is truly application-wide (e.g., AuthBloc).
- [ ] **Build Optimization**: Always implement the `buildWhen` condition in `BlocBuilder` if the widget only cares about a specific property change within the state.

---

## 5. Example Enforcement

### ❌ BAD (Do NOT generate this)
Forbidden: using `setState` for fetching data or handling business logic.

```dart
// Forbidden logic inside a StatefulWidget
void fetchExercises() async {
  setState(() => isLoading = true);
  final data = await repo.getExercises();
  setState(() {
    exercises = data;
    isLoading = false;
  });
}
```

### ✅ GOOD (Generate this)

```dart
class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseRepository _repo;
  ExerciseCubit(this._repo) : super(const ExerciseState.initial());

  Future<void> loadExercises() async {
    emit(const ExerciseState.loading());
    try {
      final data = await _repo.getExercises();
      emit(ExerciseState.loaded(data));
    } catch (e) {
      emit(ExerciseState.error(e.toString()));
    }
  }
}
```
 

### ✅ GOOD (Generate this)

```dart
class AudioRecordingBloc extends Bloc<AudioEvent, AudioState> {
  AudioRecordingBloc() : super(const AudioState.idle()) {
    on<StartRecording>(
      _onStartRecording,
      transformer: droppable(), // Drops subsequent events while processing
    );
  }
  
  Future<void> _onStartRecording(StartRecording event, Emitter<AudioState> emit) async {
    emit(const AudioState.recording());
    // Complex stream processing, isolate spawning, etc.
  }
}
```
