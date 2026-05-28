import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:fonemas_app/features/study/presentation/pages/study_page.dart';
import 'package:fonemas_app/features/study/presentation/bloc/study_cubit.dart';
import 'package:fonemas_app/features/study/data/repositories/mock_study_repository.dart';

void main() {
  testWidgets('StudyPage renders books and navigates', (WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/study',
      routes: [
        GoRoute(
          path: '/study',
          builder: (context, state) => BlocProvider(
            create: (_) => StudyCubit(MockStudyRepository())..loadBooks(),
            child: const StudyPage(),
          ),
        ),
        GoRoute(
          path: '/study/read/:bookId',
          builder: (context, state) => Scaffold(
            body: Text('ReadingBookPage: ${state.pathParameters['bookId']}'),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    // Initial loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Let the mock study repository load (200ms delay + pump)
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump();

    // Verify static content
    expect(find.text('Área de Estudos'), findsOneWidget);
    expect(find.text('Explore histórias e aprenda brincando.'), findsOneWidget);

    // Verify recommended book card
    expect(find.text('A Jornada do Pequeno Som'), findsOneWidget);
    expect(find.text('LER AGORA'), findsOneWidget);

    // Verify grid items
    expect(find.text('A Arara Azul'), findsOneWidget);
    expect(find.text('O Amigo Baleia'), findsOneWidget);
    expect(find.text('O Coelho Branco'), findsOneWidget);

    // Verify coming soon
    expect(find.text('Novas histórias\nem breve'), findsOneWidget);

    // Scroll the button into view by dragging the scroll view
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -400));
    await tester.pump();

    // Tap "LER AGORA" to navigate to read page
    final buttonFinder = find.text('LER AGORA');
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // Verify we transitioned to the reading page mock
    expect(find.text('ReadingBookPage: jornada_pequeno_som'), findsOneWidget);
  });
}
