import 'package:flutter/material.dart';

import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:carvice_frontend/widgets/side_bar.dart';
import 'package:carvice_frontend/widgets/bottom_navigation.dart';

import '../../../widgets/map_widget/map_page.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const bool isClient = true;
    return const Scaffold(
      appBar: AppNavigation(
        title: "Carvice",
      ),
      endDrawer: SideBarGlobal(isClient: true),
      body: Center(
        child: MapTrackingPage(isClient),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 1,
        roleEndpoint: "client",
      ),
    );
  }
}
