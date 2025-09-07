import 'package:flutter/material.dart';
import 'package:pmsn2020/practica_1/models/resonator.dart';
import 'dart:math' as math;

import 'package:pmsn2020/practica_1/widgets/resonator_stats.dart';

const double degToRad = math.pi / 180;
const double radToDeg = 180 / math.pi;

double deg(double rad) => rad * radToDeg;
double rad(double deg) => deg * degToRad;

class ResonatorWidget extends StatelessWidget {
  final Resonator resonator;

  const ResonatorWidget({super.key, required this.resonator});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final rowHeight = MediaQuery.of(context).size.height * 0.35;

    return Container(
      height: rowHeight,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Fondo transformado
          Transform.translate(
            offset: Offset(-screenWidth * 0.02, 0),
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.1)
                ..rotateY(rad(1.5)),
              child: Container(
                height: rowHeight * 0.62,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                decoration: BoxDecoration(
                  color: Color(0xfffceee3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-screenWidth * 0.05, 0),
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.01)
                ..rotateY(rad(8)),
              child: Container(
                height: rowHeight * 0.55,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                decoration: BoxDecoration(
                  color: Color(0xffddbf61).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
          ),

          // Contenido principal
          Row(
            children: [
              // Imagen del resonador
              Flexible(
                flex: 2,
                child: Transform.translate(
                  offset: Offset(-screenWidth * 0.07, 0),
                  child: Hero(
                    tag: resonator.name,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        resonator.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: screenWidth * 0.03), // separación

              // Stats y botón
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: rowHeight * 0.185, horizontal: screenWidth * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ResonatorStats(
                        progress: resonator.hp,
                        icon: ResonatorStats.hp,
                      ),
                      ResonatorStats(
                        progress: resonator.atk,
                        icon: ResonatorStats.atk,
                      ),
                      ResonatorStats(
                        progress: resonator.def,
                        icon: ResonatorStats.def,
                      ),
                      SizedBox(
                        height: rowHeight * 0.09,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "Ver detalles",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: rowHeight * 0.04),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
