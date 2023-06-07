import 'package:carvice_frontend/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:get/get.dart';

class RatingAlertWidget extends StatefulWidget {
  final String message;

  const RatingAlertWidget({Key? key, required this.message}) : super(key: key);

  @override
  _RatingAlertWidgetState createState() => _RatingAlertWidgetState();
}

class _RatingAlertWidgetState extends State<RatingAlertWidget> {

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
        title: const Text("test Rating", style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
          textAlign: TextAlign.center,
        ),
        submitButtonText: "submit",
        submitButtonTextStyle: const TextStyle(
          color: Colors.black
        ),
        message: Text(widget.message, style: const TextStyle(
          fontSize: 16
        ),
          textAlign: TextAlign.center,
        ),
        commentHint: "Service Feedback",
        image: Image.asset(
            'assets/images/transparent_logo.png',
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.6,
          fit: BoxFit.contain, alignment: Alignment.center,),
        onSubmitted: ((response) =>{
          print("my rating: ${response.rating} , comment: ${response.comment}")
        }
        ),
      onCancelled: (() =>{
       Get.offAllNamed(Routers.getClientHomePageRoute())
      }
      ),

    );
  }
}
