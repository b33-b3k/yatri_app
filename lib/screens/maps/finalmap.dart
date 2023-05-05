import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'dart:async';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Routes Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapsRoutesExample(title: 'GMR Demo Home'),
    );
  }
}

class MapsRoutesExample extends StatefulWidget {
  MapsRoutesExample({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MapsRoutesExampleState createState() => _MapsRoutesExampleState();
}

class _MapsRoutesExampleState extends State<MapsRoutesExample> {
  Completer<GoogleMapController> _controller = Completer();

  List<LatLng> points = [
    LatLng(45.82917150748776, 14.63705454546316),
    LatLng(45.833828635680355, 14.636544256202207),
    LatLng(45.851254420031296, 14.624331708344428),
    LatLng(45.84794984187217, 14.605434384742317)
  ];

  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  String googleApiKey = 'AIzaSyAwD52k5H4WVu7VM4WKWbFdmaAEGIt2-Tw';
  String totalDistance = 'No route';
  static const LatLng sourceLocation = LatLng(
    45.82917150748776,
    14.63705454546316,
  );
  static const LatLng destLocation = LatLng(
    45.84794984187217,
    14.605434384742317,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: GoogleMap(
              zoomControlsEnabled: false,
              polylines: route.routes,
              initialCameraPosition: CameraPosition(
                zoom: 15.0,
                target: LatLng(45.82917150748776, 14.63705454546316),
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {
                const Marker(
                  markerId: MarkerId('source'),
                  position: sourceLocation,
                ),
                const Marker(
                  markerId: MarkerId('destination'),
                  position: destLocation,
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Align(
                    alignment: Alignment.center,
                    child:
                        Text(totalDistance, style: TextStyle(fontSize: 25.0)),
                  )),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await route.drawRoute(points, 'Test routes',
              Color.fromRGBO(130, 78, 210, 1.0), googleApiKey,
              travelMode: TravelModes.walking);
          setState(() {
            totalDistance =
                distanceCalculator.calculateRouteDistance(points, decimals: 1);
          });
        },
      ),
    );
  }
}
