import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';



class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppNavigation(),
      body: Center(
        child: Text('User profile screen'),
      ),
    );
  }
}
