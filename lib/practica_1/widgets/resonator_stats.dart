import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmsn2020/practica_1/widgets/resonator_stats_painter.dart';

class ResonatorStats extends StatelessWidget {
  static const String hp = "assets/icons/wuwa/hp.svg";
  static const String atk = "assets/icons/wuwa/atk.svg";
  static const String def = "assets/icons/wuwa/def.svg";

  final double size;
  final double progress;
  final String icon;

  const ResonatorStats({
    super.key,
    required this.progress,
    required this.icon,
    this.size = 42,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ResonatorStatsPainter(progressPercent: progress),
      size: Size(size, size),
      child: Container(
        padding: EdgeInsets.all(size / 3.8),
        width: size,
        height: size,
        child: SvgPicture.asset(icon, width: size / 2, height: size / 2),
      ),
    );
  }
}
