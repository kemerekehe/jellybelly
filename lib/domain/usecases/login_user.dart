// lib/domain/usecases/login_user.dart
import '../entities/entity_user.dart';
import '../../domain/repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.getUser(email, password);
  }
}
