import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';



class ClientChatListPage extends StatelessWidget {
  const ClientChatListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppNavigation(title: "Chat List",),
      body: Center(
        child: Text('Chat screen client'),
      ),
      bottomNavigationBar: BottomNavigation(selectedIndex: 0, roleEndpoint: "client"),
    );
  }
}
