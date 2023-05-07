import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addDriverDetails(
  String firstName,
  String email,
  String phoneNumber,
  String busColor,
  String busCompany,
) async {
  await FirebaseFirestore.instance
      .collection('Drivers')
      .doc(email)
      .set({
        'First Name': firstName,
        'Email': email,
        'Bus Company': busCompany,
        'Bus Color': busColor,
        'Phone Number': phoneNumber,
      })
      .then((value) => print('User Added'))
      .catchError((error) => print('Failed to add user: $error'));
}

// define class to store name and phone number
class Driver {
  static var counter = 1;
  int? BusCapacity;
  String? BusColor;

  String? BusCompany;
  String? BusNumber;
  String? FirstName;
  String? LastName;
  String? PhoneNumber;
  String? Email;
  String? latitude;
  String? longitude;
  String? routes;

  Driver(
    this.BusCapacity,
    this.BusColor,
    this.BusCompany,
    this.BusNumber,
    this.FirstName,
    this.LastName,
    this.PhoneNumber,
    this.Email,
    this.latitude,
    this.longitude,
    this.routes,
  );
}

// define list to store all drivers

List<Driver> driversList = [];

// retrieve data from Firestore and store in list of classes
Future<int> getDrivers() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("Drivers").get();
  for (var doc in querySnapshot.docs) {
    String firstName = doc.get("First Name").toString();
    String lastName = doc.get("Last Name").toString();
    String email = doc.get("Email").toString();
    String phoneNumber = doc.get("Phone Number").toString();
    String busColor = doc.get("Bus Color").toString();
    String busCompany = doc.get("Bus Company").toString();
    String busNumber = doc.get("Bus Number").toString();
    String latitude = doc.get("Latitude").toString();
    String longitude = doc.get("Longitude").toString();
    String routes = doc.get("Routes").toString();
    int busCapacity = int.parse(doc.get("Bus Capacity").toString());
    Driver driver = Driver(
      busCapacity,
      busColor,
      busCompany,
      busNumber,
      firstName,
      lastName,
      phoneNumber,
      email,
      latitude,
      longitude,
      routes,
    );
    driversList.add(driver);
    print(driversList);
  }
  return 1;
}

// final firestoreInstance = FirebaseFirestore.instance;

