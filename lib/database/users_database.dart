import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UsersDatabase {
  static const _nameDB = "USERSDB";
  static const _versionDB = 1;
  static const _tableName = "tblUsers";

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, _nameDB);
    return openDatabase(
      pathDB,
      version: _versionDB,
      onCreate: _createTable,
    );
  }

  FutureOr<void> _createTable(Database db, int version) {
    const query = '''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY,
        fullName VARCHAR(255) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        password CHAR(64) NOT NULL,
        imagePath VARCHAR(512)
      )
    ''';
    db.execute(query);
  }

  /// Cifra la contraseña usando SHA-256. Lo hacemos estático para poder usarlo desde el login.
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Inserta un nuevo usuario en la base de datos, cifrando la contraseña.
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    final userToInsert = Map<String, dynamic>.from(user);
    // Usa el método estático para cifrar
    userToInsert['password'] = UsersDatabase.hashPassword(user['password']);
    return db.insert(_tableName, userToInsert);
  }

  /// Busca un usuario por su correo electrónico.
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  /// Actualiza un usuario.
  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    return db.update(
        _tableName,
        user,
        where: "id = ?",
        whereArgs: [user['id']]
    );
  }

  /// Elimina un usuario por su ID.
  Future<int> deleteUser(int id) async {
    final db = await database;
    return db.delete(
        _tableName,
        where: "id = ?",
        whereArgs: [id]
    );
  }
}

