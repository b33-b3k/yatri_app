import 'package:flutter/material.dart';
import 'package:yatri_app/components/appBar.dart';

class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  _TripHistoryState createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  final List<Trip> trips = [
    Trip("Trip 1", "12-01-2022", "01:00 PM", "05:00 PM", "20"),
    Trip("Trip 2", "15-01-2022", "02:00 PM", "06:00 PM", "25"),
    Trip("Trip 3", "18-01-2022", "03:00 PM", "07:00 PM", "30"),
    Trip("Trip 4", "21-01-2022", "04:00 PM", "08:00 PM", "35"),
    Trip("Trip 5", "24-01-2022", "05:00 PM", "09:00 PM", "40"),
    Trip("Trip 6", "27-01-2022", "06:00 PM", "10:00 PM", "45"),
    Trip("Trip 7", "30-01-2022", "07:00 PM", "11:00 PM", "50"),
    Trip("Trip 8", "02-02-2022", "08:00 PM", "12:00 AM", "55"),
    Trip("Trip 9", "05-02-2022", "09:00 PM", "01:00 AM", "60"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApppBar(context, () {
        Navigator.pop(context);
      }),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return Card(
            child: ListTile(
              leading: Icon(
                Icons.directions_bus,
              ),
              title: Text(trip.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: ${trip.date}"),
                  Text("Departure Time: ${trip.departureTime}"),
                  Text("Arrival Time: ${trip.arrivalTime}"),
                  Text("Fare: ${trip.fare}"),
                ],
              ),
              onTap: () {
                // Implement your action when a trip is tapped
              },
            ),
          );
        },
      ),
    );
  }
}

class Trip {
  final String name;
  final String date;
  final String departureTime;
  final String arrivalTime;
  final String fare;

  Trip(
    this.date,
    this.name,
    this.departureTime,
    this.arrivalTime,
    this.fare,
  );

  get from => null;

  get passengers => null;

  get to => null;
}
