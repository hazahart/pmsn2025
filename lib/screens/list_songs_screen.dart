import 'package:flutter/material.dart';
import 'package:pmsn2020/firebase/songs_firebase.dart';
import 'package:pmsn2020/widgets/song_widget.dart';

class ListSongsScreen extends StatefulWidget {
  const ListSongsScreen({super.key});

  @override
  State<ListSongsScreen> createState() => _ListSongsScreenState();
}

class _ListSongsScreenState extends State<ListSongsScreen> {
  SongsFirebase songsFirebase = SongsFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Canciones'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: songsFirebase.selectAllSongs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return const Center(child: Text('No hay canciones registradas'));
            }
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final song = docs[index];
                return SongWidget(
                  song: song.data() as Map<String, dynamic>,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Letra de: ${song['title']}'),
                        content: SingleChildScrollView(
                          child: Text(song['lyrics']),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las canciones'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addsong");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
