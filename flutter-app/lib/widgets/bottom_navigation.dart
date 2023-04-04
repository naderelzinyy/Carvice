import 'package:flutter/material.dart';
import 'package:carvice_frontend/view/client/pages/chatlist_page.dart';
import 'package:carvice_frontend/view/client/pages/userprofile_page.dart';
import 'package:carvice_frontend/view/client/pages/home_page.dart';
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Check if it's already selected
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // Navigate to chat screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatListPage()),
        );
        break;
      case 1:
      // Navigate to home screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 2:
      // Navigate to user profile screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfilePage()),
        );
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
      onTap: _onItemTapped,
    );
  }
}
