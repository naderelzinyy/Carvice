import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:carvice_frontend/widgets/button.dart';

import '../../../routes/routes.dart';
import '../../../widgets/custom_app_footer.dart';

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
              CustomButton(
                btnText: 'mechanic'.tr,
                onTap: () {
                  Get.offAllNamed(Routers.getLoginPageRoute("mechanic"));
                  // Add your custom logic here
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                btnText:'client'.tr,
                onTap: () {
                  Get.offAllNamed(Routers.getLoginPageRoute("client"));
                  // Add your custom logic here
                },
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: const CustomFooterWidget()
    );
  }
}
