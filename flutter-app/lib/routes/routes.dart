import 'package:carvice_frontend/view/client/pages/add_new_car_page.dart';
import 'package:carvice_frontend/view/client/pages/carslist_page.dart';
import 'package:carvice_frontend/view/client/pages/edit_car_info_page.dart';
import 'package:carvice_frontend/view/client/pages/update_profile_page.dart';
import 'package:carvice_frontend/view/mechanic/pages/userprofile_page.dart';
import 'package:get/get.dart';

import 'package:carvice_frontend/view/general/pages/signup_page.dart';
import 'package:carvice_frontend/view/general/pages/starting_page.dart';
import 'package:carvice_frontend/view/general/pages/login_page.dart';
import 'package:carvice_frontend/view/general/pages/splash_page.dart';

import '../view/client/pages/chatlist_page.dart';
import '../view/client/pages/home_page.dart';
import '../view/client/pages/userprofile_page.dart';
import '../view/general/pages/aboutus_page.dart';
import '../view/mechanic/pages/home_page.dart';
import '../view/mechanic/pages/chatlist_page.dart';
import '../view/mechanic/pages/update_profile_page.dart';



class Routers {
  static String splashPage = "/";
  static String startingPage = "/starting_page";
  static String loginPage = "/login";
  static String signupPage = "/signup";
  static String clientHomePage = "/home";
  static String mechanicHomePage = "/mechanic_home";
  static String clientUserProfilePage = "/client_user_profile";
  static String clientChatListPage = "/client_chat_list";
  static String mechanicChatListPage = "/mechanic_chat_list";
  static String mechanicUserProfilePage = "/mechanic_user_profile";
  static String clientUpdateUserProfilePage = "/client_update_profile";
  static String mechanicUpdateUserProfilePage = "/mechanic_update_profile";
  static String carsListPage = "/cars_list";
  static String editCarPage = "/edit_car";
  static String addCarPage = "/add_car";
  static String aboutUsPage = "/about_us";



  static String getMainRoute() => splashPage;
  static String getStartingPageRoute() => startingPage;
  static String getLoginPageRoute(String roleEndpoint) => '$loginPage?roleEndpoint=$roleEndpoint';
  static String getSignupPageRoute(String roleEndpoint) => '$signupPage?roleEndpoint=$roleEndpoint';
  static String getClientHomePageRoute() => clientHomePage;
  static String getMechanicHomePageRoute() => mechanicHomePage;
  static String getUserProfileRoute() => clientUserProfilePage;
  static String getMechanicUserProfileRoute() => mechanicUserProfilePage;
  static String getClientChatListRoute() => clientChatListPage;
  static String getMechanicChatListRoute() => mechanicChatListPage;
  static String getClientUpdateProfilePageRoute() => clientUpdateUserProfilePage;
  static String getMechanicUpdateProfilePageRoute() => mechanicUpdateUserProfilePage;
  static String getCarsListPageRoute() => carsListPage;
  static String getEditCarPageRoute() => editCarPage;
  static String getAddCarPageRoute() => addCarPage;
  static String getAboutUsPageRoute() => aboutUsPage;


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
      name: clientHomePage,
      page: () => const ClientHomePage(),
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
      name: clientChatListPage,
      page: () => const ClientChatListPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: mechanicChatListPage,
      page: () => const MechanicChatListPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: clientUserProfilePage,
      page: () => const ClientUserProfilePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: mechanicUserProfilePage,
      page: () => const   MechanicUserProfilePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: clientUpdateUserProfilePage,
      page: () => const   ClientUpdateProfilePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: mechanicUpdateUserProfilePage,
      page: () => const   MechanicUpdateProfilePage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: carsListPage,
      page: () => const   CarsListPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: editCarPage,
      page: () => const   EditCarPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: addCarPage,
      page: () => const   AddCarPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
    GetPage(
      name: aboutUsPage,
      page: () => const   AboutUsPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 20),
    ),
  ];
}