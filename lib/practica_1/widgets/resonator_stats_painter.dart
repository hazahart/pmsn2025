import 'package:flutter/material.dart';
import 'dart:math' as math;

class ResonatorStatsPainter extends CustomPainter {
  final double progressPercent;
  final double strokeWidth;
  final double filledStrokeWidth;

  final Paint bgPaint;
  final Paint strokeBgPaint;
  final Paint strokeFilledPaint;

  ResonatorStatsPainter({
    required this.progressPercent,
    this.strokeWidth = 2.0,
    this.filledStrokeWidth = 4.0,
  })  : bgPaint = Paint()..color = Colors.white.withValues(alpha: 0.25),
        strokeBgPaint = Paint()..color = const Color(0xffd32f2f),
        strokeFilledPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = filledStrokeWidth
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawCircle(center, radius - strokeWidth, strokeBgPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2)),
      -math.pi / 2,
      (progressPercent / 100) * math.pi * 2,
      false,
      strokeFilledPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
