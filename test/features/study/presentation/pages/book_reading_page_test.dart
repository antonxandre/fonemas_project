import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fonemas_app/generated/l10n/app_localizations.dart';
import 'package:fonemas_app/ui/features/study/views/book_reading_page.dart';
import 'package:fonemas_app/ui/features/study/view_models/book_reading_view_model.dart';
import 'package:fonemas_app/data/repositories/mock_study_repository.dart';

void main() {
  testWidgets('BookReadingPage renders pages and handles page turning flow', (WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/study/read/jornada_pequeno_som',
      routes: [
        GoRoute(
          path: '/study',
          builder: (context, state) => const Scaffold(body: Text('StudyHomePage')),
        ),
        GoRoute(
          path: '/study/read/:bookId',
          builder: (context, state) {
            final bookId = state.pathParameters['bookId']!;
            return ChangeNotifierProvider(
              create: (_) => BookReadingViewModel(MockStudyRepository())..loadBook(bookId),
              child: BookReadingPage(bookId: bookId),
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

    // Initial loading indicator is shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Let the mock study repository load (100ms delay + pump)
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();

    // Verify first page content
    expect(
      find.text('O Pequeno Som caminhava por entre as árvores gigantes, onde o silêncio era uma música suave que esperava para ser cantada.'),
      findsOneWidget,
    );
    expect(find.text('1 de 3'), findsOneWidget);

    // Tapping left chevron should do nothing since we are on page 1
    final prevButtonFinder = find.byIcon(Icons.chevron_left);
    await tester.tap(prevButtonFinder);
    await tester.pump();

    // Text should remain the same
    expect(find.text('1 de 3'), findsOneWidget);

    // Tap right chevron to go to page 2
    final nextButtonFinder = find.byIcon(Icons.chevron_right);
    await tester.tap(nextButtonFinder);
    await tester.pump();

    // Text should update to page 2
    expect(
      find.text('Ele subiu no topo da montanha e soprou o vento leve: "Sssss... Lllll..." Cada letra parecia um passarinho voando.'),
      findsOneWidget,
    );
    expect(find.text('2 de 3'), findsOneWidget);

    // Tap right chevron to go to page 3 (last page)
    await tester.tap(nextButtonFinder);
    await tester.pump();

    // Text should update to page 3
    expect(
      find.text('Ao final do dia, o som encontrou seu eco na caverna brilhante: "Olá, amigo! Agora posso cantar alto!" E sorriu feliz.'),
      findsOneWidget,
    );
    expect(find.text('3 de 3'), findsOneWidget);

    // Tap right chevron on the last page should show the completion celebration dialog
    await tester.tap(nextButtonFinder);
    await tester.pumpAndSettle();

    // Verify celebration dialog elements are visible
    expect(find.text('Leitura Concluída!'), findsOneWidget);
    expect(find.text('VOLTAR PARA A TRILHA'), findsOneWidget); // Matches l10n.backToTrack ("VOLTAR PARA A TRILHA")

    // Tap return button to return to Study Page
    await tester.tap(find.text('VOLTAR PARA A TRILHA'));
    await tester.pumpAndSettle();

    // Verify we navigated back to /study (StudyHomePage mockup)
    expect(find.text('StudyHomePage'), findsOneWidget);
  });
}
