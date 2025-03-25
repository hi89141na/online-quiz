import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class DBHelper {
  static Database? _database;
  static final String tableName = 'users';

  // Initialize database
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'auth.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstName TEXT NOT NULL,
          lastName TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL,
          username TEXT UNIQUE NOT NULL,
          password TEXT NOT NULL
        )
      ''');
    });
  }

  // Hash Password using SHA256
  static String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  // Sign Up User
  static Future<int> signUpUser(String firstName, String lastName, String email, String username, String password) async {
    final db = await database;

    // Check if email or username already exists
    final existingUser = await db.query(tableName,
        where: 'email = ? OR username = ?', whereArgs: [email, username]);

    if (existingUser.isNotEmpty) {
      throw Exception("User already exists");
    }

    return await db.insert(tableName, {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'password': hashPassword(password),
    });
  }

  // Sign In User
  static Future<Map<String, dynamic>?> signInUser(String username, String password) async {
    final db = await database;
    final hashedPassword = hashPassword(password);

    final users = await db.query(tableName,
        where: 'username = ? AND password = ?',
        whereArgs: [username, hashedPassword]);

    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }
}


