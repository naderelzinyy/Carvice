import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import '../services/authentication.dart';
import '../view/general/pages/payment/wallet.dart';
import 'change_language_dialog.dart';

class SideBarGlobal extends StatelessWidget {
  final bool showMyCars;

  const SideBarGlobal({Key? key, this.showMyCars = false}) : super(key: key);

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
            leading: const Icon(Icons.payment),
            title:  Text('paymentMethod'.tr),
            onTap: () {
              // Handle payment method tap
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
          if (showMyCars)
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
              // Handle support and help tap
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
