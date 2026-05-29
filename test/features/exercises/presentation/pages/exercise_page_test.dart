import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fonemas_app/generated/l10n/app_localizations.dart';
import 'package:fonemas_app/ui/features/exercises/views/exercise_page.dart';
import 'package:fonemas_app/ui/features/exercises/view_models/exercise_view_model.dart';
import 'package:fonemas_app/data/repositories/mock_exercise_repository.dart';

void main() {
  testWidgets('ExercisePage integration flow test', (WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/exercise/sons_liquidos',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('RootPage')),
        ),
        GoRoute(
          path: '/track/:trackId',
          builder: (context, state) => Scaffold(
            body: Text('TrackPage: ${state.pathParameters['trackId']}'),
          ),
        ),
        GoRoute(
          path: '/exercise/:trackId',
          builder: (context, state) {
            final trackId = state.pathParameters['trackId']!;
            return ChangeNotifierProvider(
              create: (_) => ExerciseViewModel(MockExerciseRepository())..loadExercises(trackId),
              child: ExercisePage(trackId: trackId),
            );
          },
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('pt'),
        ],
      ),
    );

    // Initial state: loading indicator is shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Let the mock repository load its list of 3 exercises (300ms delay + pump)
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();

    // Now it should show the first exercise prompt and 2 options ("Arara", "Baleia")
    expect(find.text('Onde está o som certo?'), findsOneWidget);
    expect(find.text('Arara'), findsOneWidget);
    expect(find.text('Baleia'), findsOneWidget);
    expect(find.text('Exercício 1 de 3'), findsOneWidget);

    // Test incorrect answer: Tap "Baleia"
    final baleiaFinder = find.text('Baleia');
    await tester.ensureVisible(baleiaFinder);
    await tester.tap(baleiaFinder);
    await tester.pump(); // Start animations/state change
    
    // Wait for the reset timer (1000ms) to fire:
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pump();

    // After reset, we should still be on Exercise 1, and no option should be selected.
    expect(find.text('Exercício 1 de 3'), findsOneWidget);

    // Test correct answer: Tap "Arara"
    final araraFinder1 = find.text('Arara');
    await tester.ensureVisible(araraFinder1);
    await tester.tap(araraFinder1);
    await tester.pump(); // Change state
    
    // Wait for transition delay (1200ms) to go to next exercise:
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle(); // Settle transition if any

    // Should now be on Exercise 2
    expect(find.text('Exercício 2 de 3'), findsOneWidget);
    // Exercise 2 has 4 options: Arara, Raposa, Coelho, Tartaruga
    expect(find.text('Arara'), findsOneWidget);
    expect(find.text('Raposa'), findsOneWidget);
    expect(find.text('Coelho'), findsOneWidget);
    expect(find.text('Tartaruga'), findsOneWidget);

    // Correct option for Exercise 2 is "Arara" as well. Tap "Arara"
    final araraFinder2 = find.text('Arara');
    await tester.ensureVisible(araraFinder2);
    await tester.tap(araraFinder2);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    // Should now be on Exercise 3 (Text fallback)
    expect(find.text('Exercício 3 de 3'), findsOneWidget);
    expect(find.text('Qual palavra inicia com /f/?'), findsOneWidget);
    expect(find.text('Faca'), findsOneWidget);
    expect(find.text('Vaca'), findsOneWidget);

    // Correct option for Exercise 3 is "Faca". Tap "Faca"
    final facaFinder = find.text('Faca');
    await tester.ensureVisible(facaFinder);
    await tester.tap(facaFinder);
    await tester.pump();
    
    // After 1200ms, it should show the celebration dialog
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    // Verify celebration dialog elements are shown
    expect(find.text('Parabéns!'), findsOneWidget);
    expect(find.text('Você concluiu com sucesso todos os exercícios de Pares Mínimos!'), findsOneWidget);
    expect(find.text('VOLTAR PARA A TRILHA'), findsOneWidget);

    // Tap "VOLTAR PARA A TRILHA" to go back to track page
    await tester.tap(find.text('VOLTAR PARA A TRILHA'));
    await tester.pumpAndSettle();

    // Verify we have navigated back to the track page (which is simulated by the router popping)
    expect(find.text('TrackPage: sons_liquidos'), findsOneWidget);
  });
}
