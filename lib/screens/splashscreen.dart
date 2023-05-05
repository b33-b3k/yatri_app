import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yatri_app/screens/auth/users/homepage.dart';
import 'package:yatri_app/screens/auth/users/login.dart';
import 'package:yatri_app/screens/maps/mapApp.dart';
import 'package:yatri_app/screens/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _animationController.forward();

    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
          //edit garna baki
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SlideTransition(
              position: _animation,
              child: Image.asset(
                '../../lib/assets/images/bus.png',
                scale: 0.5,
                height: 100,
              ),
            ),
          ),
          //fade transition for a text
          FadeTransition(
            opacity: _animationController,
            child: const Text(
              'Ride with us',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: AutofillHints.newUsername,
                  fontWeight: FontWeight.w200,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
