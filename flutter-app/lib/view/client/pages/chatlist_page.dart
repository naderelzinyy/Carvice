import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';
import '../../general/pages/chat/chat_list_page.dart';



class ClientChatListPage extends StatelessWidget {
  const ClientChatListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppNavigation(title: 'chatList'.tr,),
      body: const Center(
        child: ChatHomePage(),
      ),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 0, roleEndpoint: "client"),
    );
  }
}
