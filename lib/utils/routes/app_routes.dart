import 'package:chat_app/screens/chat_page/chat_page.dart';
import 'package:chat_app/screens/home_page.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/screens/splash.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String splash = '/';
  static String login = '/login';
  static String register = '/register';
  static String home = '/home';
  static String chat = '/chat';

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: register,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
    GetPage(
      name: chat,
      page: () => ChatPage(),
    ),
  ];
}
