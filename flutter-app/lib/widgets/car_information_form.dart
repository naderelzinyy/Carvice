import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../services/authentication.dart';
import '../utils/main.colors.dart';
import 'button.dart';
import 'package:get/get.dart';

class CarsForm extends StatefulWidget {
  final bool update;
  final String? carId;

  const CarsForm({Key? key, required this.update, this.carId}) : super(key: key);

  @override
  _CarsFormState createState() => _CarsFormState();
}

class _CarsFormState extends State<CarsForm> {
  final _carBrandController = TextEditingController();
  final _carPlateController = TextEditingController();
  final _carSeriesController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carFuelController = TextEditingController();
  final _carGearController = TextEditingController();
  final _carEnginePowerController = TextEditingController();
  Map<String, dynamic>? carInfo;

  void getCarInfo() {
    print(carsData);
    if (carsData != null) {
      for (var car in carsData!) {
        if (car['id'].toString() == widget.carId) {
          carInfo = car;
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.update) {
      getCarInfo();
      if (carInfo != null) {
        _carBrandController.text = carInfo?['brand'];
        _carPlateController.text = carInfo?['plate_number'];
        _carSeriesController.text = carInfo?['series'];
        _carModelController.text = carInfo?['model'];
        _carYearController.text = carInfo?['year'];
        _carFuelController.text = carInfo?['fuel'];
        _carGearController.text = carInfo?['gear'];
        _carEnginePowerController.text = carInfo?['engine_power'];
      }
    }
  }

  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(widget.update
              ? 'Car details updated successfully!'
              : 'Car added successfully!'),
          actions: <Widget>[
            CustomButton(
              btnText: 'OK',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showFailureAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failure'),
          content: Text(widget.update
              ? 'Failed to update car details. Please try again.'
              : 'Failed to add car. Please try again.'),
          actions: <Widget>[
            CustomButton(
              btnText: 'OK',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final btnText = widget.update ? 'saveChanges'.tr : 'save'.tr;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 80, left: 35, right: 35),
          child: Column(
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MainColors.mainColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Add save functionality here
                              print("save updates btn pressed in client");
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CustomTextFiled(
                controller: _carBrandController,
                hintText: 'enterCarBrand'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carPlateController,
                hintText: 'enterPlateNumber'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carSeriesController,
                hintText: 'enterCarSeries'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carModelController,
                textInputType: TextInputType.text,
                obscureText: false,
                hintText: 'enterCarModel'.tr,
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carYearController,
                textInputType: TextInputType.number,
                obscureText: false,
                hintText: 'enterCarYear'.tr,
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carFuelController,
                textInputType: TextInputType.text,
                obscureText: false,
                hintText: 'enterCarFuel'.tr,
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carGearController,
                textInputType: TextInputType.text,
                obscureText: false,
                hintText: 'enterCarGear'.tr,
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carEnginePowerController,
                textInputType: TextInputType.number,
                obscureText: false,
                hintText: 'enterCarEnginePower'.tr,
              ),
              const SizedBox(height: 25.0),
              CustomButton(
                btnText: btnText,
                onTap: _handleSaveButtonPressed,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Made with ♥ by Carvice team",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSaveButtonPressed() async {
    if (widget.update) {
      bool updatedSuccessfully = await AccountManager().updateCar({
        "car_id": widget.carId.toString(),
        "brand": _carBrandController.text,
        "plate_number": _carPlateController.text,
        "series": _carSeriesController.text,
        "model": _carModelController.text,
        "year": _carYearController.text,
        "gear": _carGearController.text,
        "fuel": _carFuelController.text,
        "engine_power": _carEnginePowerController.text,
      });

      if (updatedSuccessfully) {
        _showSuccessAlert();
      } else {
        _showFailureAlert();
      }
    } else {
      bool addedSuccessfully = await AccountManager().addCar({
        "owner": token!['id'].toString(),
        "brand": _carBrandController.text,
        "plate_number": _carPlateController.text,
        "series": _carSeriesController.text,
        "model": _carModelController.text,
        "year": _carYearController.text,
        "gear": _carGearController.text,
        "fuel": _carFuelController.text,
        "engine_power": _carEnginePowerController.text,
      });

      if (addedSuccessfully) {
        _showSuccessAlert();
      } else {
        _showFailureAlert();
      }
    }
  }
}
