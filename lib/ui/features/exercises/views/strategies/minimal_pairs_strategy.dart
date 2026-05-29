import 'package:flutter/material.dart';
import '../../../../../domain/models/exercise.dart';
import 'exercise_strategy.dart';
import '../../../../core/theme/miki_design_system.dart';

class MinimalPairsStrategy implements ExerciseStrategy {
  const MinimalPairsStrategy();

  @override
  Widget buildWidget({
    required Exercise exercise,
    required String? selectedOption,
    required bool? isAnswerCorrect,
    required ValueChanged<String> onOptionSelected,
  }) {
    final hasImages = exercise.options.any((opt) => opt.imageUrl != null);
    final count = exercise.options.length;

    Widget optionsLayout;

    if (hasImages) {
      if (count == 4) {
        optionsLayout = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            final option = exercise.options[index];
            return _buildImageCard(
              option: option,
              selectedOption: selectedOption,
              isAnswerCorrect: isAnswerCorrect,
              correctOption: exercise.correctOption,
              onOptionSelected: onOptionSelected,
            );
          },
        );
      } else {
        optionsLayout = Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: exercise.options.map((option) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: _buildImageCard(
                  option: option,
                  selectedOption: selectedOption,
                  isAnswerCorrect: isAnswerCorrect,
                  correctOption: exercise.correctOption,
                  onOptionSelected: onOptionSelected,
                ),
              ),
            );
          }).toList(),
        );
      }
    } else {
      optionsLayout = Column(
        children: exercise.options.map((option) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildTextCard(
              option: option,
              selectedOption: selectedOption,
              isAnswerCorrect: isAnswerCorrect,
              correctOption: exercise.correctOption,
              onOptionSelected: onOptionSelected,
            ),
          );
        }).toList(),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          exercise.prompt,
          textAlign: TextAlign.center,
          style: MikiTextStyles.headlineMd(color: MikiColors.text).copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 32),

        hasImages && count <= 2
            ? SizedBox(
                height: 200,
                child: optionsLayout,
              )
            : optionsLayout,
      ],
    );
  }

  Widget _buildImageCard({
    required ExerciseOption option,
    required String? selectedOption,
    required bool? isAnswerCorrect,
    required String correctOption,
    required ValueChanged<String> onOptionSelected,
  }) {
    final isSelected = selectedOption == option.text;

    Color cardBgColor = Colors.white.withValues(alpha: 0.8);
    Color borderColor = Colors.white.withValues(alpha: 0.5);
    List<BoxShadow> shadow = [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.03),
        blurRadius: 12,
        offset: const Offset(0, 4),
      )
    ];

    bool shouldShake = false;

    if (isSelected) {
      if (isAnswerCorrect == true) {
        cardBgColor = const Color(0xFFE2F6E9); // soft green
        borderColor = const Color(0xFF34C759); // green border
        shadow = [
          BoxShadow(
            color: const Color(0xFF34C759).withValues(alpha: 0.25),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ];
      } else if (isAnswerCorrect == false) {
        cardBgColor = const Color(0xFFF6C9C9); // soft rose/red background
        borderColor = const Color(0xFFBA1A1A); // red border
        shadow = [
          BoxShadow(
            color: const Color(0xFFBA1A1A).withValues(alpha: 0.15),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ];
        shouldShake = true;
      }
    }

    return ShakeWidget(
      shake: shouldShake,
      child: GestureDetector(
        onTap: isAnswerCorrect == true ? null : () => onOptionSelected(option.text),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: cardBgColor,
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: shadow,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Image.network(
                    option.imageUrl ?? '',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported_outlined,
                        color: MikiColors.outline,
                        size: 32,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                option.text,
                style: MikiTextStyles.headlineSm(color: MikiColors.text).copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextCard({
    required ExerciseOption option,
    required String? selectedOption,
    required bool? isAnswerCorrect,
    required String correctOption,
    required ValueChanged<String> onOptionSelected,
  }) {
    final isSelected = selectedOption == option.text;
    
    Color cardBgColor = Colors.white.withValues(alpha: 0.8);
    Color borderColor = Colors.white.withValues(alpha: 0.5);
    bool shouldShake = false;

    if (isSelected) {
      if (isAnswerCorrect == true) {
        cardBgColor = const Color(0xFFE2F6E9);
        borderColor = const Color(0xFF34C759);
      } else if (isAnswerCorrect == false) {
        cardBgColor = const Color(0xFFF6C9C9);
        borderColor = const Color(0xFFBA1A1A);
        shouldShake = true;
      }
    }

    return ShakeWidget(
      shake: shouldShake,
      child: GestureDetector(
        onTap: isAnswerCorrect == true ? null : () => onOptionSelected(option.text),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
          decoration: BoxDecoration(
            color: cardBgColor,
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Center(
            child: Text(
              option.text,
              style: MikiTextStyles.headlineSm(color: MikiColors.text).copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final bool shake;

  const ShakeWidget({
    super.key,
    required this.child,
    required this.shake,
  });

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void didUpdateWidget(covariant ShakeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shake && !oldWidget.shake) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 15.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 15.0, end: -15.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -15.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 6.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: -6.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(offsetAnimation.value, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
