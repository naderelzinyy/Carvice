import 'package:carvice_frontend/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RatingAlertWidget extends StatefulWidget {
  final String message;
  // Note : this alert must be used in this format: showDialog(
  //                   context: context,
  //                   builder: (BuildContext context) {
  //                     // we need to pass the mechanic id here in order to save it in the database. with the message
  //                     return const RatingAlertWidget(message: 'This is an alert message.');
  //                   },
  //                 );

  const RatingAlertWidget({Key? key, required this.message}) : super(key: key);

  @override
  _RatingAlertWidgetState createState() => _RatingAlertWidgetState();
}

class _RatingAlertWidgetState extends State<RatingAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        "test Rating",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      submitButtonText: "submit",
      submitButtonTextStyle: const TextStyle(color: Colors.black),
      message: Text(
        widget.message,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
      commentHint: "Service Feedback",
      image: Image.asset(
        'assets/images/transparent_logo.png',
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.width * 0.6,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
      onSubmitted: ((response) =>
          {Get.offAllNamed(Routers.getClientHomePageRoute())}),
      onCancelled: (() => {Get.offAllNamed(Routers.getClientHomePageRoute())}),
    );
  }
}
