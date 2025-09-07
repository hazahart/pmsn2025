import 'package:flutter/material.dart';
import 'package:pmsn2020/practica_1/models/resonator.dart';
import 'package:pmsn2020/practica_1/widgets/resonator_widget.dart';

class ResonatorScreen extends StatefulWidget {
  const ResonatorScreen({super.key});

  @override
  ResonatorScreenState createState() => ResonatorScreenState();
}

class ResonatorScreenState extends State<ResonatorScreen> {
  final List<Resonator> resonators = [
    Resonator(
      name: "Cartethyia",
      image: "assets/images/wuwa/cartethyia.webp",
      hp: 51250,
      atk: 2560,
      def: 980,
    ),
    Resonator(
      name: "Phrolova",
      image: "assets/images/wuwa/phrolova.webp",
      hp: 17500,
      atk: 2250,
      def: 720,
    ),
    Resonator(
      name: "Carlotta",
      image: "assets/images/wuwa/carlotta.webp",
      hp: 18000,
      atk: 2149,
      def: 1090,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff929290), Color(0xff4f5551), Color(0xff141413)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      'Wuthering Waves Characters',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.menu, color: Colors.white, size: 32),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 100),
                itemCount: resonators.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ResonatorWidget(resonator: resonators[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
