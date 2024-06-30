import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/local_data_source.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/entities/entity_user.dart';
import '../../data/models/model_user.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDataSource localDataSource;
  final SharedPreferences sharedPreferences;

  UserRepositoryImpl({required this.localDataSource, required this.sharedPreferences,});

  @override
  Future<void> registerUser(User user) async {
    final userModel = UserModel(
      username: user.username,
      email: user.email,
      password: user.password,
    );
    await localDataSource.insertUser(userModel);
  }

  @override
  Future<User?> getUser(String email, String password) async {
    final userModel = await localDataSource.getUser(email, password);
    if (userModel != null) {
      return User(
        username: userModel.username,
        email: userModel.email,
        password: userModel.password,
      );
    }
    return null;
  }

  @override
  Future<bool> isEmailRegistered(String email) async {
    return await localDataSource.isEmailRegistered(email);
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    await sharedPreferences.setBool('isLoggedIn', isLoggedIn);
  }

  // Contoh implementasi untuk mendapatkan status login
  bool isLoggedIn() {
    return sharedPreferences.getBool('isLoggedIn') ?? false;
  }

  Future<void> logout() async {
    await sharedPreferences.setBool('isLoggedIn', false);
  }
}