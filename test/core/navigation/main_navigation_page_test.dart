import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fonemas_app/core/widgets/miki_bottom_nav_bar.dart';
import 'package:fonemas_app/features/learning_path/presentation/bloc/learning_path_cubit.dart';
import 'package:fonemas_app/features/learning_path/data/repositories/mock_learning_path_repository.dart';
import 'package:fonemas_app/features/study/presentation/bloc/study_cubit.dart';
import 'package:fonemas_app/features/study/data/repositories/mock_study_repository.dart';

import 'package:fonemas_app/core/navigation/router.dart';

void main() {
  testWidgets('MainNavigationPage renders PageView and switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LearningPathCubit(MockLearningPathRepository())..loadTracks()),
          BlocProvider(create: (_) => StudyCubit(MockStudyRepository())..loadBooks()),
        ],
        child: MaterialApp.router(
          routerConfig: mikiRouter,
        ),
      ),
    );

    // Expect PageView and MikiBottomNavigationBar to be rendered
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(MikiBottomNavigationBar), findsOneWidget);

    // Let the mock repositories load data (200ms delay + buffer)
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    // Verify Trilha is showing (renders "Trilhas de Aprendizado")
    expect(find.text('Trilhas de Aprendizado'), findsOneWidget);

    // Tap ESTUDOS on bottom bar
    await tester.tap(find.text('ESTUDOS'));
    await tester.pump(); // Process GoRouter navigation and trigger StudyCubit creation
    await tester.pump(const Duration(milliseconds: 300)); // Await repository load
    await tester.pump(); // Rebuild with loaded data

    // Verify StudyPage is showing (renders "Área de Estudos")
    expect(find.text('Área de Estudos'), findsOneWidget);

    // Tap PERFIL on bottom bar
    await tester.tap(find.text('PERFIL'));
    await tester.pump(); // Process GoRouter navigation
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();

    // Verify ProfilePage is showing (renders "Miki Style")
    expect(find.text('Miki Style'), findsOneWidget);
  });
}
