import 'package:equatable/equatable.dart';
import '../../domain/entities/exercise.dart';

sealed class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object?> get props => [];
}

class ExerciseInitial extends ExerciseState {
  const ExerciseInitial();
}

class ExerciseLoading extends ExerciseState {
  const ExerciseLoading();
}

class ExerciseLoaded extends ExerciseState {
  final List<Exercise> exercises;
  final int currentIndex;
  final String? selectedOption;
  final bool? isAnswerCorrect;
  final bool isReplayingAudio;
  final bool isCompleted;

  const ExerciseLoaded({
    required this.exercises,
    this.currentIndex = 0,
    this.selectedOption,
    this.isAnswerCorrect,
    this.isReplayingAudio = false,
    this.isCompleted = false,
  });

  Exercise get currentExercise => exercises[currentIndex];

  ExerciseLoaded copyWith({
    List<Exercise>? exercises,
    int? currentIndex,
    String? selectedOption,
    bool? isAnswerCorrect,
    bool? isReplayingAudio,
    bool? isCompleted,
  }) {
    return ExerciseLoaded(
      exercises: exercises ?? this.exercises,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedOption: selectedOption,
      isAnswerCorrect: isAnswerCorrect,
      isReplayingAudio: isReplayingAudio ?? this.isReplayingAudio,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        exercises,
        currentIndex,
        selectedOption,
        isAnswerCorrect,
        isReplayingAudio,
        isCompleted,
      ];
}

class ExerciseError extends ExerciseState {
  final String message;

  const ExerciseError(this.message);

  @override
  List<Object?> get props => [message];
}
