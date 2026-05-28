import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/exercise_repository.dart';
import 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseRepository _repository;

  ExerciseCubit(this._repository) : super(const ExerciseInitial());

  Future<void> loadExercises(String trackId) async {
    emit(const ExerciseLoading());
    try {
      final exercises = await _repository.getExercisesForTrack(trackId);
      emit(ExerciseLoaded(exercises: exercises));
    } catch (e) {
      emit(ExerciseError(e.toString()));
    }
  }

  void selectOption(String option) async {
    final currentState = state;
    if (currentState is! ExerciseLoaded) return;
    if (currentState.isAnswerCorrect == true) return; // Prevent double taps during transition

    final currentExercise = currentState.currentExercise;
    final isCorrect = option == currentExercise.correctOption;

    emit(currentState.copyWith(
      selectedOption: option,
      isAnswerCorrect: isCorrect,
    ));

    if (isCorrect) {
      await Future.delayed(const Duration(milliseconds: 1200));
      
      final nextState = state;
      if (nextState is! ExerciseLoaded) return;

      if (nextState.currentIndex < nextState.exercises.length - 1) {
        emit(nextState.copyWith(
          currentIndex: nextState.currentIndex + 1,
          selectedOption: null,
          isAnswerCorrect: null,
        ));
      } else {
        emit(nextState.copyWith(isCompleted: true));
      }
    } else {
      // Wrong answer - shake and reset selection to try again after delay
      await Future.delayed(const Duration(milliseconds: 1000));
      final nextState = state;
      if (nextState is! ExerciseLoaded) return;
      emit(nextState.copyWith(
        selectedOption: null,
        isAnswerCorrect: null,
      ));
    }
  }

  Future<void> replayAudio() async {
    final currentState = state;
    if (currentState is! ExerciseLoaded) return;
    if (currentState.isReplayingAudio) return;

    emit(currentState.copyWith(isReplayingAudio: true));
    await Future.delayed(const Duration(milliseconds: 800));
    
    final nextState = state;
    if (nextState is! ExerciseLoaded) return;
    emit(nextState.copyWith(isReplayingAudio: false));
  }
}
