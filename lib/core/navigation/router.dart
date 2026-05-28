import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'main_navigation_page.dart';
import '../../features/learning_path/presentation/pages/track_sub_path_page.dart';
import '../../features/exercises/presentation/pages/exercise_page.dart';
import '../../features/exercises/presentation/bloc/exercise_cubit.dart';
import '../../features/exercises/data/repositories/mock_exercise_repository.dart';
import '../../features/study/presentation/pages/book_reading_page.dart';
import '../../features/study/presentation/bloc/book_reading_cubit.dart';
import '../../features/study/data/repositories/mock_study_repository.dart';

final GoRouter mikiRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: MainNavigationPage(initialIndex: 0),
      ),
    ),
    GoRoute(
      path: '/track/:trackId',
      builder: (context, state) {
        final trackId = state.pathParameters['trackId'] ?? 'alveolares';
        return TrackSubPathPage(trackId: trackId);
      },
    ),
    GoRoute(
      path: '/exercise/:trackId',
      builder: (context, state) {
        final trackId = state.pathParameters['trackId'] ?? 'sons_liquidos';
        return BlocProvider(
          create: (_) => ExerciseCubit(MockExerciseRepository())..loadExercises(trackId),
          child: ExercisePage(trackId: trackId),
        );
      },
    ),
    GoRoute(
      path: '/study',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: MainNavigationPage(initialIndex: 1),
      ),
    ),
    GoRoute(
      path: '/study/read/:bookId',
      builder: (context, state) {
        final bookId = state.pathParameters['bookId'] ?? 'jornada_pequeno_som';
        return BlocProvider(
          create: (_) => BookReadingCubit(MockStudyRepository())..loadBook(bookId),
          child: BookReadingPage(bookId: bookId),
        );
      },
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: MainNavigationPage(initialIndex: 2),
      ),
    ),
  ],
);
