import 'dart:async';
import 'package:carvice_frontend/view/start/pages/starting_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:carvice_frontend/utils/main.colors.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const route = "home_page";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        opacityLevel = 1.0;
      });
      Timer(const Duration(seconds: 1), () {
        Get.to(() => const StartingPage(), transition: Transition.fade,
            duration: const Duration(seconds: 1));


      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.mainColor,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacityLevel,
          child: Image.asset(
            'assets/images/logo.jpg',
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
