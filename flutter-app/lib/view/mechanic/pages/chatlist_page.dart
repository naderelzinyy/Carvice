import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';



class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppNavigation(),
      body: Center(
        child: Text('Chat screen'),
      ),
      bottomNavigationBar: BottomNavigation(selectedIndex: 0, roleEndpoint: "mechanic"),
    );
  }
}
