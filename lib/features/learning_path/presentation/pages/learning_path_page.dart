import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/learning_path_cubit.dart';
import '../bloc/learning_path_state.dart';
import '../widgets/wavy_connector_painter.dart';
import '../widgets/track_node_widget.dart';
import '../../../../core/theme/miki_design_system.dart';


class LearningPathPage extends StatelessWidget {
  const LearningPathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MikiColors.background,
      extendBody: true,
      body: Stack(
        children: [
          // 1. Decorative Parallax/Static Concentric Background Circles
          _buildBackgroundCircles(),

          // 2. Main Content
          SafeArea(
            bottom: false,
            child: BlocBuilder<LearningPathCubit, LearningPathState>(
              builder: (context, state) {
                if (state is LearningPathLoading || state is LearningPathInitial) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MikiColors.primary,
                    ),
                  );
                }

                if (state is LearningPathError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Erro ao carregar trilhas',
                          style: MikiTextStyles.headlineSm(color: MikiColors.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: MikiTextStyles.bodyMd(color: MikiColors.text),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<LearningPathCubit>().loadTracks(),
                          child: const Text('Tentar Novamente'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is LearningPathLoaded) {
                  final tracks = state.tracks;

                  return RefreshIndicator(
                    onRefresh: () => context.read<LearningPathCubit>().loadTracks(),
                    color: MikiColors.primary,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 80), // Space for top header
                          
                          // Title & Subtitle Section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              children: [
                                Text(
                                  'Trilhas de Aprendizado',
                                  textAlign: TextAlign.center,
                                  style: MikiTextStyles.headlineLg(
                                    color: MikiColors.text,
                                  ).copyWith(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Encontre o caminho suave para a sua voz florescer hoje.',
                                  textAlign: TextAlign.center,
                                  style: MikiTextStyles.bodyLg(
                                    color: MikiColors.text.withValues(alpha: 0.6),
                                  ).copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 48),

                          // Node Path visualization with background connector
                          if (tracks.isNotEmpty)
                            Center(
                              child: Container(
                                constraints: const BoxConstraints(maxWidth: 360),
                                child: CustomPaint(
                                  painter: WavyConnectorPainter(
                                    color: MikiColors.primary.withValues(alpha: 0.12),
                                    strokeWidth: 1.5,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                                    child: Column(
                                      children: [
                                        TrackNodeWidget(
                                          track: tracks[0],
                                          horizontalOffset: -48,
                                          onTap: () => context.go('/track/${tracks[0].id}'),
                                        ),
                                        const SizedBox(height: 24),
                                        TrackNodeWidget(
                                          track: tracks[1],
                                          horizontalOffset: 48,
                                          onTap: () => context.go('/track/${tracks[1].id}'),
                                        ),
                                        const SizedBox(height: 24),
                                        TrackNodeWidget(
                                          track: tracks[2],
                                          horizontalOffset: -48,
                                          onTap: () => context.go('/track/${tracks[2].id}'),
                                        ),
                                        const SizedBox(height: 24),
                                        TrackNodeWidget(
                                          track: tracks[3],
                                          horizontalOffset: 32,
                                          onTap: () => context.go('/track/${tracks[3].id}'),
                                        ),
                                        const SizedBox(height: 24),
                                        TrackNodeWidget(
                                          track: tracks[4],
                                          horizontalOffset: -64,
                                          onTap: () => context.go('/track/${tracks[4].id}'),
                                        ),
                                        const SizedBox(height: 36),
                                        TrackNodeWidget(
                                          track: tracks[5],
                                          horizontalOffset: 0,
                                          onTap: () => context.go('/track/${tracks[5].id}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 120), // Extra space to scroll past the bottom bar
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          // 3. Floating Glassmorphism Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(),
          ),
        ],
      ),
    );
  }

  // Header Builder
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1.0,
          ),
        ),
      ),
      child: ClipRRect(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: MikiColors.primary),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Início',
                      style: MikiTextStyles.headlineMd(color: MikiColors.text).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.5),
                    border: Border.all(
                      color: MikiColors.primaryContainer,
                      width: 1.0,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_outline,
                      color: MikiColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Background Concentric Circle Builder
  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        // Left-Top large concentric circles
        Positioned(
          left: -200,
          top: 100,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x1F8E8D96), // rgba(142, 141, 150, 0.12)
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          left: -190,
          top: 110,
          child: Container(
            width: 580,
            height: 580,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x0F8E8D96), // opacity 50% of above
                width: 0.5,
              ),
            ),
          ),
        ),

        // Right-Middle smaller concentric circles
        Positioned(
          right: 20,
          top: 360,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x1F8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: 355,
          child: Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x0F8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
