import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';



class ChatListPage extends StatelessWidget {
  ChatListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppNavigation(),
      body: Center(
        child: Text('Chat screen'),
      ),
    );
  }
}
