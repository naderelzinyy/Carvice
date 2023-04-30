import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/profile_form.dart';



class ClientUpdateProfilePage extends StatelessWidget {
  const ClientUpdateProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppNavigation(
        title: "Update Profile",
        automaticallyCallBack: true,
      ),
      body:ProfileForm(
        image:    'assets/images/profile.png',
        firstName: 'Spong',
        lastName: 'Bob',
        userName: 'Spongbob',
        email: 'Spongbob@carvice.com',
        phoneNumber: '1234567890',
        onPressed: () {
          print("edit picture icon pressed in client");
        },
        onTap: () {
          // TODO: Add save functionality here
          print("save updates btn pressed in client");
        },
      ),
    );
  }
}
