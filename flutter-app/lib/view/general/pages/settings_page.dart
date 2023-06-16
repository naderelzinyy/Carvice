import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/change_language_dialog.dart';
import '../../../widgets/custom_app_footer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LanguageDialog(); // Use the custom language dialog widget
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation(title: 'settings'.tr, automaticallyCallBack: true),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              'change_language'.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.language),
            onTap: () {
              _showLanguageDialog(context); // Show language selection dialog
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
          ListTile(
            title: Text(
              'change_password'.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.lock),
            onTap: () {
              Get.toNamed(Routers.getChangePasswordPageRoute());
            },
          ),
        ],
      ),
      bottomNavigationBar: const CustomFooterWidget()
    );
  }
}
