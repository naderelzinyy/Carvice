import 'package:carvice_frontend/widgets/car_information_form.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';



class EditCarPage extends StatelessWidget {
  const EditCarPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: AppNavigation(
        title: "Edit My Car",
        automaticallyCallBack: true,
      ),
      body: CarsForm(update: true,
      ),
    );
  }
}
