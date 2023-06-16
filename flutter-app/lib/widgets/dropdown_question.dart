import 'package:flutter/material.dart';

import '../utils/main.colors.dart';

class DropdownWidget extends StatefulWidget {
  final String question;
  final String answer;

  const DropdownWidget({super.key, required this.question, required this.answer});

  @override
  DropdownWidgetState createState() => DropdownWidgetState();
}

class DropdownWidgetState extends State<DropdownWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MainColors.mainColor, // Set the background color of the Card
      child: Theme(
        // Use Theme widget to change the text color inside ExpansionTile
        data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          selectedRowColor: Colors.white,
          textTheme: const TextTheme(
            subtitle1: TextStyle(color: Colors.white), // Set the text color
          ),
        ),
        child: ExpansionTile(
          title: Text(
            widget.question,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Set the text color
          ),
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          initiallyExpanded: isExpanded,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.answer,
                style: const TextStyle(color: Colors.white), // Set the text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
