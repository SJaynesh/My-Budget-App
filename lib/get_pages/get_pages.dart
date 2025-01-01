import 'package:budget_tracker_app/views/screens/home_page.dart';
import 'package:get/get.dart';

import '../views/screens/splash_screen.dart';

class GetPages {
  static String splash = '/';
  static String home = '/home';

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.downToUp,
    ),
  ];
}
