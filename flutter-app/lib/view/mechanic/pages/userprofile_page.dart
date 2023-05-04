import 'package:carvice_frontend/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/authentication.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/profile_menu.dart';
import '../../../widgets/user_information_part.dart';

class MechanicUserProfilePage extends StatelessWidget {
  const MechanicUserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavigation(
        title: "Profile",
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            CustomProfile(
              image: 'assets/images/mechanic_profile.jpeg',
              title: "${token!['first_name']} ${token!['last_name']}",
              email: token!['email'],
              onTap: () {
                Get.toNamed(Routers.getMechanicUpdateProfilePageRoute());
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
              title: 'Settings',
              icon: Icons.settings,
              onPress: () {
                print("Settings btn pressed");
              },
            ),
            ProfileMenu(
              title: 'My Address',
              icon: Icons.location_on,
              onPress: () {
                print("Addresses btn pressed");
              },
            ),
            ProfileMenu(
              title: 'My Wallet',
              icon: Icons.account_balance_wallet,
              onPress: () {
                print("wallet btn pressed");
              },
            ),
            ProfileMenu(
              title: 'Logout',
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
          const BottomNavigation(selectedIndex: 2, roleEndpoint: "mechanic"),
    );
  }
}
