import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/authentication.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/profile_form.dart';

class ClientUpdateProfilePage extends StatelessWidget {
  const ClientUpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation(
        title: 'updateProfile'.tr,
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
          print("update picture btn pressed in client");
        },
      ),
    );
  }
}
