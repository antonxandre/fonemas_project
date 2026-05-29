import 'package:flutter/material.dart';
import '../../../../../domain/models/exercise.dart';

abstract class ExerciseStrategy {
  Widget buildWidget({
    required Exercise exercise,
    required String? selectedOption,
    required bool? isAnswerCorrect,
    required ValueChanged<String> onOptionSelected,
  });
}
