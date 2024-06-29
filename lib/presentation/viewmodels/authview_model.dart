import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';

class AuthViewModel extends ChangeNotifier {
  final RegisterUser registerUser;
  final LoginUser loginUser;

  AuthViewModel({
    required this.registerUser,
    required this.loginUser,
  });

  Future<void> login(String email, String password) async {
    try {
      final user = await loginUser.call(email, password);
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        notifyListeners();
      }
    } catch (e) {
      // Handle login error
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }
}
