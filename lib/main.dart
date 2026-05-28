import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/navigation/router.dart';
import 'features/learning_path/presentation/bloc/learning_path_cubit.dart';
import 'features/learning_path/data/repositories/mock_learning_path_repository.dart';
import 'features/study/presentation/bloc/study_cubit.dart';
import 'features/study/data/repositories/mock_study_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LearningPathCubit(MockLearningPathRepository())..loadTracks(),
        ),
        BlocProvider(
          create: (_) => StudyCubit(MockStudyRepository())..loadBooks(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: mikiRouter,
      ),
    );
  }
}
