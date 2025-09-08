import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/resonator_stats_painter.dart';

enum StatType { hp, atk, def }

class ResonatorStats extends StatelessWidget {
  final double size;
  final double progress;
  final StatType type;

  const ResonatorStats({
    super.key,
    required this.progress,
    required this.type,
    this.size = 42,
  });

  static const Map<StatType, String> icons = {
    StatType.hp: "assets/icons/wuwa/hp.svg",
    StatType.atk: "assets/icons/wuwa/atk.svg",
    StatType.def: "assets/icons/wuwa/def.svg",
  };

  static const Map<StatType, double> maxValues = {
    StatType.hp: 100000,
    StatType.atk: 5000,
    StatType.def: 5000,
  };

  @override
  Widget build(BuildContext context) {
    final iconPath = icons[type]!;
    final maxValue = maxValues[type]!;

    return CustomPaint(
      painter: ResonatorStatsPainter(
        currentValue: progress,
        maxValue: maxValue,
      ),
      size: Size(size, size),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(size / 3.8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(iconPath, width: size / 2, height: size / 2),
              Positioned(
                bottom: -size * 0.25,
                child: Text(
                  "${progress.toInt()}/${maxValue.toInt()}",
                  style: TextStyle(
                    fontSize: size * 0.22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
