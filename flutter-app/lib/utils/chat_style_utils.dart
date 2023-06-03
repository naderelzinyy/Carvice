import 'package:flutter/material.dart';

const mySendButtonTextStyle = TextStyle(
  color: Color(0xFFF2B133),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
const myBubbleMessageRadiusDecoration = BorderRadius.only(
    bottomRight: Radius.circular(28), bottomLeft: Radius.circular(28));

const myMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const myMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Color(0xFFF2B133), width: 2.0),
  ),
);
const myTextFieldDecoration = InputDecoration(
  hintText: 'Enter information',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFF2B133), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFF2B133), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
