import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n/app_localizations.dart';
import 'ui/core/navigation/router.dart';
import 'ui/features/learning_path/view_models/learning_path_view_model.dart';
import 'ui/features/study/view_models/study_view_model.dart';
import 'data/repositories/mock_learning_path_repository.dart';
import 'data/repositories/mock_study_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'ui/features/auth/view_models/auth_view_model.dart';
import 'data/repositories/firebase_auth_repository.dart';
import 'data/seeders/phoneme_seeder.dart';
import 'data/seeders/exercise_seeder.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Seed data if database is empty
  await PhonemeSeeder().seedIfNeeded();
  await ExerciseSeeder().seedIfNeeded();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(FirebaseAuthRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => LearningPathViewModel(MockLearningPathRepository())..loadTracks(),
        ),
        ChangeNotifierProvider(
          create: (_) => StudyViewModel(MockStudyRepository())..loadBooks(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = createMikiRouter(context.read<AuthViewModel>());
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
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
          );
        },
      ),
    );
  }
}
