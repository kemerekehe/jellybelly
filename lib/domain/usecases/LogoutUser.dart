// lib/domain/usecases/logout_user.dart
import '../../domain/repositories/user_repository.dart';

class LogoutUser {
  final UserRepository userRepository;

  LogoutUser(this.userRepository);

  Future<void> call() async {
    await userRepository.logout();
  }
}
