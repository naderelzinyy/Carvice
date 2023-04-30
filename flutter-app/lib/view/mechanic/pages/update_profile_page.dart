import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/profile_form.dart';



class MechanicUpdateProfilePage extends StatelessWidget {
  const MechanicUpdateProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppNavigation(
        title: "Update Profile",
        automaticallyCallBack: true,
      ),
      body:ProfileForm(
        image:    'assets/images/mechanic_profile.jpeg',
        firstName: 'Shafici',
        lastName: 'Habar',
        userName: 'shaficmechanic',
        email: 'mechanic@carvice.com',
        phoneNumber: '1234567890',
        onPressed: () {
          print("edit picture icon pressed in mechanic");
        },
        onTap: () {
          // TODO: Add save functionality here
          print("save updates btn pressed in mechanic");
        },
      ),
    );
  }
}
