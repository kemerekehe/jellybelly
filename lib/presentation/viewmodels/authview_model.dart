import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/LogoutUser.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';

class AuthViewModel extends ChangeNotifier {
  final RegisterUser registerUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final bool isLoggedIn; // Tambahkan variabel isLoggedIn

  AuthViewModel({
    required this.registerUser,
    required this.loginUser,
    required this.logoutUser,
    required this.isLoggedIn, // Inisialisasi isLoggedIn
  });

  Future<void> login(String email, String password) async {
    try {
      final user = await loginUser.call(email, password);
      if (user != null) {
        await setLoggedIn(true);
        notifyListeners();
      }
    } catch (e) {
      // Handle login error
    }
  }

  Future<void> logout() async {
    await setLoggedIn(false);
    await logoutUser.call(); // Panggil use case logoutUser
    notifyListeners();
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
