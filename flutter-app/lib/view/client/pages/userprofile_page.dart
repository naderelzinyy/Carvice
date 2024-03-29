import 'package:carvice_frontend/routes/routes.dart';
import 'package:carvice_frontend/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/profile_menu.dart';
import '../../../widgets/rating_alert.dart';
import '../../../widgets/user_information_part.dart';
import '../../general/pages/payment/wallet.dart';

class ClientUserProfilePage extends StatelessWidget {
  const ClientUserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppNavigation(
        title: 'profile'.tr,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            CustomProfile(
              image: 'assets/images/profile.png',
              title: "${token!['first_name']} ${token!['last_name']}",
              email: token!['email'],
              onTap: () {
                Get.toNamed(Routers.getClientUpdateProfilePageRoute());
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            ProfileMenu(
              title: 'settings'.tr,
              icon: Icons.settings,
              onPress: () {
                Get.toNamed(Routers.getSettingsPageRoute());
              },
            ),
            ProfileMenu(
              title: 'myCars'.tr,
              icon: Icons.directions_car,
              onPress: () {
                Get.toNamed(Routers.getCarsListPageRoute());
              },
            ),
            ProfileMenu(
              title: 'wallet'.tr,
              icon: Icons.account_balance_wallet,
              onPress: () {
                print("wallet btn pressed");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WalletPage()),
                );
              },
            ),
            ProfileMenu(
              title: 'logOut'.tr,
              icon: Icons.logout,
              onPress: () async {
                if (await AccountManager().logout({})) {
                  token = {};
                  Get.offAllNamed(Routers.getStartingPageRoute());
                }
              },
            ),
          ],
        ),
      )),
      bottomNavigationBar:
          const BottomNavigation(selectedIndex: 2, roleEndpoint: "client"),
    );
  }
}
