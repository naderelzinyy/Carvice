import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../widgets/button.dart';
import '../../../widgets/cars_list.dart';
import 'package:get/get.dart';



class CarsListPage extends StatefulWidget {
  const CarsListPage({Key? key}) : super(key: key);

  @override
  CarsListPageState createState() => CarsListPageState();
}

class CarsListPageState extends State<CarsListPage> {
  final List<MyListItem> _carsList = [
    MyListItem(
      name: 'Item 1',
      picUrl: 'https://picsum.photos/200/300',
    ),
    MyListItem(
      name: 'Item 2',
    ),
    MyListItem(
      name: 'Item 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppNavigation(title: 'myCars'.tr, automaticallyCallBack: true,),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: CustomItemList(list: _carsList),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: CustomButton(
              btnText:'addNewCar'.tr,
              onTap: () {
                Get.toNamed(Routers.getAddCarPageRoute());
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          height: 100,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: const [
              Text(
                "Made with ♥ by Carvice team",
              ),
            ],
          )
      ),
    );
  }
}
