import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:carvice_frontend/view/client/pages/login_page.dart';


class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/transparent_logo.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                   CustomButton(btnText: "Mechanic",
                    onTap: () {
                      print('mechanic button tapped');
                      // Add your custom logic here
                    },),
                  const SizedBox(height: 10),
                  CustomButton(btnText: "Costumer",
                    onTap: () {
                      Get.to(() => LoginPage(), transition: Transition.fade,
                          duration: const Duration(seconds: 1));
                      // Add your custom logic here
                    },),
                ],
              ),
            )
        ),
      ),
      bottomNavigationBar: Container(
          height: 100,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: const [
              Text(
                  "Made with ♥ by Carvice team",
              ),
            ],
          )
      ),
    );
  }
}