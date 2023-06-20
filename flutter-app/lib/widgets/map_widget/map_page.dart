import 'dart:async';

import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/widgets/mechanic_list.dart';
import 'package:carvice_frontend/widgets/rating_alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/routes.dart';
import '../../services/websocket_connection.dart';
import '../../utils/main.colors.dart';
import '../../view/general/pages/chat/chat_list_page.dart';
import '../alerts_text_button.dart';
import '../request_stream_widget.dart';
import '../select_car_alert.dart';

class MapTrackingPage extends StatefulWidget {
  final bool isClient;
  const MapTrackingPage(this.isClient, {Key? key}) : super(key: key);

  @override
  State<MapTrackingPage> createState() => MapTrackingPageState();
}

class MapTrackingPageState extends State<MapTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(40.990809, 28.796582);
  static const LatLng destination = LatLng(40.974768, 28.719443);
  Position? currentPosition;

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);

    print("Current position :: $position");
    if (mounted) {
      setState(() {
        currentPosition = position;
      });
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentPosition?.latitude ?? sourceLocation.latitude,
                currentPosition?.longitude ?? sourceLocation.longitude,
              ),
              zoom: 13,
            ),
            markers: {
              const Marker(
                  markerId: MarkerId("source"), position: sourceLocation),
              const Marker(
                  markerId: MarkerId("destination"), position: destination),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          if (widget.isClient & !isSessionStarted)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 70, // set width
                  height: 70, // set height
                  child: FloatingActionButton(
                    onPressed: () {
                      // Here, you can define your logic when the button is pressed
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyAlertDialog(position: currentPosition);
                        },
                      );
                    }, // increase icon size as well
                    backgroundColor: MainColors.mainColor,
                    child: const Icon(
                      Icons.build,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
          if (isSessionStarted)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 70, // set width
                  height: 70, // set height
                  child: FloatingActionButton(
                    onPressed: () {
                      print("Session button pressed.");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomRequestStreamAlertDialog(
                            title: 'Session Options',
                            content: const Text(""),
                            actions: <Widget>[
                              CustomAlertButton(
                                text: 'Start Chatting',
                                onPressed: () async {
                                  if (widget.isClient) {
                                    var username = await AccountManager()
                                        .getMechanicUsername(
                                            {"mechanic_id": mechanicId});
                                    print("333333 $username");
                                    ChatHomePage().startChat(context, username,
                                        "The session started");
                                    // Navigator.of(context).pop();
                                  }
                                },
                              ),
                              if (!widget.isClient)
                                CustomAlertButton(
                                  text: 'End Session',
                                  onPressed: () {
                                    setState(() {
                                      isSessionStarted = false;
                                      isRatingSessionStarted = true;
                                    });
                                    print("4444444 ${token!['id']}");
                                    StreamConnection(
                                      "ws://127.0.0.1:8000/ws/socket/geospatial-server/${token!['id']}/",
                                      context,
                                      "mechanic",
                                    ).send({
                                      "type": "end_session",
                                      "message": "Session ends"
                                    });
                                    Get.offAllNamed(
                                        Routers.getMechanicHomePageRoute());
                                  },
                                ),
                              if (widget.isClient)
                                CustomAlertButton(
                                  text: 'Rate Mechanic',
                                  onPressed: () async {
                                    isSessionStarted = false;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // we need to pass the mechanic id here in order to save it in the database. with the message
                                        return const RatingAlertWidget(
                                            message: 'Rate the mechanic.');
                                      },
                                    );
                                    // Navigator.of(context).pop();
                                  },
                                ),
                            ],
                          );
                        },
                      );

                      // Here, you can define your logic when the button is pressed
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return MyAlertDialog(position: currentPosition);
                      //   },
                      // );
                    }, // increase icon size as well
                    backgroundColor: MainColors.mainColor,
                    child: const Icon(
                      Icons.access_time,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
