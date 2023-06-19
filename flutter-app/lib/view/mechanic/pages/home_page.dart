import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/authentication.dart';
import '../../../services/websocket_connection.dart';
import '../../../widgets/add_addres_alert.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/bottom_navigation.dart';
import '../../../widgets/map_widget/map_page.dart';
import '../../../widgets/side_bar.dart';

class MechanicHomePage extends StatefulWidget {
  MechanicHomePage({Key? key}) : super(key: key);

  @override
  _MechanicHomePageState createState() => _MechanicHomePageState();
}

class _MechanicHomePageState extends State<MechanicHomePage> {
  bool hasAddress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await setAddressIfExist();

      if (hasAddress) {
        await StreamConnection(
                'ws://127.0.0.1:8000/ws/socket/geospatial-server/${token!["id"]}/',
                context,
                "mechanic")
            .connect();
      }
      await init(context);
    });
  }

  Future<bool> hasRegisteredAddress() async {
    // Replace this with your logic to check the registered address in your database
    // Return true if there is a registered address, false otherwise

    if (await AccountManager()
        .getMechanicAddressInfo({"user_id": token!["id"]})) {
      return true;
    }
    return false;
  }

  Future<void> setAddressIfExist() async {
    hasAddress = await hasRegisteredAddress();
  }

  Future<void> init(BuildContext context) async {
    if (!hasAddress) {
      handleAddAddress(context);
    } else {
      // requestStream(context);
    }
  }

  void handleAddAddress(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAddAddressAlertDialog(
          title: 'no_address_alert'.tr,
          content: Text('no_address_alert_clarification'.tr),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const bool isClient = false;

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
