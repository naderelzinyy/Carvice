import 'dart:convert';

import 'package:carvice_frontend/widgets/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_app_footer.dart';
import '../../../widgets/mechanic_list.dart';

class MechanicListPage extends StatefulWidget {
  const MechanicListPage(
      {Key? key, required this.mechanics, this.note, this.carID, this.location})
      : super(key: key);
  final String? mechanics;
  final String? note;
  final String? carID;
  final String? location;

  @override
  MechanicListPageState createState() => MechanicListPageState();
}

class MechanicListPageState extends State<MechanicListPage> {
  List<MyMechanicItem> mechanicList = [];
  late String? mechanics = widget.mechanics;
  void getMechanicList() {
    List<dynamic> mechanicsData = jsonDecode(mechanics!);
    setState(() {
      mechanicList = mechanicsData
          .map((item) => MyMechanicItem(
              name: item?["commercial_name"],
              id: item?["user_id"],
              imagePath: 'assets/images/person.jpeg'))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getMechanicList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppNavigation(
          title: 'available_mechanics'.tr,
          automaticallyCallBack: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: CustomMechanicList(
                list: mechanicList,
                note: widget.note,
                carID: widget.carID,
                location: widget.location,
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomFooterWidget());
  }
}
