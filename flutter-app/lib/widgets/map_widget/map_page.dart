import 'dart:async';

import 'package:carvice_frontend/widgets/map_widget/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTrackingPage extends StatefulWidget {
  const MapTrackingPage({Key? key}) : super(key: key);

  @override
  State<MapTrackingPage> createState() => MapTrackingPageState();
}

class MapTrackingPageState extends State<MapTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(40.990809, 28.796582);
  static const LatLng destination = LatLng(40.974768, 28.719443);
  LocationData? locationData;
  List<LatLng> polylineCords = [];

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      locationData = location;
    });
  }

  void getPolyLinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
            google_api_key,
            PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
            PointLatLng(destination.latitude, destination.longitude));
    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach((PointLatLng pointLatLng) => polylineCords
          .add(LatLng(pointLatLng.latitude, pointLatLng.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    // getCurrentLocation();
    getPolyLinePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: sourceLocation, zoom: 13),
        polylines: {
          Polyline(
              polylineId: const PolylineId("route"),
              points: polylineCords,
              color: primaryColor,
              width: 5)
        },
        markers: {
          const Marker(markerId: MarkerId("source"), position: sourceLocation),
          const Marker(markerId: MarkerId("destination"), position: destination)
        },
      ),
    );
  }
}
