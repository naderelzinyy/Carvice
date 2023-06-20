import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import '../services/authentication.dart';
import '../view/general/pages/payment/wallet.dart';
import 'add_addres_alert.dart';
import 'change_language_dialog.dart';

class SideBarGlobal extends StatelessWidget {
  final bool isClient;

  const SideBarGlobal({Key? key, this.isClient = false}) : super(key: key);

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LanguageDialog(); // Use the custom language dialog widget
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(token!['first_name'],
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            accountEmail: Text(token!['email'],
                style: const TextStyle(color: Colors.black)),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 30.0,
                color: Colors.black,
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFF2B133),
            ),
          ),
          const SizedBox(height: 40),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text('notifications'.tr),
            onTap: () {
              // Handle notification tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title:  Text('wallet'.tr),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WalletPage()),
              );
            },
          ),
          if (!isClient)
            ListTile(
              leading: const Icon(Icons.work),
              title:  Text('mechanic_portfolio'.tr,),
              onTap: () {
                Get.toNamed(Routers.getMechanicPortfolioRoute());
              },
            ),
          if (!isClient)
            ListTile(
              leading: const Icon(Icons.location_on),
              title:  Text('myAddress'.tr,),
              onTap: () async {
            // Check if the address exists in the database
            bool addressExists = mechanicAddressInfo != null ? true : false;

            if (addressExists) {
            Get.toNamed(Routers.getUpdateAddressPageRoute());
            } else {
            showDialog(
            context: context,
            builder: (BuildContext context) {
            return  CustomAddAddressAlertDialog(
            title: 'no_address_alert'.tr,
            content: Text('no_address_alert_clarification'.tr),
            );
            },
            );
            }
            },
            ),
          if (isClient)
            ListTile(
              leading: const Icon(Icons.directions_car),
              title:  Text('myCars'.tr),
              onTap: () {
                Get.toNamed(Routers.getCarsListPageRoute());
              },
            ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('language'.tr),
            onTap: () {
              _showLanguageDialog(context); // Show language selection dialog
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text('supportAndHelp'.tr),
            onTap: () {
              if(isClient){
                Get.toNamed(Routers.getClientHelpAndSupportPagePageRoute());
              }
              else{
                Get.toNamed(Routers.getMechanicHelpAndSupportPagePageRoute());
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text('aboutUs'.tr),
            onTap: () {
              Get.toNamed(Routers.getAboutUsPageRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('logOut'.tr),
            onTap: () async {
              if (await AccountManager().logout({})) {
                token = {};
                Get.offAllNamed(Routers.getStartingPageRoute());
              }
            },
          ),
        ],
      ),
    );
  }
}
