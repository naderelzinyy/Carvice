import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/custom_app_footer.dart';
import '../../../widgets/mechanic_portfolio.dart';

class MechanicProfile extends StatelessWidget {
  const MechanicProfile({Key? key, this.id});
  final String? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppNavigation(
          title: 'mechanic_portfolio'.tr,
          automaticallyCallBack: true,
        ),
        body:
            SafeArea(child: MechanicPortfolio(isClient: true, mechanicID: id)),
        bottomNavigationBar: const CustomFooterWidget());
  }
}
