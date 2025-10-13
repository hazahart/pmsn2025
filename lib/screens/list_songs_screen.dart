import 'package:flutter/material.dart';
import 'package:pmsn2020/firebase/songs_firebase.dart';

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
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final song = snapshot.data!.docs[index];
                return ListTile(
                  title: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song['title'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            song['artist'],
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            song['duration'],
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            if (snapshot.hasError) {
              // return Text(snapshot.error.toString());
              return const Text('Error');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
