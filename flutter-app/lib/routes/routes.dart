import 'package:carvice_frontend/view/general/pages/update_userprofile_page.dart';
import 'package:carvice_frontend/view/mechanic/pages/userprofile_page.dart';
import 'package:get/get.dart';

import 'package:carvice_frontend/view/general/pages/signup_page.dart';
import 'package:carvice_frontend/view/general/pages/starting_page.dart';
import 'package:carvice_frontend/view/general/pages/login_page.dart';
import 'package:carvice_frontend/view/general/pages/splash_page.dart';

import '../view/client/pages/chatlist_page.dart';
import '../view/client/pages/home_page.dart';
import '../view/client/pages/userprofile_page.dart';
import '../view/mechanic/pages/home_page.dart';



class Routers {
  static String splashPage = "/";
  static String startingPage = "/starting_page";
  static String loginPage = "/login";
  static String signupPage = "/signup";
  static String homePage = "/home";
  static String mechanicHomePage = "/mechanic_home";
  static String userProfilePage = "/user_profile";
  static String chatListPage = "/chat_list";
  static String updateUserProfilePage = "/update_profile";
  static String mechanicUserProfilePage = "/mechanic_user_profile";



  static String getMainRoute() => splashPage;
  static String getStartingPageRoute() => startingPage;
  static String getLoginPageRoute(String roleEndpoint) => '$loginPage?roleEndpoint=$roleEndpoint';
  static String getSignupPageRoute(String roleEndpoint) => '$signupPage?roleEndpoint=$roleEndpoint';
  static String getClientHomePageRoute() => homePage;
  static String getMechanicHomePageRoute() => mechanicHomePage;
  static String getUserProfileRoute() => userProfilePage;
  static String getMechanicUserProfileRoute() => mechanicUserProfilePage;
  static String getChatListRoute() => chatListPage;
  static String getUpdateProfilePageRoute() => updateUserProfilePage;


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
      page: () {
      var roleEndpoint = Get.parameters['roleEndpoint'];
        return LoginPage(roleEndpoint: roleEndpoint.toString());
  },
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: signupPage,
      page: () {
        var roleEndpoint = Get.parameters['roleEndpoint'];
        return SignUp(roleEndpoint: roleEndpoint.toString());
      },
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: mechanicHomePage,
      page: () => const MechanicHomePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: chatListPage,
      page: () => const ChatListPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: userProfilePage,
      page: () => const UserProfilePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: updateUserProfilePage,
      page: () => const   UpdateProfilePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: mechanicUserProfilePage,
      page: () => const   MechanicUserProfilePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
  ];
}