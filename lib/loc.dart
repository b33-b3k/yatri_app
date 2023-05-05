import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
// import 'package:myMap.dart';

class location extends StatefulWidget {
  const location({super.key});

  @override
  State<location> createState() => _locationState();
}

String? userId;

class _locationState extends State<location> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  var user;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.low);
    location.enableBackgroundMode(enable: true);
    checkDriver();
  }

  String busNo = "m";
  String busName = "m";
  void checkDriver() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email!)
        .snapshots()
        .listen((docSnapshot) {
      var data = docSnapshot.data()!;
      busNo = data['Last Name'];
      busName = data['First Name'];
    });
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
                //checkDriver();
                _listenLocation();
              },
              child: const Text('enable live location')),

          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: const Text('stop live location')),
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('drivers_location')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    userId = snapshot.data!.docs[index].id;
                    return ListTile(
                      leading:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      title:
                          Text(snapshot.data!.docs[index]['number'].toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.directions),
                      //   onPressed: () {
                      //     Navigator.of(context).push(
                      //         MaterialPageRoute(builder: (context) => MyMap()));
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

  // _getLocation() async {
  //   try {
  //     final loc.LocationData _locationResult = await location.getLocation();
  //     await FirebaseFirestore.instance.collection('location').doc('user3').set({
  //       'latitude': _locationResult.latitude,
  //       'longitude': _locationResult.longitude,
  //       'name': 'john'
  //     }, SetOptions(merge: true));
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
          .doc("$busNo")
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': '$busName',
        'number': '$busNo'
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.pause();
    _locationSubscription?.cancel();

    setState(() {
      _locationSubscription = null;
      _locationSubscription?.pause();
      _locationSubscription?.cancel();
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isLimited) {
      print('Limited Premitted');
    }
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
