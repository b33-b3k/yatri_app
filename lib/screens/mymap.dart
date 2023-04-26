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

class MyMap extends StatefulWidget {
  final String user_id;
  const MyMap(this.user_id, {super.key});
  @override
  _MyMapState createState() => _MyMapState();
}

const String mapBus = "../assets/Photos/map_bus.png";
MapsRoutes route = new MapsRoutes();
String googleapikey = "AIzaSyAwD52k5H4WVu7VM4WKWbFdmaAEGIt2-Tw";
// Set<Polyline> polylines = {};
// LatLng loc1 = LatLng(27.6602292, 85.308027);
// LatLng loc2 = LatLng(27.6599592, 85.3102498);
// LatLng loc3 = LatLng(27.661838, 85.308543);

List<LatLng> points = [
  LatLng(27.6602292, 85.308027),
  LatLng(27.6599592, 85.3102498),
  LatLng(27.661838, 85.308543),
];

getRoute() async {
  await route.drawRoute(points, 'Simple route', Colors.red,
      "AIzaSyAwD52k5H4WVu7VM4WKWbFdmaAEGIt2-Tw");

  //to clear the routes
  //route.routes.clear();
}

PolylinePoints polylinePoints = PolylinePoints();
String googleAPiKey = "AIzaSyAwD52k5H4WVu7VM4WKWbFdmaAEGIt2-Tw";
Map<PolylineId, Polyline> polylines = {};

class _MyMapState extends State<MyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  loc.LocationData currentLocation = loc.LocationData.fromMap({
    "latitude": 27.687643,
    "longitude": 85.338380,
  });

  void getUserLocation() async {
    var location = loc.Location();
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      print("No location");
    }
    await _controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(currentLocation.latitude!, currentLocation.longitude!), 14.47));
  }

  // getDirections() async {
  //   List<LatLng> polylineCoordinates = [];

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     googleAPiKey,
  //     PointLatLng(currentLocation.latitude!, currentLocation.longitude!),
  //     PointLatLng(currentLocation.latitude!, currentLocation.longitude!),
  //     travelMode: TravelMode.driving,
  //   );

  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   } else {
  //     print(result.errorMessage);
  //   }
  //   addPolyLine(polylineCoordinates);
  // }

  // addPolyLine(List<LatLng> polylineCoordinates) {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Colors.red,
  //     points: polylineCoordinates,
  //     width: 100,
  //   );
  //   polylines[id] = polyline;
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    getUserLocation();
    addCustomIcon();
    getRoute();

    //add markers
    setState(() {});
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), mapBus).then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  var latitude;
  var longitude;
  var name;
  var userLatitude;
  var userLongitude;
  List<Marker> markers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                print(currentLocation.latitude!);
              },
              child: Text("Press"))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('drivers_location')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // if (_added) {
          //   mymap(snapshot);
          // }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            snapshot.data!.docs.forEach((QueryDocumentSnapshot document) {
              latitude = document.get('latitude');
              longitude = document.get('longitude');
              String name = document.get('name');
              String num = document.get('number');
              Marker marker = Marker(
                  markerId: MarkerId(name),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(title: name, snippet: num));
              markers.add(marker);
            });
          }
          userLatitude = currentLocation.latitude;
          userLongitude = currentLocation.longitude;
          return GoogleMap(
              mapType: MapType.normal,
              markers: Set<Marker>.of(markers),
              initialCameraPosition: CameraPosition(
                  target: LatLng(userLatitude, userLongitude), zoom: 14.47),
              onMapCreated: (GoogleMapController controller) async {
                setState(
                  () {
                    _controller = controller;
                    _added = true;
                  },
                );
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              polylines: route.routes //polylines
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        //button on left side
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

        onPressed: () async {
          getRoute();
          await route.drawRoute(points, 'Test routes',
              Color.fromRGBO(130, 78, 210, 1.0), googleapikey,
              travelMode: TravelModes.driving);
        },
        child: Icon(
          Icons.line_style_rounded,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              initialCameraPosition: const CameraPosition(
                zoom: 15.0,
                target: LatLng(45.82917150748776, 14.63705454546316),
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
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
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';

// // //google map screen
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:location/location.dart';
// // import 'package:yatri_app/components/appBar.dart';

// // class GoogleMapScreen extends StatefulWidget {
// //   GoogleMapScreen({super.key});

// //   @override
// //   State<GoogleMapScreen> createState() => _GoogleMapScreenState();
// // }

// // //google maps controller initialze
// // GoogleMapController? _controller;

// // @override
// // void dispose() {
// //   _controller?.dispose();

// //   //dispose controller
// // }

// // class _GoogleMapScreenState extends State<GoogleMapScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('not working'),
// //         centerTitle: true,
// //         backgroundColor: Colors.green,
// //       ),
// //       body: GoogleMap(
// //         initialCameraPosition:
// //             CameraPosition(target: LatLng(27.7172, 85.3240), zoom: 12.0),
// //         myLocationEnabled: true,
// //         myLocationButtonEnabled: true,
// //         mapType: MapType.normal,
// //         zoomGesturesEnabled: true,
// //         zoomControlsEnabled: true,
// //         onMapCreated: (GoogleMapController controller) {
// //           _controller = controller;
// //         },
// //       ),
// //     );
// //   }
// // }




// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   GoogleMapController? mapController; //contrller for Google map
//   PolylinePoints polylinePoints = PolylinePoints();

//   String googleAPiKey = "AIzaSyAwD52k5H4WVu7VM4WKWbFdmaAEGIt2-Tw";

//   Set<Marker> markers = Set(); //markers for google map
//   Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

//   LatLng startLocation = LatLng(27.6683619, 85.3101895);
//   LatLng endLocation = LatLng(27.6688312, 85.3077329);

//   @override
//   void initState() {
//     markers.add(Marker(
//       //add start location marker
//       markerId: MarkerId(startLocation.toString()),
//       position: startLocation, //position of marker
//       infoWindow: InfoWindow(
//         //popup info
//         title: 'Starting Point ',
//         snippet: 'Start Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     markers.add(Marker(
//       //add distination location marker
//       markerId: MarkerId(endLocation.toString()),
//       position: endLocation, //position of marker
//       infoWindow: InfoWindow(
//         //popup info
//         title: 'Destination Point ',
//         snippet: 'Destination Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     getDirections(); //fetch direction polylines from Google API

//     super.initState();
//   }

//   getDirections() async {
//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(startLocation.latitude, startLocation.longitude),
//       PointLatLng(endLocation.latitude, endLocation.longitude),
//       travelMode: TravelMode.driving,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.deepPurpleAccent,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         //Map widget from google_maps_flutter package
//         zoomGesturesEnabled: true, //enable Zoom in, out on map
//         initialCameraPosition: CameraPosition(
//           //innital position in map
//           target: startLocation, //initial position
//           zoom: 16.0, //initial zoom level
//         ),
//         markers: markers, //markers to show on map
//         polylines: Set<Polyline>.of(polylines.values), //polylines
//         mapType: MapType.normal, //map type
//         onMapCreated: (controller) {
//           //method called when map is created
//           setState(() {
//             mapController = controller;
//           });
//         },
//       ),
//     );
//   }
// }
