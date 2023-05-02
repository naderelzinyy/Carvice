import 'package:carvice_frontend/widgets/car_information_form.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';



class AddCarPage extends StatelessWidget {
  const AddCarPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: AppNavigation(
        title: "Add new Car",
        automaticallyCallBack: true,
      ),
      body: CarsForm(update: false,
      ),
    );
  }
}
