import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';
import '../../general/pages/chat/chat_list_page.dart';



class MechanicChatListPage extends StatelessWidget {
  const MechanicChatListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: AppNavigation(title: "Chat History",),
      body: Center(
        child: ChatHomePage(),
      ),
      bottomNavigationBar: BottomNavigation(selectedIndex: 0, roleEndpoint: "mechanic"),
    );
  }
}
