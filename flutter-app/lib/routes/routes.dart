import 'package:get/get.dart';

import 'package:carvice_frontend/view/client/pages/signup_page.dart';
import 'package:carvice_frontend/view/start/pages/starting_page.dart';
import 'package:carvice_frontend/view/client/pages/login_page.dart';
import 'package:carvice_frontend/view/start/pages/splash_page.dart';

class Routers {
  static String splashPage = "/";
  static String startingPage = "/starting_page";
  static String loginPage = "/login";
  static String signupPage = "/signup";

  static String getMainRoute() => splashPage;
  static String getStartingPageRoute() => startingPage;
  static String getLoginPageRoute() => loginPage;
  static String getSignupPageRoute() => signupPage;


  static List<GetPage> routes = [
    GetPage(name: splashPage,
      page: () => const SplashPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: startingPage,
      page: () => const StartingPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: loginPage,
      page: () => LoginPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: signupPage,
      page: () => SignUp(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
  ];
}