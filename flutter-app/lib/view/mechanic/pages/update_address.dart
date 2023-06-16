import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/app_navigation.dart';
import '../../../widgets/custom_address_form.dart';
import '../../../widgets/custom_app_footer.dart';




class UpdateAddressPage extends StatefulWidget {
  const UpdateAddressPage({super.key});


  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateAddressPage> {


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:   AppNavigation(title: 'update_address'.tr, automaticallyCallBack: true,),
      body:  const CustomAddressWidget(update: true),
      bottomNavigationBar: const CustomFooterWidget()
    );
  }
}
