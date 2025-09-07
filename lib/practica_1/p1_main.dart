import 'package:flutter/material.dart';

class P1Main extends StatefulWidget {
  const P1Main({super.key});

  @override
  State<P1Main> createState() => _P1MainState();
}

class _P1MainState extends State<P1Main> {
  late ScrollController _scrollController;
  double toolbarOpacity = 1.0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final scrollOffset = _scrollController.offset;
      if (scrollOffset <= 80) {
        setState(() {
          toolbarOpacity = (80 - scrollOffset) / 80;
        });
      } else {
        setState(() {
          toolbarOpacity = 1.0;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Item $index"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
