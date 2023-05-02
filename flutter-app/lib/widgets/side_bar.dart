import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import '../services/authentication.dart';

class SideBarGlobal extends StatelessWidget {
  final bool showMyCars;

  const SideBarGlobal({Key? key, this.showMyCars = false}) : super(key: key);

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
            title: const Text('Notifications'),
            onTap: () {
              // Handle notification tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment Method'),
            onTap: () {
              // Handle payment method tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Wallet'),
            onTap: () {
              // Handle wallet tap
            },
          ),
          if (showMyCars)
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('My Cars'),
              onTap: () {
                Get.toNamed(Routers.getCarsListPageRoute());
              },
            ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            onTap: () {
              // Handle language tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Support and Help'),
            onTap: () {
              // Handle support and help tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              // Handle about us tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () async {
              if (await Authenticator().logout({})) {
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
