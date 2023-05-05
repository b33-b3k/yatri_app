import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';

busInfo(var context, String companyName, String busNum, double latitude,
    double longitude) async {
  List<loc.Placemark> palceMarks =
      await loc.placemarkFromCoordinates(latitude, longitude);
  String? locationName = palceMarks[0].subLocality;
  print(locationName);
  print(latitude);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.only(left: 20),
            title: Row(
              children: [
                Text(
                  "Saha Yatri",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'mainFont',
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.bus_alert),
                )
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bus Information",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Company: $companyName"),
                SizedBox(
                  height: 5,
                ),
                Text("Bus Number: $busNum"),
                SizedBox(
                  height: 5,
                ),
                Text("Current Location: $locationName"),
              ],
            ));
      });
}
