import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../widgets/app_navigation.dart';
import '../../../widgets/mechanic_portfolio.dart';


class MechanicPortfolioPage extends StatelessWidget {
  const MechanicPortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppNavigation(
        title: 'mechanic_portfolio'.tr,
        automaticallyCallBack: true,
      ),
      body: SafeArea(
          child: MechanicPortfolio(isClient: false)
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
