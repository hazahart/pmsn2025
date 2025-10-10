import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SongsFirebase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference? songsCollection;

  SongsFirebase() {
    songsCollection = firestore.collection('songs');
  }

  Future addSong(Map<String, dynamic> song) async {
    songsCollection!.doc().set(song);
  }

  Future updateSong(Map<String, dynamic> song, String uid) async {
    songsCollection!.doc(uid).update(song);
  }

  Future deleteSong(String uid) async {
    songsCollection!.doc(uid).delete();
  }

  Stream<QuerySnapshot> selectAllSongs() {
    return songsCollection!.snapshots();
  }
}
