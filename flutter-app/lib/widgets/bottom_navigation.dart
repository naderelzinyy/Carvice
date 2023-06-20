import 'package:carvice_frontend/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final String roleEndpoint;

  const BottomNavigation(
      {Key? key, required this.selectedIndex, required this.roleEndpoint})
      : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;
  late String _roleEndpoint;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _roleEndpoint = widget.roleEndpoint;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Check if it's already selected
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to chat screen
        if (_roleEndpoint == "client") {
          Get.offAllNamed(Routers.getClientChatListRoute());
        } else if (_roleEndpoint == "mechanic") {
          Get.offAllNamed(Routers.getMechanicChatListRoute());
        }

        break;
      case 1:
        // Navigate to home screen
        if (_roleEndpoint == "client") {
          Get.offAllNamed(Routers.getClientHomePageRoute());
        } else if (_roleEndpoint == "mechanic") {
          Get.offAllNamed(Routers.getMechanicHomePageRoute());
        }
        break;
      case 2:
        // Navigate to user profile screen
        if (_roleEndpoint == "client") {
          Get.offAllNamed(Routers.getUserProfileRoute());
        } else if (_roleEndpoint == "mechanic") {
          Get.offAllNamed(Routers.getMechanicUserProfileRoute());
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat, color: Colors.black),
          label: 'chat'.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home, color: Colors.black),
          label: 'home'.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person, color: Colors.black),
          label: 'user'.tr,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      onTap: _onItemTapped, // Pass _onItemTapped function as parameter
    );
  }
}
