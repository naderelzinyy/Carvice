import 'package:get/get.dart';

import 'package:carvice_frontend/view/client/pages/signup_page.dart';
import 'package:carvice_frontend/view/start/pages/starting_page.dart';
import 'package:carvice_frontend/view/client/pages/login_page.dart';
import 'package:carvice_frontend/view/start/pages/splash_page.dart';

import '../view/client/pages/chatlist_page.dart';
import '../view/client/pages/home_page.dart';
import '../view/client/pages/userprofile_page.dart';


class Routers {
  static String splashPage = "/";
  static String startingPage = "/starting_page";
  static String loginPage = "/login";
  static String signupPage = "/signup";
  static String homePage = "/home";
  static String userProfilePage = "/user_profile";
  static String chatListPage = "/chat_list";


  static String getMainRoute() => splashPage;
  static String getStartingPageRoute() => startingPage;
  static String getLoginPageRoute() => loginPage;
  static String getSignupPageRoute() => signupPage;
  static String getHomePageRoute() => homePage;
  static String getUserProfileRoute() => userProfilePage;
  static String getChatListRoute() => chatListPage;


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
    GetPage(
      name: homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: chatListPage,
      page: () => const ChatListPage(),
    ),
    GetPage(
      name: userProfilePage,
      page: () => const UserProfilePage(),
    ),
  ];
}