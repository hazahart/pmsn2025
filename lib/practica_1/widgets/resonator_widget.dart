import 'package:flutter/material.dart';
import 'package:pmsn2020/practica_1/models/resonator.dart';
import 'package:pmsn2020/practica_1/screens/resonator_details.dart';
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
    final screen = MediaQuery.of(context).size;
    final rowHeight = screen.height * 0.35;

    return Container(
      height: rowHeight,
      padding: EdgeInsets.symmetric(horizontal: screen.width * 0.03),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Fondo transformado
          Transform.translate(
            offset: Offset(-screen.width * 0.02, 0),
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.1)
                ..rotateY(rad(1.5)),
              child: Container(
                height: rowHeight * 0.62,
                margin: EdgeInsets.symmetric(horizontal: screen.width * 0.1),
                decoration: BoxDecoration(
                  color: const Color(0xfffceee3).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-screen.width * 0.05, 0),
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.01)
                ..rotateY(rad(8)),
              child: Container(
                height: rowHeight * 0.55,
                margin: EdgeInsets.symmetric(horizontal: screen.width * 0.1),
                decoration: BoxDecoration(
                  color: const Color(0xffddbf61).withValues(alpha: 0.4),
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
                  offset: Offset(-screen.width * 0.07, 0),
                  child: Hero(
                    tag: resonator.name,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(resonator.image, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screen.width * 0.03),
              // Stats y botón
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: rowHeight * 0.185,
                    horizontal: screen.width * 0.01,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ResonatorStats(progress: resonator.hp, type: StatType.hp),
                      ResonatorStats(
                        progress: resonator.atk,
                        type: StatType.atk,
                      ),
                      ResonatorStats(
                        progress: resonator.def,
                        type: StatType.def,
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(right: 30),
                        child: SizedBox(
                          height: rowHeight * 0.09,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResonatorDetailsPage(resonator: resonator),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              elevation: 5,
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFF29758), Color(0xFFEF5D67)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Ver detalles",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: rowHeight * 0.035,
                                  ),
                                ),
                              ),
                            ),
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
