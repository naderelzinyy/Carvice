import 'dart:async';

import 'package:carvice_frontend/widgets/map_widget/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/main.colors.dart';

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
  List<LatLng> polylineCords = [];

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

    setState(() {
      currentPosition = position;
    });
  }

  void getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach((PointLatLng pointLatLng) => polylineCords
          .add(LatLng(pointLatLng.latitude, pointLatLng.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolylinePoints();
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
            polylines: {
              Polyline(
                polylineId: const PolylineId("route"),
                points: polylineCords,
                color: primaryColor,
                width: 5,
              ),
            },
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
          if (widget.isClient)
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
                      print("Request Mechanic Button Pressed");
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
        ],
      ),
    );
  }
}
