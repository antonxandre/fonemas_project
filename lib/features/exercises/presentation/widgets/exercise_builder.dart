import 'package:flutter/material.dart';
import '../../domain/entities/exercise.dart';
import '../strategies/exercise_strategy.dart';
import '../strategies/minimal_pairs_strategy.dart';

class ExerciseBuilder {
  // Registry mapping exercise type keys to their respective strategies
  static final Map<String, ExerciseStrategy> _strategies = {
    'minimal_pairs': const MinimalPairsStrategy(),
  };

  /// Register a new strategy at runtime (flexible extension)
  static void registerStrategy(String type, ExerciseStrategy strategy) {
    _strategies[type] = strategy;
  }

  /// Build the UI dynamically based on the exercise type
  static Widget build({
    required Exercise exercise,
    required String? selectedOption,
    required bool? isAnswerCorrect,
    required ValueChanged<String> onOptionSelected,
  }) {
    final strategy = _strategies[exercise.type];
    
    if (strategy == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Tipo de exercício não suportado: ${exercise.type}',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    return strategy.buildWidget(
      exercise: exercise,
      selectedOption: selectedOption,
      isAnswerCorrect: isAnswerCorrect,
      onOptionSelected: onOptionSelected,
    );
  }
}
