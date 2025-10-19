import 'package:flutter/material.dart';

class SongWidget extends StatefulWidget {
  const SongWidget(this.song, {super.key});

  final Map<String, dynamic> song;

  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(widget.song['imageUrl']),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
