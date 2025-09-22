import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pmsn2020/models/movie_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabase {
  static final nameDB = "MOVIESDB";
  static final versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    return _database = await initDatabase();
  }

  Future<Database?> initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    // String path = "${folder.path}/$nameDB.db";
    String path = join(folder.path, "$nameDB.db");
    return await openDatabase(path, version: versionDB, onCreate: _createTable);
  }

  FutureOr<void> _createTable(Database db, int version) {
    String query = '''
      CREATE TABLE movies(
        id_movie INTEGER PRIMARY KEY,
        title VARCHAR(100),
        time CHAR(3),
        date_release CHAR(10)
      )
    ''';
    db.execute(query);
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    var conn = await database;
    return conn!.insert(table, values);
  }

  Future<int> update (String table, Map<String, dynamic> values) async {
    var conn = await database;
    return conn!.update(table, values, where: "id_movie = ?", whereArgs: [values['id_movie']]);
  }

  Future<int> delete (String table, int id) async {
    var conn = await database;
    return conn!.delete(table, where: "id_movie = ?", whereArgs: [id]);
  }

  Future<List<MovieDAO>?> select() async {
    var conn = await database;
    final res = await conn!.query("movies");
    return res.map((movie) => MovieDAO.fromMap(movie)).toList();
  }
}
