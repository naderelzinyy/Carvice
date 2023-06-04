import 'package:carvice_frontend/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../utils/main.colors.dart';
import 'button.dart';
import 'package:get/get.dart';

class CarsForm extends StatefulWidget {
  final bool update;

  const CarsForm({Key? key, required this.update}) : super(key: key);

  @override
  _CarsFormState createState() => _CarsFormState();
}

class _CarsFormState extends State<CarsForm> {
  final _carBrandController = TextEditingController();
  final _carSeriesController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carFuelController = TextEditingController();
  final _carGearController = TextEditingController();
  final _carEnginePowerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.update) {
      _carBrandController.text = "bmw";
      _carSeriesController.text = "maryam";
      _carModelController.text = "nader";
      _carYearController.text = "2012";
      _carFuelController.text = "dezil";
      _carGearController.text = "outomatic";
      _carEnginePowerController.text = "1300";
    }
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
                  obscureText: false),
              const SizedBox(height: 16.0),
              CustomTextFiled(
                  controller: _carSeriesController,
                  hintText: 'enterCarSeries'.tr,
                  textInputType: TextInputType.text,
                  obscureText: false),
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
                onTap: (() => {
                      AccountManager().addCar({
                        "owner": token!['id'].toString(),
                        "brand": _carBrandController.text,
                        "series": _carSeriesController.text,
                        "model": _carModelController.text,
                        "year": _carYearController.text,
                        "gear": _carGearController.text,
                        "fuel": _carFuelController.text,
                        "engine_power": _carEnginePowerController.text,
                      })
                    }),
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
          )),
    );
  }
}
