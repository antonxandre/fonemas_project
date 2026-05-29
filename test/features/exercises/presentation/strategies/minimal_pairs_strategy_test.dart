import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fonemas_app/domain/models/exercise.dart';
import 'package:fonemas_app/ui/features/exercises/views/strategies/minimal_pairs_strategy.dart';

void main() {
  testWidgets('MinimalPairsStrategy renders 2-option image card row correctly', (WidgetTester tester) async {
    const exercise = Exercise(
      id: 'test_ex_1',
      type: 'minimal_pairs',
      prompt: 'Onde está o som certo?',
      correctOption: 'Arara',
      options: [
        ExerciseOption(text: 'Arara', imageUrl: 'https://example.com/arara.png'),
        ExerciseOption(text: 'Baleia', imageUrl: 'https://example.com/baleia.png'),
      ],
    );

    String? clickedOption;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: const MinimalPairsStrategy().buildWidget(
              exercise: exercise,
              selectedOption: null,
              isAnswerCorrect: null,
              onOptionSelected: (val) {
                clickedOption = val;
              },
            ),
          ),
        ),
      ),
    );

    // Verify prompt is rendered
    expect(find.text('Onde está o som certo?'), findsOneWidget);

    // Verify option labels are rendered
    expect(find.text('Arara'), findsOneWidget);
    expect(find.text('Baleia'), findsOneWidget);

    // Tap on option
    await tester.tap(find.text('Arara'));
    expect(clickedOption, equals('Arara'));
  });

  testWidgets('MinimalPairsStrategy renders 4-option image card grid correctly', (WidgetTester tester) async {
    const exercise = Exercise(
      id: 'test_ex_2',
      type: 'minimal_pairs',
      prompt: 'Encontre a Arara',
      correctOption: 'Arara',
      options: [
        ExerciseOption(text: 'Arara', imageUrl: 'https://example.com/arara.png'),
        ExerciseOption(text: 'Raposa', imageUrl: 'https://example.com/raposa.png'),
        ExerciseOption(text: 'Coelho', imageUrl: 'https://example.com/coelho.png'),
        ExerciseOption(text: 'Tartaruga', imageUrl: 'https://example.com/tartaruga.png'),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: const MinimalPairsStrategy().buildWidget(
              exercise: exercise,
              selectedOption: null,
              isAnswerCorrect: null,
              onOptionSelected: (_) {},
            ),
          ),
        ),
      ),
    );

    // Verify grid options are rendered
    expect(find.text('Arara'), findsOneWidget);
    expect(find.text('Raposa'), findsOneWidget);
    expect(find.text('Coelho'), findsOneWidget);
    expect(find.text('Tartaruga'), findsOneWidget);
  });

  testWidgets('MinimalPairsStrategy renders text fallback correctly', (WidgetTester tester) async {
    const exercise = Exercise(
      id: 'test_ex_3',
      type: 'minimal_pairs',
      prompt: 'Qual palavra inicia com /f/?',
      correctOption: 'Faca',
      options: [
        ExerciseOption(text: 'Faca'),
        ExerciseOption(text: 'Vaca'),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: const MinimalPairsStrategy().buildWidget(
              exercise: exercise,
              selectedOption: null,
              isAnswerCorrect: null,
              onOptionSelected: (_) {},
            ),
          ),
        ),
      ),
    );

    // Verify labels are rendered
    expect(find.text('Faca'), findsOneWidget);
    expect(find.text('Vaca'), findsOneWidget);
  });
}
