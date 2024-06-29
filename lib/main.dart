import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/usecases/get_jelly_beans.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/jelly_bean_list.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/register_screen.dart';
import '../presentation/viewmodels/authview_model.dart';
import '../presentation/viewmodels/jelly_bean_model.dart';
import '../domain/usecases/login_user.dart';
import '../domain/usecases/register_user.dart';
import '../services/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  await setupLocator();
  runApp(JellyBellyApp(isLoggedIn: isLoggedIn));
}

class JellyBellyApp extends StatelessWidget {
  final bool isLoggedIn;

  const JellyBellyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            registerUser: locator<RegisterUser>(),
            loginUser: locator<LoginUser>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => JellyBeanViewModel(getJellyBeans: locator<GetJellyBeans>()),
        ),
      ],
      child: MaterialApp(
        title: 'Auth Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isLoggedIn ? const JellyBeanListPage() : const HomePage(), // Tampilkan LoginScreen jika belum login
        routes: {
          '/register': (context) => const RegisterScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const JellyBeanListPage(),
        },
      ),
    );
  }
}
