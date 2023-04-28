import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key, required this.title, required this.icon, required this.onPress,  this.endIcon = true,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.orange.withOpacity(0.1),
        ),
        child: Icon(
            icon,
            color: Colors.black
        ),
      ),
      title:  Text(
        title,
      ),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 18,
            color: Colors.grey
        ),
      ): null,
    );
  }
}
