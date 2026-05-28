import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/exercise_cubit.dart';
import '../bloc/exercise_state.dart';
import '../widgets/exercise_builder.dart';
import '../../../../core/theme/miki_design_system.dart';

class ExercisePage extends StatelessWidget {
  final String trackId;

  const ExercisePage({
    super.key,
    required this.trackId,
  });

  void _showCelebrationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(28.0),
            decoration: MikiDecorations.glassMorphism(
              borderRadius: 32,
              bgColor: Colors.white.withValues(alpha: 0.95),
              borderColor: MikiColors.primaryContainer,
            ).copyWith(
              boxShadow: [
                BoxShadow(
                  color: MikiColors.primary.withValues(alpha: 0.15),
                  blurRadius: 40,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE2F6E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.auto_awesome,
                      color: Color(0xFF34C759),
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Parabéns!',
                  style: MikiTextStyles.headlineLg(color: MikiColors.text).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Você concluiu com sucesso todos os exercícios de Pares Mínimos!',
                  textAlign: TextAlign.center,
                  style: MikiTextStyles.bodyMd(
                    color: MikiColors.text.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss Dialog
                      context.go('/track/$trackId'); // Go back to sub-path
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MikiColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Text(
                      'VOLTAR PARA A TRILHA',
                      style: MikiTextStyles.labelSm(color: Colors.white).copyWith(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MikiColors.background,
      body: Stack(
        children: [
          // 1. Concentric decorative circles
          _buildBackgroundCircles(),

          // 2. Main content container
          SafeArea(
            bottom: false,
            child: BlocConsumer<ExerciseCubit, ExerciseState>(
              listener: (context, state) {
                if (state is ExerciseLoaded && state.isCompleted) {
                  _showCelebrationDialog(context);
                }
              },
              builder: (context, state) {
                if (state is ExerciseLoading || state is ExerciseInitial) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MikiColors.primary,
                    ),
                  );
                }

                if (state is ExerciseError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Erro ao carregar exercícios',
                          style: MikiTextStyles.headlineSm(color: MikiColors.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: MikiTextStyles.bodyMd(color: MikiColors.text),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<ExerciseCubit>().loadExercises(trackId),
                          child: const Text('Tentar Novamente'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is ExerciseLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 80), // Spacer for top app bar

                      // Content container
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              // Build exercise layout dynamically
                              ExerciseBuilder.build(
                                exercise: state.currentExercise,
                                selectedOption: state.selectedOption,
                                isAnswerCorrect: state.isAnswerCorrect,
                                onOptionSelected: (opt) => context.read<ExerciseCubit>().selectOption(opt),
                              ),
                              const SizedBox(height: 48),

                              // Replay audio button
                              _buildAudioReplayButton(context, state.isReplayingAudio),
                            ],
                          ),
                        ),
                      ),

                      // Progress Indicator bottom bar
                      _buildProgressIndicatorBar(state.currentIndex, state.exercises.length),
                    ],
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
            child: _buildHeader(context),
          ),
        ],
      ),
    );
  }

  // Header
  Widget _buildHeader(BuildContext context) {
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
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: MikiColors.primary),
                  onPressed: () => context.go('/track/$trackId'),
                ),
                Text(
                  'Pares Mínimos',
                  style: MikiTextStyles.headlineMd(color: MikiColors.text).copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: MikiColors.primary),
                  onPressed: () => context.go('/'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Audio Replay button
  Widget _buildAudioReplayButton(BuildContext context, bool isReplaying) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () => context.read<ExerciseCubit>().replayAudio(),
        icon: isReplaying
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.volume_up, size: 20),
        label: Text(
          isReplaying ? 'REPRODUZINDO...' : 'OUVIR NOVAMENTE',
          style: MikiTextStyles.labelSm(color: Colors.white).copyWith(
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: MikiColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
    );
  }

  // Progress Bar and Text
  Widget _buildProgressIndicatorBar(int currentIndex, int totalExercises) {
    final progress = (currentIndex + 1) / totalExercises;

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32, top: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MikiColors.background,
            MikiColors.background.withValues(alpha: 0.8),
            MikiColors.background.withValues(alpha: 0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Thin bar
          Container(
            width: 200,
            height: 4,
            decoration: BoxDecoration(
              color: MikiColors.outlineVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: MikiColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Exercício ${currentIndex + 1} de $totalExercises',
            style: MikiTextStyles.labelSm(color: MikiColors.outline).copyWith(
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Background circles
  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          left: -100,
          top: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x1A8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          left: -120,
          top: -120,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x0A8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          right: -100,
          bottom: 100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x148E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
