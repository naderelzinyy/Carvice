import 'package:carvice_frontend/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/authentication.dart';
import '../../../widgets/add_addres_alert.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/profile_menu.dart';
import '../../../widgets/user_information_part.dart';
import '../../general/pages/payment/wallet.dart';

class MechanicUserProfilePage extends StatelessWidget {
  const MechanicUserProfilePage({Key? key}) : super(key: key);

  Future<bool> checkAddressExistence() async {
    // Add your logic here to check if the address exists in the database
    // You can use any database querying method or API call to perform the check

    // For demonstration purposes, let's assume the address exists
    bool addressExists = false;


    return addressExists;
  }


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
              title: 'settings'.tr,
              icon: Icons.settings,
              onPress: () {
                Get.toNamed(Routers.getSettingsPageRoute());
              },
            ),
            ProfileMenu(
              title: 'mechanic_portfolio'.tr,
              icon: Icons.work,
              onPress: () {
                Get.toNamed(Routers.getMechanicPortfolioRoute());
              },
            ),
            ProfileMenu(
              title: 'myAddress'.tr,
              icon: Icons.location_on,
              onPress: () async {
                // Check if the address exists in the database
                bool addressExists = await checkAddressExistence();

                if (addressExists) {
                  Get.toNamed(Routers.getUpdateAddressPageRoute());
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomAddAddressAlertDialog(
                        title: "You Don't Have an address yet please add one",
                        content: Text('You need to add your address in order to start receiving requests!'),
                      );
                    },
                  );
                }
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
          const BottomNavigation(selectedIndex: 2, roleEndpoint: "mechanic"),
    );
  }
}
