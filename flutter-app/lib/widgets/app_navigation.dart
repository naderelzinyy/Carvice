import 'package:flutter/material.dart';
import 'package:carvice_frontend/utils/main.colors.dart';

class AppNavigation extends StatelessWidget implements PreferredSizeWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, // set the color of the icon to black
          ),
          backgroundColor: MainColors.mainColor,
          title: const Text('Carvice',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )),
          centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
