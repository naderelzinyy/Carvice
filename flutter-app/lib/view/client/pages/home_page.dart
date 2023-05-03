import 'package:flutter/material.dart';

import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:carvice_frontend/widgets/side_bar.dart';
import 'package:carvice_frontend/widgets/bottom_navigation.dart';


class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppNavigation(title: "Carvice",),
      endDrawer: SideBarGlobal(showMyCars: true),

        body: Center(
        child: Text('My App client'),
      ),
      bottomNavigationBar: BottomNavigation(selectedIndex: 1, roleEndpoint: "client",),
    );
  }
}
