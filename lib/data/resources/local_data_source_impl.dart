// lib/data/resources/local_data_source_impl.dart

import '../../domain/repositories/local_data_source.dart';
import '../models/model_user.dart';
import 'database_helper.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final DatabaseHelper databaseHelper;

  LocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> insertUser(UserModel user) async {
    final db = await databaseHelper.database;
    await db.insert('user', user.toMap());
  }

  @override
  Future<UserModel?> getUser(String email, String password) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final db = await databaseHelper.database;
    final maps = await db.query('user');
    return maps.map((map) => UserModel.fromMap(map)).toList();
  }

  @override
  Future<bool> isEmailRegistered(String email) async {
    final db = await databaseHelper.database;
    final result = await db.query('user', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty;
  }
}
