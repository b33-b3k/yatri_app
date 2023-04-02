import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OpenMapApiPage extends StatefulWidget {
  @override
  _OpenMapApiPageState createState() => _OpenMapApiPageState();
}

class _OpenMapApiPageState extends State<OpenMapApiPage> {
  // Replace with your OpenMapApi key
  final String apiKey = "YOUR_API_KEY_HERE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OpenMapApi Example"),
      ),
      body: Center(
        child: FloatingActionButton(
          child: Text("Get Current Location"),
          onPressed: () {
            _getCurrentLocation();
          },
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    // Make HTTP request to OpenMapApi endpoint
    final response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?q=London&appid=$apiKey"
            as Uri);

    if (response.statusCode == 200) {
      // Parse response data
      final data = jsonDecode(response.body);

      // Extract current location data
      final name = data['name'];
      final temp = data['main']['temp'];
      final description = data['weather'][0]['description'];

      // Display current location data
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(name),
                content: Text("Temperature: $temp\nDescription: $description"),
              ));
    } else {
      // Handle error
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text("Error"), content: Text(response.body)));
    }
  }
}
