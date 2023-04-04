import 'package:flutter/material.dart';

import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:carvice_frontend/widgets/side_bar.dart';
import 'package:carvice_frontend/widgets/bottom_navigation.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppNavigation(),
      endDrawer: SideBarGlobal(),

      body: Center(
        child: Text('My App'),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
