import 'package:carvice_frontend/widgets/car_information_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_navigation.dart';



class AddCarPage extends StatelessWidget {
  const AddCarPage({Key? key, required this.quickAdd}) : super(key: key);
  final bool quickAdd;


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppNavigation(
        title: 'addNewCar'.tr,
        automaticallyCallBack: true,
      ),
      body:  CarsForm(update: false, quickAdd: quickAdd,
      ),
    );
  }
}
