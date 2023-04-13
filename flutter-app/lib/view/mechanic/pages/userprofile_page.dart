import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';



class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppNavigation(),
      body: Center(
        child: Text('User profile screen'),
      ),
      bottomNavigationBar: BottomNavigation(selectedIndex: 2, roleEndpoint: "mechanic"),
    );
  }
}
