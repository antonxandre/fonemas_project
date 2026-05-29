import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n/app_localizations.dart';
import 'ui/core/navigation/router.dart';
import 'ui/features/learning_path/view_models/learning_path_view_model.dart';
import 'ui/features/study/view_models/study_view_model.dart';
import 'data/repositories/mock_learning_path_repository.dart';
import 'data/repositories/mock_study_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LearningPathViewModel(MockLearningPathRepository())..loadTracks(),
        ),
        ChangeNotifierProvider(
          create: (_) => StudyViewModel(MockStudyRepository())..loadBooks(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
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
    );
  }
}
