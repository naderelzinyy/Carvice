import 'package:flutter/material.dart';

class CustomRequestStreamAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const CustomRequestStreamAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(title), content: content, actions: actions);
  }
}
