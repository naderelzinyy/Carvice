import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/select_car.dart';
import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import '../utils/main.colors.dart';

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog({Key? key, required this.position}) : super(key: key);
  final Position? position;
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  late Position? position = widget.position;
  List<SelectCar> _carsList = [];
  final AccountManager _accountManager = AccountManager();
  SelectCar? selectedItem;
  bool isNextButtonPressed = false;
  TextEditingController noteController = TextEditingController();

  void getCarsList() async {
    List<dynamic> carsData = await _accountManager.getCars();
    setState(() {
      _carsList = carsData
          .map(
            (item) => SelectCar(
          name: item["plate_number"],
          carID: item["id"].toString(),
        ),
      )
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getCarsList();

    noteController.addListener(() {
      setState(() {});
    });
  }

  void handleCarSelected(SelectCar? car) {
    setState(() {
      selectedItem = car;
    });
  }

  Future<void> handleNextButtonPressed() async {
    if (selectedItem != null) {
      setState(() {
        isNextButtonPressed = true;
      });
    }
    print("position :: $position");
    List<dynamic> mechanics = (await AccountManager().getAvailableMechanics({
      "coordinates": [position?.longitude, position?.latitude]
    }));
    print("mechanics :: $mechanics");
  }

  void handleFinalNextButtonPressed() {
    if (noteController.text.isNotEmpty) {
      print(noteController.text);
      print(selectedItem?.carID);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNextButtonEnabled = selectedItem != null;
    bool isEmptyList = _carsList.isEmpty;

    if (isNextButtonPressed) {
      return AlertDialog(
        title: const Text('Enter Note'),
        content: CustomTextFiled(
          controller: noteController,
          hintText: 'Note',
          textInputType: TextInputType.text,
          obscureText: false,
        ),
        actions: [
          TextButton(
            onPressed: noteController.text.isNotEmpty
                ? () {
              handleFinalNextButtonPressed();
            }
                : null,
            child: Text(
              'Next',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: noteController.text.isNotEmpty
                    ? MainColors.mainColor
                    : Colors.grey,
              ),
            ),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text('select_car'.tr),
      content: SizedBox(
        width: double.maxFinite,
        height: 150,
        child: isEmptyList
            ? const Center(
          child: Text(
            'You don\'t have any car in your list. Please add a new car.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : CustomSelectCarList(
          list: _carsList,
          onCarSelected: handleCarSelected,
        ),
      ),
      actions: [
        TextButton(
          onPressed: isEmptyList
              ? () {
            Get.toNamed(Routers.getAddCarPageRoute(true));
          }
              : isNextButtonEnabled
              ? () {
            handleNextButtonPressed();
          }
              : null,
          child: Text(
            isEmptyList ? 'Add New Car' : 'Next',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: isEmptyList
                  ? MainColors.mainColor
                  : isNextButtonEnabled
                  ? MainColors.mainColor
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
