import 'dart:convert';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import '../../../widgets/text_field.dart';

class City {
  final String name;
  final List<County> counties;

  City({required this.name, required this.counties});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      counties: List<County>.from(json['counties'].map((x) => County.fromJson(x))),
    );
  }
}

class County {
  final String name;
  final List<String> districts;

  County({required this.name, required this.districts});

  factory County.fromJson(Map<String, dynamic> json) {
    return County(
      name: json['name'],
      districts: List<String>.from(json['districts']),
    );
  }
}

class CustomAddressWidget extends StatefulWidget {
  final bool update;

  const CustomAddressWidget({Key? key, required this.update}) : super(key: key);

  @override
  _CustomAddressWidgetState createState() => _CustomAddressWidgetState();
}

class _CustomAddressWidgetState extends State<CustomAddressWidget> {
  List<City> cities = [];
  City? selectedCity;
  County? selectedCounty;
  String? selectedDistrict;
  Map<String, dynamic> selectedData = {};

  bool isCitySelected = false;
  bool isCountySelected = false;
  bool areTextFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    fetchCities();
    selectedData = {
      'city': null,
      'county': null,
      'district': null,
      'streetName': '',
      'streetNumber': '',
      'apartmentNo': '',
    };
  }

  Future<void> fetchCities() async {
    final String jsonData =
    await rootBundle.loadString('assets/address_data/address_data_tr.json');
    final Map<String, dynamic> data = jsonDecode(jsonData);

    final List<dynamic> citiesJson = data['cities'];

    final List<City> fetchedCities =
    citiesJson.map((json) => City.fromJson(json)).toList();

    setState(() {
      cities = fetchedCities;
      isCitySelected = cities.isNotEmpty; // Update isCitySelected state
      if (widget.update) {
        // Set initial values when updating
        // You can modify the initial values as needed
        selectedCity = cities.firstWhere((city) => city.name == 'Istanbul');
        selectedCounty = selectedCity?.counties.firstWhere((county) => county.name == 'Avcilar');
        selectedDistrict = selectedCounty?.districts.firstWhere((district) => district == 'Firuzkoy');
        streetNameController.text = 'Blv';
        streetNumberController.text = '34320';
        apartmentNoController.text = '75';
      }
    });
  }

  Future<void> getAddressCoordinates() async {
    // Create the formatted address
    String formattedAddress =
        '${selectedData['streetName']} ${selectedData['streetNumber']}, ${selectedData['district']}, ${selectedData['county']}, ${selectedData['city']}';

    try {
      // Retrieve the coordinates
      List<Location> locations =
      await geocoding.locationFromAddress(formattedAddress);

      if (locations.isNotEmpty) {
        // Extract the first location
        Location location = locations.first;

        // Access the coordinates
        double latitude = location.latitude;
        double longitude = location.longitude;

        selectedData['latitude'] = latitude;
        selectedData['longitude'] = longitude;

        print('Latitude: $latitude');
        print('Longitude: $longitude');
        String address =
        await getAddressFromCoordinates(latitude, longitude);
        print(address);
      } else {
        print('No coordinates found for the address.');
      }
    } catch (e) {
      print('Error: $e');
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

  void saveData() async {
    selectedData['city'] = selectedCity?.name;
    selectedData['county'] = selectedCounty?.name;
    selectedData['district'] = selectedDistrict;
    selectedData['streetName'] = streetNameController.text;
    selectedData['streetNumber'] = streetNumberController.text;
    selectedData['apartmentNo'] = apartmentNoController.text;
    await getAddressCoordinates();
    print(selectedData);
    // Perform any other operations with the selected data here
  }

  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController apartmentNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<City>(
                value: selectedCity,
                hint:  Text('select_city'.tr),
                onChanged: (City? newValue) {
                  setState(() {
                    selectedCity = newValue;
                    selectedCounty = null;
                    selectedDistrict = null;
                    isCountySelected = false; // Reset county selection
                    isCitySelected = newValue != null; // Update city selection
                  });
                },
                items: cities.map<DropdownMenuItem<City>>((City city) {
                  return DropdownMenuItem<City>(
                    value: city,
                    child: Text(city.name),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<County>(
                value: selectedCounty,
                hint: Text('select_county'.tr),
                onChanged:  (County? newValue) {
                    if (newValue != null) {
                    setState(() {
                    selectedCounty = newValue;
                    selectedDistrict = null;
                    isCountySelected = true; // Update county selection
                    }
                    );
                    }
                    },
    items: selectedCity != null
                    ? selectedCity!.counties
                    .map<DropdownMenuItem<County>>((County county) {
                  return DropdownMenuItem<County>(
                    value: county,
                    child: Text(county.name),
                  );
                }).toList()
                    : null,
                disabledHint: Text(
                  'select_city_first'.tr,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                value: selectedDistrict,
                hint: Text('select_district'.tr),
                onChanged:(String? newValue) {
                  setState(() {
                    selectedDistrict = newValue;
                  });
                },
                items: selectedCounty != null
                    ? selectedCounty!.districts
                    .map<DropdownMenuItem<String>>((String district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList()
                    : null,
                disabledHint: Text(
                  'select_county_first'.tr,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          CustomTextFiled(
            controller: streetNameController,
            hintText: 'Street Name',
            textInputType: TextInputType.text,
            obscureText: false,
            onChanged: (value) {
              setState(() {
                areTextFieldsEmpty = value.isEmpty ||
                    streetNumberController.text.isEmpty ||
                    apartmentNoController.text.isEmpty;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomTextFiled(
            controller: streetNumberController,
            hintText: 'street_number'.tr,
            textInputType: TextInputType.number,
            obscureText: false,
            onChanged: (value) {
              setState(() {
                areTextFieldsEmpty = value.isEmpty ||
                    streetNameController.text.isEmpty ||
                    apartmentNoController.text.isEmpty;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomTextFiled(
            controller: apartmentNoController,
            hintText: 'apartment_no'.tr,
            textInputType: TextInputType.text,
            obscureText: false,
            onChanged: (value) {
              setState(() {
                areTextFieldsEmpty = value.isEmpty ||
                    streetNameController.text.isEmpty ||
                    streetNumberController.text.isEmpty;
              });
            },
          ),
          const SizedBox(height: 16),
          // Save button
          CustomButton(
            onTap: saveData,
            btnText: widget.update ? 'update'.tr : 'save'.tr,
            isDisabled: areTextFieldsEmpty ||
                !isCountySelected ||
                selectedDistrict == null,
          ),
        ],
      ),
    );
  }
}