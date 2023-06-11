import 'package:flutter/material.dart';
import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:carvice_frontend/widgets/side_bar.dart';
import 'package:carvice_frontend/widgets/bottom_navigation.dart';
import '../../../widgets/add_addres_alert.dart';
import '../../../widgets/map_widget/map_page.dart';

class MechanicHomePage extends StatelessWidget {
  const MechanicHomePage({super.key});



  // Function to check if the mechanic has a registered address
  bool hasRegisteredAddress() {
    // Replace this with your logic to check the registered address in your database
    // Return true if there is a registered address, false otherwise
    return false;
  }

  // Function to handle the "Add My Address" button click
  void handleAddAddress(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAddAddressAlertDialog(
          title: 'Please Add Your Address',
          content: Text('You need to add your address in order to start receiving requests!'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const bool isClient = false;
    bool hasAddress = hasRegisteredAddress();

    if (!hasAddress) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleAddAddress(context);
      });
    }

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
