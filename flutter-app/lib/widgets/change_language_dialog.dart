import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('selectLanguage'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('turkish'.tr),
            onTap: () {
              Get.updateLocale(const Locale('tr', 'TR'));
              Get.back(); // Close the dialog
            },
          ),
          ListTile(
            title: Text('english'.tr),
            onTap: () {
              Get.updateLocale(const Locale('en', 'US'));
              Get.back(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}
