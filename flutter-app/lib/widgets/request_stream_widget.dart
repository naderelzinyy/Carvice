import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'alerts_text_button.dart';

class CustomRequestStreamAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;

  const CustomRequestStreamAlertDialog(
      {Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: <Widget>[
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
