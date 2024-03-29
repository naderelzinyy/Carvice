import 'dart:convert';

import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/select_car.dart';
import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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

  void handleNextButtonPressed() {
    if (selectedItem != null) {
      setState(() {
        isNextButtonPressed = true;
      });
    }
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;

      String street = placemark.street ?? '';
      String subLocality = placemark.subLocality ?? '';
      String locality = placemark.locality ?? '';
      String subAdministrativeArea = placemark.subAdministrativeArea ?? '';
      String administrativeArea = placemark.administrativeArea ?? '';
      String postalCode = placemark.postalCode ?? '';
      String country = placemark.country ?? '';

      String address =
          '$street, $subLocality, $locality, $subAdministrativeArea, $administrativeArea $postalCode, $country';

      return address;
    } else {
      return 'No address found for the given coordinates.';
    }
  }

  Future<void> handleFinalNextButtonPressed() async {
    if (noteController.text.isNotEmpty) {
      print("position :: $position");
      List<dynamic> mechanics = (await AccountManager().getAvailableMechanics({
        "coordinates": [position?.latitude, position?.longitude]
      }));
      String location = await getAddressFromCoordinates(
          position!.latitude, position!.longitude);
      String mechanicsDataString = jsonEncode(mechanics);
      Get.toNamed(Routers.getListOfMechanicsPageRoute(mechanicsDataString,
          noteController.text, selectedItem!.carID, location));
      print("mechanics :: $mechanics");

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
        title: Text('note_alert'.tr),
        content: CustomTextFiled(
          controller: noteController,
          hintText: 'note_alert_text_hint'.tr,
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
              'next'.tr,
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
            ? Center(
                child: Text(
                  'no_car_alert'.tr,
                  style: const TextStyle(
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
            isEmptyList ? 'addNewCar'.tr : 'next'.tr,
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
