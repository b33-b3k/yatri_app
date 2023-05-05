import 'package:flutter/material.dart';

class BusInfoDialog extends StatelessWidget {
  final String busName;
  final String currentLocation;

  final String busnumber;

  BusInfoDialog(
      {required this.busName,
      required this.currentLocation,
      required this.busnumber});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Bus Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Bus Name: $busName",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Text("Bus Number: $busnumber",
                  style: TextStyle(
                    fontSize: 18,
                  )),
              SizedBox(height: 16),
              Text(
                "Current Location: $currentLocation",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
