import 'package:flutter/material.dart';

import 'package:yatri_app/components/appBar.dart';
import '../../../components/navbar.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Saha-Yatri',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center),
            //make a profile button on the right side
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
            backgroundColor: Colors.transparent,
          ),

          //homepage

          body: BottomBarPage()),
    );
  }
}
