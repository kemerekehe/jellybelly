// domain/usecases/register_user.dart
import '/domain/entities/entity_user.dart';
import '../../domain/repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<User> call(String username, String email, String password) async {
    final isEmailRegistered = await repository.isEmailRegistered(email);
    if (isEmailRegistered) {
      throw EmailAlreadyExistsException('Email sudah terdaftar.');
    }

    final user = User(
      username: username,
      email: email,
      password: password,
    );
    await repository.registerUser(user);
    return user;
  }
}

class EmailAlreadyExistsException implements Exception {
  final String message;

  EmailAlreadyExistsException(this.message);

  @override
  String toString() {
    return message;
  }
}
