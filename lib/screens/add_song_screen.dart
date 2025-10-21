import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2020/firebase/songs_firebase.dart';

class AddSongScreen extends StatefulWidget {
  const AddSongScreen({super.key});

  @override
  State<AddSongScreen> createState() => _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  final _formKey = GlobalKey<FormState>();
  final SongsFirebase _songsFirebase = SongsFirebase();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _lyricsController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fields = [
      ElasticIn(
        duration: const Duration(milliseconds: 700),
        delay: const Duration(milliseconds: 100),
        child: TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: "Título",
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              (value == null || value.isEmpty) ? "Ingresa el título" : null,
        ),
      ),
      ElasticIn(
        duration: const Duration(milliseconds: 700),
        delay: const Duration(milliseconds: 250),
        child: TextFormField(
          controller: _artistController,
          decoration: const InputDecoration(
            labelText: "Artista",
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              (value == null || value.isEmpty) ? "Ingresa el artista" : null,
        ),
      ),
      ElasticIn(
        duration: const Duration(milliseconds: 700),
        delay: const Duration(milliseconds: 400),
        child: TextFormField(
          controller: _durationController,
          decoration: const InputDecoration(
            labelText: "Duración (ej. 2:50)",
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              (value == null || value.isEmpty) ? "Ingresa la duración" : null,
        ),
      ),
      ElasticIn(
        duration: const Duration(milliseconds: 700),
        delay: const Duration(milliseconds: 550),
        child: TextFormField(
          controller: _imageUrlController,
          decoration: const InputDecoration(
            labelText: "URL de la imagen",
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              (value == null || value.isEmpty) ? "Ingresa la URL" : null,
        ),
      ),
      ElasticIn(
        duration: const Duration(milliseconds: 700),
        delay: const Duration(milliseconds: 700),
        child: TextFormField(
          controller: _lyricsController,
          maxLines: 6,
          decoration: const InputDecoration(
            labelText: "Letra",
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
      ),
      ElasticIn(
        duration: const Duration(milliseconds: 700),
        delay: const Duration(milliseconds: 850),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.save),
          label: const Text("Guardar Canción"),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await _songsFirebase.addSong({
                'title': _titleController.text,
                'artist': _artistController.text,
                'duration': _durationController.text,
                'lyrics': _lyricsController.text,
                'imageUrl': _imageUrlController.text,
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Canción registrada correctamente'),
                ),
              );
            }
          },
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Canción"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView.separated(
            itemCount: fields.length,
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemBuilder: (context, index) => fields[index],
          ),
        ),
      ),
    );
  }
}
