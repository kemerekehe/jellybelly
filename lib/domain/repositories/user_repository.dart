// lib/domain/repositories/user_repository.dart

import '../../domain/entities/entity_user.dart';

abstract class UserRepository {
  Future<User?> getUser(String username, String password);
  Future<void> registerUser(User user);
  Future<bool> isEmailRegistered(String email);
  Future<void> logout(); // Menambahkan fungsi logout sebagai async
}
