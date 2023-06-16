import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import 'button.dart';
import 'package:get/get.dart';

import 'custom_app_footer.dart';

class CarsForm extends StatefulWidget {
  final bool update;
  final String? carId;
  final bool quickAdd;

  const CarsForm({Key? key, required this.update, this.carId, this.quickAdd: false}) : super(key: key);

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
  late bool quickAdd = widget.quickAdd;

  bool _isSaveButtonEnabled = false;
  late String _carBrand = '';
  late String _carPlate = '';
  late String _carSeries = '';
  late String _carModel = '';
  late String _carYear = '';
  late String _carFuel = '';
  late String _carGear= '';
  late String _carEnginePower= '';

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

  void setCarInfo(){
    _carBrand = carInfo?['brand'];
     _carPlate = carInfo?['plate_number'];
    _carSeries = carInfo?['series'];
    _carModel = carInfo?['model'];
     _carYear = carInfo?['year'];
     _carFuel =  carInfo?['fuel'];
     _carGear = carInfo?['gear'];
    _carEnginePower = carInfo?['engine_power'];
  }

  @override
  void initState() {
    super.initState();
    if (widget.update) {
      getCarInfo();
      if (carInfo != null) {
        setCarInfo();
        _carBrandController.text = _carBrand;
        _carPlateController.text =  _carPlate;
        _carSeriesController.text = _carSeries;
        _carModelController.text = _carModel;
        _carYearController.text = _carYear;
        _carFuelController.text = _carFuel;
        _carGearController.text = _carGear;
        _carEnginePowerController.text = _carEnginePower;
      }
    } else {
      _isSaveButtonEnabled = _checkFieldsNotEmpty();
    }
  }

  bool _checkFieldsNotEmpty() {
    return _carBrandController.text.isNotEmpty &&
        _carPlateController.text.isNotEmpty &&
        _carSeriesController.text.isNotEmpty &&
        _carModelController.text.isNotEmpty &&
        _carYearController.text.isNotEmpty &&
        _carFuelController.text.isNotEmpty &&
        _carGearController.text.isNotEmpty &&
        _carEnginePowerController.text.isNotEmpty;
  }

  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('success'.tr),
          content: Text(widget.update
              ? 'success_to_update_car'.tr
              : 'success_to_save_car'.tr),
          actions: <Widget>[
            CustomButton(
              btnText: 'OK',
              onTap: () {
                if(quickAdd){
                  Get.until((route) => route.settings.name == '/home') ;
                }
                else {Get.until((route) => route.settings.name == '/cars_list') ;}

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
          title:  Text('failure'.tr),
          content: Text(widget.update
              ? 'failed_to_update_car'.tr
              : 'failed_to_save_car'.tr),
          actions: <Widget>[
            CustomButton(
              btnText: 'OK',
              onTap: () {
                Get.until((route) => route.settings.name == '/cars_list');
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
          padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomTextFiled(
                controller: _carBrandController,
                hintText: 'enterCarBrand'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
                onChanged: (_) => setState(() => _isSaveButtonEnabled = _checkFieldsNotEmpty() && _carBrandController.text != _carBrand),
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carPlateController,
                hintText: 'enterPlateNumber'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
                onChanged: (_) => setState(() => _isSaveButtonEnabled = _checkFieldsNotEmpty() && _carPlateController.text != _carPlate),
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carSeriesController,
                hintText: 'enterCarSeries'.tr,
                textInputType: TextInputType.text,
                obscureText: false,
                onChanged: (_) => setState(() => _isSaveButtonEnabled = _checkFieldsNotEmpty() && _carSeriesController.text != _carSeries ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carModelController,
                textInputType: TextInputType.text,
                obscureText: false,
                hintText: 'enterCarModel'.tr,
                onChanged: (_) => setState(() => _isSaveButtonEnabled = _checkFieldsNotEmpty() &&  _carModelController.text != _carModel ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carYearController,
                textInputType: TextInputType.number,
                obscureText: false,
                hintText: 'enterCarYear'.tr,
                onChanged: (_) => setState(() => _isSaveButtonEnabled = _checkFieldsNotEmpty() &&  _carYearController.text != _carYear),
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carFuelController,
                textInputType: TextInputType.text,
                obscureText: false,
                hintText: 'enterCarFuel'.tr,
                onChanged: (_) => setState(() => _isSaveButtonEnabled = _checkFieldsNotEmpty() && _carFuelController.text  != _carFuel),
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carGearController,
                textInputType: TextInputType.text,
                obscureText: false,
                hintText: 'enterCarGear'.tr,
                onChanged: (_) => setState(() => _isSaveButtonEnabled =_checkFieldsNotEmpty() && _carGearController.text  != _carGear),
              ),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                controller: _carEnginePowerController,
                textInputType: TextInputType.number,
                obscureText: false,
                hintText: 'enterCarEnginePower'.tr,
                onChanged: (_) => setState(() => _isSaveButtonEnabled = _checkFieldsNotEmpty() && _carEnginePowerController.text  != _carEnginePower),
              ),
              const SizedBox(height: 25.0),
              CustomButton(
                btnText: btnText,
                onTap: _handleSaveButtonPressed,
                isDisabled: !_isSaveButtonEnabled,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomFooterWidget()
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
