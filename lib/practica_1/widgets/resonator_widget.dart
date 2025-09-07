import 'package:flutter/material.dart';
import 'package:pmsn2020/practica_1/models/resonator.dart';
import 'dart:math' as math;

const double degToRad = math.pi / 180;
const double radToDeg = 180 / math.pi;

double deg(double rad) => rad * radToDeg;
double rad(double deg) => deg * degToRad;

class ResonatorWidget extends StatelessWidget {
  final Resonator resonator;

  const ResonatorWidget({super.key, required this.resonator});

  @override
  Widget build(BuildContext context) {
    double rowHeight = MediaQuery.of(context).size.height * 0.35;
    return Container(
      height: rowHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(-10, 0),
            child: Transform(transform: Matrix4.identity()),
          ),
        ],
      ),
    );
  }
}
