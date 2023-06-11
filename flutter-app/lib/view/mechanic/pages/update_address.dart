import 'package:flutter/material.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/custom_address_form.dart';




class UpdateAddressPage extends StatefulWidget {
  const UpdateAddressPage({super.key});


  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateAddressPage> {


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:  const AppNavigation(title: 'Update Address', automaticallyCallBack: true,),
      body:  const CustomAddressWidget(update: true),
      bottomNavigationBar: Container(
          height: 100,
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Made with ♥ by Carvice team",
              ),
            ],
          )
      ),
    );
  }
}
