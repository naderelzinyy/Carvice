import 'package:flutter/material.dart';

class SideBarGlobal extends StatelessWidget {
  const SideBarGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text(
                'John Doe' ,
                style: TextStyle(
                    color: Colors.black ,
                    fontWeight: FontWeight.bold)
            ),
            accountEmail: Text(
                'johndoe@example.com',
                style: TextStyle(
                    color: Colors.black
                )
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 30.0,
                color: Colors.black,),
            ),
            decoration: BoxDecoration(
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
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text('My Cars'),
            onTap: () {
              // Handle my car tap
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
            onTap: () {
              // Handle log out tap
            },
          ),
        ],
      ),
    );
  }
}
