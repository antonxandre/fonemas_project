import 'package:flutter/material.dart';

class WavyConnectorPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  WavyConnectorPainter({
    this.color = const Color(0x1F6B6E94), // rgba(107, 110, 148, 0.12)
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Start at center-top
    path.moveTo(w * 0.5, 0);

    // C 140,150 60,250 100,400
    path.cubicTo(
      w * (140 / 200), h * 0.15,
      w * (60 / 200), h * 0.25,
      w * 0.5, h * 0.40,
    );

    // S 140,650 100,800
    // (Translates to cubic bezier with reflected control point 1: X = 140, Y = 550)
    path.cubicTo(
      w * (140 / 200), h * 0.55,
      w * (140 / 200), h * 0.65,
      w * 0.5, h * 0.80,
    );

    // S 60,900 100,1000
    // (Translates to cubic bezier with reflected control point 1: X = 60, Y = 950)
    path.cubicTo(
      w * (60 / 200), h * 0.95,
      w * (60 / 200), h * 0.90,
      w * 0.5, h,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
