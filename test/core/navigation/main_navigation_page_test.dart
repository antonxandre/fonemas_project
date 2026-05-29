import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fonemas_app/generated/l10n/app_localizations.dart';
import 'package:fonemas_app/ui/core/widgets/miki_bottom_nav_bar.dart';
import 'package:fonemas_app/ui/features/learning_path/view_models/learning_path_view_model.dart';
import 'package:fonemas_app/data/repositories/mock_learning_path_repository.dart';
import 'package:fonemas_app/ui/features/study/view_models/study_view_model.dart';
import 'package:fonemas_app/data/repositories/mock_study_repository.dart';
import 'package:fonemas_app/ui/core/navigation/router.dart';

void main() {
  testWidgets('MainNavigationPage renders and switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LearningPathViewModel(MockLearningPathRepository())..loadTracks(),
          ),
          ChangeNotifierProvider(
            create: (_) => StudyViewModel(MockStudyRepository())..loadBooks(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: mikiRouter,
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
      ),
    );

    // Expect MikiBottomNavigationBar to be rendered
    expect(find.byType(MikiBottomNavigationBar), findsOneWidget);

    // Let the mock repositories load data (300ms delay + buffer)
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    // Verify Trilha is showing (renders "Trilhas de Aprendizado" from AppLocalizations)
    expect(find.text('Trilhas de Aprendizado'), findsOneWidget);

    // Tap ESTUDOS on bottom bar
    await tester.tap(find.text('ESTUDOS'));
    await tester.pumpAndSettle(); // Process GoRouter navigation

    // Verify StudyPage is showing (renders "Área de Estudos")
    expect(find.text('Área de Estudos'), findsOneWidget);

    // Tap PERFIL on bottom bar
    await tester.tap(find.text('PERFIL'));
    await tester.pumpAndSettle(); // Process GoRouter navigation

    // Verify ProfilePage is showing (renders "Miki Style")
    expect(find.text('Miki Style'), findsOneWidget);
  });
}
