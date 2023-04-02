import 'package:flutter/material.dart';
import 'package:yatri_app/components/appBar.dart';
import 'package:yatri_app/components/tripHistory.dart';

import '../components/tripHistory.dart';

class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  _TripHistoryState createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  final _trips = <Trip>[
    Trip(
      'Kathmandu',
      'Pokhara',
      '2022-04-01',
      '3',
      '1500',
    ),
    Trip(
      'Kathmandu',
      'Pokhara',
      '2022-04-01',
      '3',
      '1500',
    ),
    Trip(
      'Kathmandu',
      'Pokhara',
      '2022-04-01',
      '3',
      '1500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _trips.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.directions_bus),
              title: Text('${_trips[index].from} to ${_trips[index].to}'),
              subtitle: Text('Date: ${_trips[index].date}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Passengers: ${_trips[index].passengers}'),
                  Text('Fare: ${_trips[index].fare}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
