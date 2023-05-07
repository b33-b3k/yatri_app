import 'package:flutter/material.dart';

class RouteDropdown extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<String> routes;
  final Function(String) onValueChanged;

  RouteDropdown({
    required this.labelText,
    required this.hintText,
    required this.routes,
    required this.onValueChanged,
  });

  @override
  _RouteDropdownState createState() => _RouteDropdownState();
}

class _RouteDropdownState extends State<RouteDropdown> {
  String? _selectedRoute;

  @override
  void initState() {
    // TODO: implement initState
    _selectedRoute = widget.routes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: OutlineInputBorder(),
        ),
        value: _selectedRoute,
        onChanged: (String? newValue) {
          setState(() {
            _selectedRoute = newValue!;
            widget.onValueChanged(newValue);
          });
        },
        items: widget.routes.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
