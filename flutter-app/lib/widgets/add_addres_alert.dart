import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import 'alerts_text_button.dart';
class CustomAddAddressAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;

  const CustomAddAddressAlertDialog({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: <Widget>[
        CustomAlertButton(
          text: 'add_address'.tr,
          onPressed: () {
            Get.toNamed(Routers.getAddressPageRoute());
          },
        ),
        CustomAlertButton(
          text: 'close'.tr,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
