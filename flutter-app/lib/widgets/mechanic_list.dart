import 'package:carvice_frontend/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import '../services/websocket_connection.dart';
import '../utils/main.colors.dart';

class CustomMechanicList extends StatefulWidget {
  final List<MyMechanicItem> list;
  final String? note;
  final String? carID;

  CustomMechanicList(
      {Key? key, required this.list, required this.note, required this.carID})
      : super(key: key);

  @override
  _CustomMechanicListState createState() => _CustomMechanicListState();
}

class _CustomMechanicListState extends State<CustomMechanicList> {
  late String _carBrand = '';
  late String _carPlate = '';
  late String _carSeries = '';
  late String _carModel = '';
  late String _carYear = '';
  late String _carFuel = '';
  late String _carGear = '';
  late String _carEnginePower = '';
  Map<String, dynamic>? carInfo;

  @override
  void initState() {
    super.initState();
    getCarInfo();
    if (carInfo != null) {
      setCarInfo();
    }
  }

  void getCarInfo() {
    print(carsData);
    if (carsData != null) {
      for (var car in carsData!) {
        if (car['id'].toString() == widget.carID) {
          carInfo = car;
          break;
        }
      }
    }
  }

  void setCarInfo() {
    _carBrand = carInfo?['brand'];
    _carPlate = carInfo?['plate_number'];
    _carSeries = carInfo?['series'];
    _carModel = carInfo?['model'];
    _carYear = carInfo?['year'];
    _carFuel = carInfo?['fuel'];
    _carGear = carInfo?['gear'];
    _carEnginePower = carInfo?['engine_power'];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.list.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey[300],
          height: 1,
          thickness: 1,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routers.getMechanicProfileInClientRoute());
          },
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            leading: SizedBox(
              height: 90,
              width: 60,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            widget.list[index].imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              widget.list[index].name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Row(
              children: [
                RatingBarIndicator(
                  rating: widget.list[index].rate,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: MainColors.mainColor,
                  ),
                  itemCount: 5,
                  itemSize: 16.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () async {
                var id = widget.list[index].id;
                StreamConnection streamConnection = StreamConnection(
                  'ws://127.0.0.1:8000/ws/socket/geospatial-server/$id/',
                  context,
                  "client",
                );
                await streamConnection.connect();
                streamConnection.send({
                  "type": "receive_request",
                  "client_name":
                      "${token!['first_name']}  ${token!['last_name']}",
                  "car_brand": _carBrand,
                  "car_model": "$_carModel$_carSeries $_carYear",
                  "description": widget.note,
                });
              },
              style: ElevatedButton.styleFrom(
                primary: MainColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('request'.tr),
            ),
          ),
        );
      },
    );
  }
}

class MyMechanicItem {
  final String name;
  final int id;
  final String imagePath;
  final double rate;

  MyMechanicItem({
    required this.name,
    required this.id,
    required this.imagePath,
    required this.rate,
  });
}
