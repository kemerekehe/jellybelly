import '../../data/models/model_user.dart';

abstract class LocalDataSource {
  Future<void> insertUser(UserModel user);
  Future<UserModel?> getUser(String email, String password);
  Future<List<UserModel>> getAllUsers();
  Future<bool> isEmailRegistered(String email);
}
