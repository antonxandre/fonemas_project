import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'main_navigation_page.dart';
import 'navigation_observer.dart';
import 'custom_page_transition.dart';
import '../../features/learning_path/views/learning_path_page.dart';
import '../../features/learning_path/views/track_sub_path_page.dart';
import '../../features/exercises/views/exercise_page.dart';
import '../../features/exercises/view_models/exercise_view_model.dart';
import '../../../data/repositories/mock_exercise_repository.dart';
import '../../features/study/views/study_page.dart';
import '../../features/study/views/book_reading_page.dart';
import '../../features/study/view_models/book_reading_view_model.dart';
import '../../../data/repositories/mock_study_repository.dart';
import '../../features/profile/views/profile_page.dart';

final GoRouter mikiRouter = GoRouter(
  initialLocation: '/',
  observers: [
    MikiNavigationObserver(name: 'Root'),
  ],
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          observers: [
            MikiNavigationObserver(name: 'Branch-Trilha'),
          ],
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const LearningPathPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          observers: [
            MikiNavigationObserver(name: 'Branch-Estudos'),
          ],
          routes: [
            GoRoute(
              path: '/study',
              builder: (context, state) => const StudyPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          observers: [
            MikiNavigationObserver(name: 'Branch-Perfil'),
          ],
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/track/:trackId',
      pageBuilder: (context, state) {
        final trackId = state.pathParameters['trackId'] ?? 'alveolares';
        return MikiFadeScaleTransitionPage(
          key: state.pageKey,
          child: TrackSubPathPage(trackId: trackId),
        );
      },
    ),
    GoRoute(
      path: '/exercise/:trackId',
      builder: (context, state) {
        final trackId = state.pathParameters['trackId'] ?? 'sons_liquidos';
        return ChangeNotifierProvider(
          create: (_) => ExerciseViewModel(MockExerciseRepository())..loadExercises(trackId),
          child: ExercisePage(trackId: trackId),
        );
      },
    ),
    GoRoute(
      path: '/study/read/:bookId',
      builder: (context, state) {
        final bookId = state.pathParameters['bookId'] ?? 'jornada_pequeno_som';
        return ChangeNotifierProvider(
          create: (_) => BookReadingViewModel(MockStudyRepository())..loadBook(bookId),
          child: BookReadingPage(bookId: bookId),
        );
      },
    ),
  ],
);
