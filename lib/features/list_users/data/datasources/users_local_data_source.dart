// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';

abstract class IUsersLocalDataSource {
  Future<List<UserModel>> getUsersList();
  Future<void> saveUsers(List<UserModel> users);
}

class UsersLocalDataSource implements IUsersLocalDataSource {

  Database? database;

  Future<void> openDB() async {
    final dbPath = join(await getDatabasesPath(), 'users.db');
    database = await openDatabase(dbPath, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        phone TEXT
      )
      '''
    );
  }

  Future<void> closeDB() async {
    await database!.close(); 
  }

  @override
  Future<List<UserModel>> getUsersList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await database!.query('users');
    final List<UserModel> users = List.generate(maps.length, (i) {
      return UserModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
      );
    });
    await closeDB();
    return users;
  }
  
  @override
  Future<void> saveUsers(List<UserModel> users) async {
    await openDB();
    for (UserModel user in users) {
      await database!.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await closeDB();
  }

}