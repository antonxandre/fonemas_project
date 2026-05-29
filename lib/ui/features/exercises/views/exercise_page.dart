import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../ui/core/theme/miki_design_system.dart';
import '../view_models/exercise_view_model.dart';
import 'widgets/exercise_builder.dart';

class ExercisePage extends StatelessWidget {
  final String trackId;

  const ExercisePage({
    super.key,
    required this.trackId,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ExerciseViewModel>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MikiColors.background,
      body: Stack(
        children: [
          // Background concentric circles for depth and aesthetics
          _buildBackgroundCircles(),

          SafeArea(
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                if (viewModel.isLoading && viewModel.exercises.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MikiColors.primary,
                    ),
                  );
                }

                if (viewModel.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.errorLoadingExercises,
                          style: MikiTextStyles.headlineSm(color: MikiColors.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          viewModel.errorMessage!,
                          style: MikiTextStyles.bodyMd(color: MikiColors.text),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => viewModel.loadExercises(trackId),
                          child: Text(l10n.tryAgain),
                        ),
                      ],
                    ),
                  );
                }

                if (viewModel.exercises.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.errorLoadingExercises,
                      style: MikiTextStyles.bodyLg(),
                    ),
                  );
                }

                // If completed, show a beautiful success page / overlay
                if (viewModel.isCompleted) {
                  return _buildSuccessScreen(context, l10n);
                }

                final current = viewModel.currentIndex + 1;
                final total = viewModel.exercises.length;
                final progress = viewModel.exercises.isEmpty ? 0.0 : viewModel.currentIndex / total;

                final currentExercise = viewModel.currentExercise;

                return Column(
                  children: [
                    // Premium Custom Header with Progress Bar
                    _buildHeader(context, current, total, progress, l10n),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 24),
                            // Audio Button/Waveform Card if audio exists
                            if (currentExercise.audioUrl != null) ...[
                              _buildAudioCard(context, viewModel, l10n),
                              const SizedBox(height: 36),
                            ],

                            // Exercise Strategy Builder
                            ExerciseBuilder(
                              exercise: currentExercise,
                              selectedOption: viewModel.selectedOption,
                              isAnswerCorrect: viewModel.isAnswerCorrect,
                              onOptionSelected: (option) => viewModel.selectOption(option),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Header with back button and top progress bar
  Widget _buildHeader(
    BuildContext context,
    int current,
    int total,
    double progress,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: MikiColors.primary, size: 20),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/track/$trackId');
                  }
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    l10n.minimalPairs,
                    style: MikiTextStyles.headlineSm(color: MikiColors.text).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48), // Keep title centered
            ],
          ),
          const SizedBox(height: 12),
          // Custom stylized linear progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MikiColors.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 8,
                      width: MediaQuery.of(context).size.width * 0.8 * progress,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [MikiColors.primary, MikiColors.lavender],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.exerciseProgress(current, total),
                  style: MikiTextStyles.labelSm(color: MikiColors.outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Replay Audio Widget (Interactive card)
  Widget _buildAudioCard(
    BuildContext context,
    ExerciseViewModel viewModel,
    AppLocalizations l10n,
  ) {
    return Center(
      child: GestureDetector(
        onTap: () => viewModel.replayAudio(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: viewModel.isReplayingAudio
                ? MikiColors.primaryContainer
                : Colors.white.withValues(alpha: 0.7),
            shape: BoxShape.circle,
            border: Border.all(
              color: viewModel.isReplayingAudio
                  ? MikiColors.primary
                  : MikiColors.primaryFixedDim.withValues(alpha: 0.5),
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: MikiColors.primary.withValues(alpha: viewModel.isReplayingAudio ? 0.2 : 0.05),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rotating / scaling effect for audio
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: viewModel.isReplayingAudio ? 1.2 : 1.0,
                child: Icon(
                  viewModel.isReplayingAudio ? Icons.volume_up : Icons.volume_up_outlined,
                  color: MikiColors.primary,
                  size: 48,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                viewModel.isReplayingAudio ? l10n.replaying : l10n.listenAgain,
                style: MikiTextStyles.labelSm(color: MikiColors.primary).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Congratulations/Success View
  Widget _buildSuccessScreen(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          decoration: MikiDecorations.glassMorphism(borderRadius: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Beautiful trophy/crown icon
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: MikiColors.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_outlined,
                  color: MikiColors.secondary,
                  size: 44,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.congratulations,
                style: MikiTextStyles.headlineLg(color: MikiColors.text),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.completedAllExercises,
                textAlign: TextAlign.center,
                style: MikiTextStyles.bodyMd(color: MikiColors.text.withValues(alpha: 0.7)),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to the track
                    if (context.canPop()) {
                      context.pop(true);
                    } else {
                      context.go('/track/$trackId');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MikiColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.backToTrack,
                    style: MikiTextStyles.labelMd(color: Colors.white).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Background Concentric Circles for visual flair
  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          right: -100,
          top: -50,
          child: Container(
            width: 300,
            height: 300,
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
          left: -150,
          bottom: 50,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x1F8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
