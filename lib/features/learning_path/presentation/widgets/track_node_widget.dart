import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../domain/entities/learning_track.dart';
import '../../../../core/theme/miki_design_system.dart';

class TrackNodeWidget extends StatefulWidget {
  final LearningTrack track;
  final double horizontalOffset;
  final VoidCallback? onTap;

  const TrackNodeWidget({
    super.key,
    required this.track,
    required this.horizontalOffset,
    this.onTap,
  });

  @override
  State<TrackNodeWidget> createState() => _TrackNodeWidgetState();
}

class _TrackNodeWidgetState extends State<TrackNodeWidget>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    // Spin animation controller for Prática Diária outer dashed ring
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animController.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _animController.reverse();
  }

  Widget _buildIcon(String id, Color color) {
    switch (id) {
      case 'vogais':
        return Text(
          widget.track.abbreviation ?? 'Ae',
          style: MikiTextStyles.headlineSm(
            color: color,
          ).copyWith(fontSize: 20, fontWeight: FontWeight.w400),
        );
      case 'bilabiais':
        return CustomPaint(
          size: const Size(32, 32),
          painter: LipsPainter(color),
        );
      case 'alveolares':
        return CustomPaint(
          size: const Size(32, 32),
          painter: TonguePainter(color),
        );
      case 'velares':
        return CustomPaint(
          size: const Size(32, 32),
          painter: VelarPainter(color),
        );
      case 'fricativas':
        return CustomPaint(
          size: const Size(32, 32),
          painter: WavesPainter(color),
        );
      case 'pratica_diaria':
        return const Icon(
          Icons.local_florist_outlined,
          color: Colors.white,
          size: 30,
        );
      default:
        return Text(
          widget.track.abbreviation ?? '',
          style: MikiTextStyles.headlineSm(color: color),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFinal = widget.track.id == 'pratica_diaria';
    final isAlveolares =
        widget.track.id == 'alveolares'; // active focused node in HTML

    final nodeSize = isFinal ? 80.0 : 64.0;

    return Center(
      child: Container(
        width: 320,
        height: 100,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Outer glowing and rotating effects for active/special nodes
            if (isAlveolares) ...[
              // Concentric soft border circles
              Positioned(
                left: 160 + widget.horizontalOffset - 62,
                top: 50 - 62,
                child: IgnorePointer(
                  child: Container(
                    width: 124,
                    height: 124,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: MikiColors.tertiary.withValues(alpha: 0.05),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 160 + widget.horizontalOffset - 52,
                top: 50 - 52,
                child: IgnorePointer(
                  child: Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: MikiColors.tertiary.withValues(alpha: 0.1),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            if (isFinal) ...[
              // Dash rotating circle
              Positioned(
                left: 160 + widget.horizontalOffset - 60,
                top: 50 - 60,
                child: AnimatedBuilder(
                  animation: _spinController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _spinController.value * 2 * math.pi,
                      child: child,
                    );
                  },
                  child: CustomPaint(
                    size: const Size(120, 120),
                    painter: DashedCirclePainter(
                      color: MikiColors.primary.withValues(alpha: 0.2),
                      strokeWidth: 0.5,
                      dashLength: 4.0,
                      spaceLength: 4.0,
                    ),
                  ),
                ),
              ),
            ],

            // The main interactive node bubble
            Positioned(
              left: 160 + widget.horizontalOffset - (nodeSize / 2),
              top: 50 - (nodeSize / 2),
              child: GestureDetector(
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                onTapCancel: _onTapCancel,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: nodeSize,
                    height: nodeSize,
                    decoration: isFinal
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                MikiColors.primary,
                                MikiColors.primaryFixedDim,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            border: Border.all(
                              color: widget.track.borderColor,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: MikiColors.primary.withValues(
                                  alpha: 0.35,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          )
                        : MikiDecorations.glassMorphism(
                            borderRadius: nodeSize / 2,
                            bgColor: widget.track.bgColor,
                            borderColor: widget.track.borderColor,
                          ).copyWith(
                            boxShadow: [
                              BoxShadow(
                                color: widget.track.textColor.withValues(
                                  alpha: 0.08,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                    child: Center(
                      child: _buildIcon(
                        widget.track.id,
                        widget.track.textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Text Label positioned next to the node bubble
            Positioned(
              // If offset is positive (right-ish), text is on the left
              // If offset is negative or zero, text is on the right
              left: widget.horizontalOffset >= 0
                  ? null
                  : 160 + widget.horizontalOffset + (nodeSize / 2) + 16,
              right: widget.horizontalOffset >= 0
                  ? (160 - widget.horizontalOffset) + (nodeSize / 2) + 16
                  : null,
              top: 50 - 22,
              child: Column(
                crossAxisAlignment: widget.horizontalOffset >= 0
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.track.title,
                    style:
                        MikiTextStyles.headlineSm(
                          color: widget.track.textColor,
                        ).copyWith(
                          fontSize: 18,
                          fontWeight: isFinal
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.track.subtitle,
                    style:
                        MikiTextStyles.labelSm(
                          color: isFinal
                              ? MikiColors.primary.withValues(alpha: 0.8)
                              : MikiColors.text.withValues(alpha: 0.7),
                        ).copyWith(
                          fontSize: 9.5,
                          fontWeight: isFinal
                              ? FontWeight.w900
                              : FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Lips Painter
class LipsPainter extends CustomPainter {
  final Color color;
  LipsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Top lip outline
    path.moveTo(w * 0.15, h * 0.5);
    path.cubicTo(w * 0.35, h * 0.28, w * 0.45, h * 0.35, w * 0.5, h * 0.4);
    path.cubicTo(w * 0.55, h * 0.35, w * 0.65, h * 0.28, w * 0.85, h * 0.5);

    // Bottom lip outline
    path.cubicTo(w * 0.68, h * 0.72, w * 0.32, h * 0.72, w * 0.15, h * 0.5);

    // Middle division line
    path.moveTo(w * 0.15, h * 0.5);
    path.quadraticBezierTo(w * 0.5, h * 0.54, w * 0.85, h * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Tongue/Palate Articulation Painter
class TonguePainter extends CustomPainter {
  final Color color;
  TonguePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Upper Palate / Alveolar Ridge outline
    path.moveTo(w * 0.2, h * 0.25);
    path.quadraticBezierTo(w * 0.7, h * 0.25, w * 0.78, h * 0.55);

    // Tongue outline touching the front alveolar ridge
    path.moveTo(w * 0.25, h * 0.75);
    path.cubicTo(w * 0.4, h * 0.65, w * 0.48, h * 0.35, w * 0.54, h * 0.28);
    // Underneath of tongue curves back
    path.quadraticBezierTo(w * 0.5, h * 0.48, w * 0.32, h * 0.75);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Throat/Velar Painter
class VelarPainter extends CustomPainter {
  final Color color;
  VelarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Palate curving down into the back throat (velum)
    path.moveTo(w * 0.2, h * 0.25);
    path.quadraticBezierTo(w * 0.55, h * 0.25, w * 0.68, h * 0.45);
    path.quadraticBezierTo(w * 0.72, h * 0.58, w * 0.78, h * 0.75);

    // Back of tongue raised towards the velum
    path.moveTo(w * 0.25, h * 0.75);
    path.cubicTo(w * 0.4, h * 0.75, w * 0.58, h * 0.58, w * 0.65, h * 0.46);
    path.quadraticBezierTo(w * 0.52, h * 0.72, w * 0.32, h * 0.8);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Air Waves / Fricativa waves painter
class WavesPainter extends CustomPainter {
  final Color color;
  WavesPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Top wave
    path.moveTo(w * 0.2, h * 0.38);
    path.cubicTo(w * 0.35, h * 0.25, w * 0.5, h * 0.48, w * 0.65, h * 0.38);
    path.quadraticBezierTo(w * 0.72, h * 0.32, w * 0.8, h * 0.38);

    // Middle wave
    path.moveTo(w * 0.2, h * 0.5);
    path.cubicTo(w * 0.35, h * 0.38, w * 0.5, h * 0.6, w * 0.65, h * 0.5);
    path.quadraticBezierTo(w * 0.72, h * 0.44, w * 0.8, h * 0.5);

    // Bottom wave
    path.moveTo(w * 0.2, h * 0.62);
    path.cubicTo(w * 0.35, h * 0.5, w * 0.5, h * 0.72, w * 0.65, h * 0.62);
    path.quadraticBezierTo(w * 0.72, h * 0.56, w * 0.8, h * 0.62);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Dashed Circle Painter
class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double spaceLength;

  DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.spaceLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    double circumference = 2 * math.pi * radius;
    int dashCount = (circumference / (dashLength + spaceLength)).floor();
    double actualSpaceLength =
        (circumference - (dashCount * dashLength)) / dashCount;

    double currentAngle = 0.0;
    for (int i = 0; i < dashCount; i++) {
      double sweepAngle = (dashLength / circumference) * 2 * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweepAngle,
        false,
        paint,
      );
      currentAngle +=
          sweepAngle + ((actualSpaceLength / circumference) * 2 * math.pi);
    }
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      dashLength != oldDelegate.dashLength ||
      spaceLength != oldDelegate.spaceLength;
}
