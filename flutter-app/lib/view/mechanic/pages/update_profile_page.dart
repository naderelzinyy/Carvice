import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/authentication.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/profile_form.dart';

class MechanicUpdateProfilePage extends StatelessWidget {
  const MechanicUpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation(
        title: 'updateProfile'.tr,
        automaticallyCallBack: true,
      ),
      body: ProfileForm(
        image: 'assets/images/mechanic_profile.jpeg',
        firstName: token!["first_name"],
        lastName: token!["last_name"],
        userName: token!["username"],
        email: token!["email"],
        phoneNumber: token!["phone_number"],
        onTap: () {
          print("save updates btn pressed in mechanic");
        },
          roleEndpoint: "mechanic"
      ),
    );
  }
}
