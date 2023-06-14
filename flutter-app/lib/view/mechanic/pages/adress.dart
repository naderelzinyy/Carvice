import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/custom_address_form.dart';




class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddAddressPage> {
  
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar:  AppNavigation(title: 'add_address'.tr, automaticallyCallBack: true,),
    body:  const CustomAddressWidget(update: false),
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
