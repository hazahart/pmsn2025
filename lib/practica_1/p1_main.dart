import 'package:flutter/material.dart';
import 'package:pmsn2020/practica_1/models/resonator.dart';
import 'package:pmsn2020/practica_1/widgets/resonator_widget.dart';

class ResonatorScreen extends StatefulWidget {
  const ResonatorScreen({super.key});

  @override
  ResonatorScreenState createState() => ResonatorScreenState();
}

class ResonatorScreenState extends State<ResonatorScreen> {
  final ScrollController _scrollController = ScrollController();
  double toolbarOpacity = 1.0;

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
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        toolbarOpacity = (_scrollController.offset <= 80)
            ? (80 - _scrollController.offset) / 80
            : 0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Abre un dialogo para crear un nuevo resonador
  void _showAddResonatorDialog() {
    final nameController = TextEditingController();
    final imageController = TextEditingController();
    final hpController = TextEditingController();
    final atkController = TextEditingController();
    final defController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Nuevo Resonador"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(
                  labelText: "Ruta de imagen (ej. assets/images/wuwa/cartethyia.webp)",
                ),
              ),
              TextField(
                controller: hpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "HP"),
              ),
              TextField(
                controller: atkController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "ATK"),
              ),
              TextField(
                controller: defController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "DEF"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  imageController.text.isNotEmpty) {
                setState(() {
                  resonators.add(
                    Resonator(
                      name: nameController.text,
                      image: imageController.text,
                      hp: double.tryParse(hpController.text) ?? 0,
                      atk: double.tryParse(atkController.text) ?? 0,
                      def: double.tryParse(defController.text) ?? 0,
                    ),
                  );
                });
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Resonador agregado ✅")),
                );
              }
            },
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }

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
        child: Stack(
          children: [
            Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.only(top: 80, bottom: 100),
                itemCount: resonators.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ResonatorWidget(resonator: resonators[index]),
                ),
              ),
            ),
            Opacity(
              opacity: toolbarOpacity,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffddbf61),
        onPressed: _showAddResonatorDialog,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
