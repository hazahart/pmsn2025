import 'package:flutter/material.dart';
import 'package:pmsn2020/practica_1/models/resonator.dart';

class ResonatorDetailsPage extends StatefulWidget {
  final Resonator resonator;

  const ResonatorDetailsPage({super.key, required this.resonator});

  @override
  ResonatorDetailsPageState createState() => ResonatorDetailsPageState();
}

class ResonatorDetailsPageState extends State<ResonatorDetailsPage> {
  final double appBarHeight = 80.0;
  late ScrollController _scrollController;
  double toolbarOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        toolbarOpacity = (_scrollController.offset <= appBarHeight)
            ? (appBarHeight - _scrollController.offset) / appBarHeight
            : 0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resonator = widget.resonator;
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff929290), Color(0xff4f5551), Color(0xff141413)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            ListView(
              controller: _scrollController,
              padding: EdgeInsets.only(top: appBarHeight, bottom: 40),
              children: [
                _ResonatorDetailsImage(resonator: resonator, size: screen.width * 0.7),
                _ResonatorDetailsName(resonator.name),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
                  child: Text(
                    "HP: ${resonator.hp.toInt()}  |  ATK: ${resonator.atk.toInt()}  |  DEF: ${resonator.def.toInt()}",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            "Volver",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.orangeAccent,
                          ),
                          child: Text(
                            "Acción",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28),
              ],
            ),
            SafeArea(
              child: Opacity(
                opacity: toolbarOpacity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Detalles',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(Icons.menu, color: Colors.white, size: 28),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResonatorDetailsImage extends StatelessWidget {
  final Resonator resonator;
  final double size;

  const _ResonatorDetailsImage({required this.resonator, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, left: 28.0, right: 28.0),
      child: Hero(
        tag: resonator.name,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white.withValues(alpha: 0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(resonator.image, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

class _ResonatorDetailsName extends StatelessWidget {
  final String name;

  const _ResonatorDetailsName(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 16),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
