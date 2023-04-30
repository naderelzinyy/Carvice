import 'package:flutter/material.dart';
import 'package:carvice_frontend/utils/main.colors.dart';

class AppNavigation extends StatelessWidget implements PreferredSizeWidget {
  const AppNavigation({super.key,  this.automaticallyCallBack = false, required this.title});
  final bool automaticallyCallBack ;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, // set the color of the icon to black
          ),
          backgroundColor: MainColors.mainColor,
          title:  Text( title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )),
          centerTitle: false,
      automaticallyImplyLeading: automaticallyCallBack,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
