import 'package:flutter/material.dart';
import '../../../../../domain/models/exercise.dart';
import '../strategies/exercise_strategy.dart';
import '../strategies/minimal_pairs_strategy.dart';

class ExerciseBuilder extends StatelessWidget {
  final Exercise exercise;
  final String? selectedOption;
  final bool? isAnswerCorrect;
  final ValueChanged<String> onOptionSelected;

  const ExerciseBuilder({
    super.key,
    required this.exercise,
    required this.selectedOption,
    required this.isAnswerCorrect,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Map the exercise type to the corresponding strategy.
    // For now we support 'minimal_pairs', and default to MinimalPairsStrategy.
    ExerciseStrategy strategy;
    switch (exercise.type) {
      case 'minimal_pairs':
      default:
        strategy = const MinimalPairsStrategy();
        break;
    }

    return strategy.buildWidget(
      exercise: exercise,
      selectedOption: selectedOption,
      isAnswerCorrect: isAnswerCorrect,
      onOptionSelected: onOptionSelected,
    );
  }
}
