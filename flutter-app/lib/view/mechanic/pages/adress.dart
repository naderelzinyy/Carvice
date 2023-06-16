import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/custom_address_form.dart';
import '../../../widgets/custom_app_footer.dart';




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
        bottomNavigationBar: const CustomFooterWidget()
    );
  }
}
