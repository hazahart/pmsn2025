import 'package:flutter/material.dart';
import 'package:pmsn2020/firebase/songs_firebase.dart';
import 'package:pmsn2020/screens/add_song_screen.dart';

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
                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Letra de: ${song['title']}'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [Text(song['lyrics'])],
                          ),
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
                  title: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Imagen a la izquierda
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage(
                              placeholder: const AssetImage(
                                "assets/animations/loading-cat.gif",
                              ),
                              image: song['imageUrl'] != null && song['imageUrl'].toString().isNotEmpty
                                  ? NetworkImage(song['imageUrl'])
                                  : const AssetImage("assets/animations/loading-cat.gif") as ImageProvider,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.music_note, size: 50),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Información a la derecha, ocupando el espacio restante
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  song['artist'],
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  song['duration'],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                      ,
                    ),
                  ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSongScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
