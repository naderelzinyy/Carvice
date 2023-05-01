import 'package:flutter/material.dart';

import '../../../services/authentication.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/profile_form.dart';

class ClientUpdateProfilePage extends StatelessWidget {
  const ClientUpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppNavigation(
        title: "Update Profile",
        automaticallyCallBack: true,
      ),
      body: ProfileForm(
        image: 'assets/images/profile.png',
        firstName: token!["first_name"],
        lastName: token!["last_name"],
        userName: token!["username"],
        email: token!["email"],
        phoneNumber: token!["phone_number"],
        onTap: () {
          // TODO: Add save functionality here
          print("save updates btn pressed in client");
        },
      ),
    );
  }
}
