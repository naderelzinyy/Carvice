import 'package:carvice_frontend/widgets/car_information_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_navigation.dart';

class EditCarPage extends StatefulWidget {
  const EditCarPage({Key? key,required this.carID}) : super(key: key);
  final String carID;

  @override
  _EditCarPageState createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  late String carID = widget.carID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigation(
        title: 'editMyCar'.tr,
        automaticallyCallBack: true,
      ),
      body: CarsForm(
        update: true,
        carId: carID,
      ),
    );
  }
}
