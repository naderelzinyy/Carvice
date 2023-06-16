import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../widgets/button.dart';
import '../../../widgets/cars_list.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_app_footer.dart';

class CarsListPage extends StatefulWidget {
  const CarsListPage({Key? key}) : super(key: key);

  @override
  CarsListPageState createState() => CarsListPageState();
}

class CarsListPageState extends State<CarsListPage> {
  List<MyListItem> _carsList = [];
  final AccountManager _accountManager = AccountManager();
  void getCarsList() async {
    List<dynamic> carsData = await _accountManager.getCars();
    setState(() {
      _carsList = carsData
          .map((item) => MyListItem(
          name: item["plate_number"],
        carID: item["id"].toString()
      ))
          .toList();
    });
  }
  @override
  void initState() {
    super.initState();
    getCarsList();
  }

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
                Get.toNamed(Routers.getAddCarPageRoute(false));
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomFooterWidget()
    );
  }
}
