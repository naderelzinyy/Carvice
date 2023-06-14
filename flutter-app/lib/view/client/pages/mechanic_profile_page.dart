import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../widgets/app_navigation.dart';
import '../../../widgets/mechanic_portfolio.dart';


class MechanicProfile extends StatelessWidget {
  const MechanicProfile({Key? key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppNavigation(
        title: 'mechanic_portfolio'.tr,
        automaticallyCallBack: true,
      ),
      body: SafeArea(
        child: MechanicPortfolio(isClient: true)
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Made with ♥ by Carvice team",
            ),
          ],
        ),
      ),
    );
  }
}
