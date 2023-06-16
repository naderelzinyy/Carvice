import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_app_footer.dart';
import '../../../widgets/mechanic_list.dart';

class MechanicListPage extends StatefulWidget {
  const MechanicListPage({Key? key}) : super(key: key);

  @override
  MechanicListPageState createState() => MechanicListPageState();
}

class MechanicListPageState extends State<MechanicListPage> {
  List<MyMechanicItem> mechanicList = [
    MyMechanicItem(
      name: 'John Doe',
      imagePath: 'assets/images/mechanic_profile.jpeg',
      rate: 4.0,
    ),
    MyMechanicItem(
      name: 'Jane Smith',
      imagePath: 'assets/images/person.jpeg',
      rate: 3.7,
    ),
    // Add more mechanic items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppNavigation(title: 'available_mechanics'.tr, automaticallyCallBack: true,),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: CustomMechanicList(list: mechanicList),
          ),
        ],
      ),
      bottomNavigationBar:const CustomFooterWidget()
    );
  }
}
