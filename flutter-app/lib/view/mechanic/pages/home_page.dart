import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:carvice_frontend/widgets/bottom_navigation.dart';
import 'package:carvice_frontend/widgets/side_bar.dart';
import 'package:flutter/material.dart';

import '../../../widgets/add_addres_alert.dart';
import '../../../widgets/map_widget/map_page.dart';

class MechanicHomePage extends StatelessWidget {
  MechanicHomePage({Key? key}) : super(key: key);

  Future<bool> hasRegisteredAddress() async {
    // Replace this with your logic to check the registered address in your database
    // Return true if there is a registered address, false otherwise

    if (await AccountManager()
        .getMechanicAddressInfo({"user_id": token!["id"]})) {
      return true;
    }
    return false;
  }

  Future<void> init(BuildContext context) async {
    if (!await hasRegisteredAddress()) {
      handleAddAddress(context);
    }
  }

  void handleAddAddress(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAddAddressAlertDialog(
          title: 'Please Add Your Address',
          content: Text(
              'You need to add your address in order to start receiving requests!'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const bool isClient = false;

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      init(context);
    });

    return const Scaffold(
      appBar: AppNavigation(
        title: 'Carvice',
      ),
      endDrawer: SideBarGlobal(),
      body: Center(
        child: MapTrackingPage(isClient),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 1,
        roleEndpoint: 'mechanic',
      ),
    );
  }
}
