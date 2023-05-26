import 'package:carvice_frontend/widgets/car_information_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_navigation.dart';



class AddCarPage extends StatelessWidget {
  const AddCarPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppNavigation(
        title: 'addNewCar'.tr,
        automaticallyCallBack: true,
      ),
      body: const CarsForm(update: false,
      ),
    );
  }
}
