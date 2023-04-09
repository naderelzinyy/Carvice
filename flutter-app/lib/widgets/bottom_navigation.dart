import 'package:flutter/material.dart';
import 'package:carvice_frontend/routes/routes.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;

  const BottomNavigation({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Check if it's already selected
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // Navigate to chat screen
        Get.offAllNamed(Routers.getChatListRoute());
        break;
      case 1:
      // Navigate to home screen
        Get.offAllNamed(Routers.getHomePageRoute());
        break;
      case 2:
      // Navigate to user profile screen
        Get.offAllNamed(Routers.getUserProfileRoute());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat, color: Colors.black),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.black),
          label: 'User',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      onTap: _onItemTapped, // Pass _onItemTapped function as parameter
    );
  }
}
