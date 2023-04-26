import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class MapApp extends StatefulWidget {
  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('live location tracker'),
      ),
      body: Column(
        children: [
          // TextButton(
          //     onPressed: () {
          //       _getLocation();
          //     },
          //     child: Text('add my location')),
          TextButton(
              onPressed: () {
                _listenLocation();
              },
              child: Text('enable live location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: Text('stop live location')),
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('drivers_location')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Bus 204"
                          // snapshot.data!.docs[index]['name'].toString()
                          ),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(Icons.directions),
                      //   onPressed: () {
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) =>
                      //             MyMap(snapshot.data!.docs[index].id)));
                      //   },
                      // ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('bibek').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': 'bibek'
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance
          .collection('drivers_location')
          .doc('Sajha')
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'Bus 1 '
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
      //remove location
      FirebaseFirestore.instance
          .collection('location')
          .doc('bibek')
          .delete(); //delete the current locations
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
