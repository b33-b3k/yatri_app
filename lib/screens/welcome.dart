import 'package:flutter/material.dart';
import 'package:yatri_app/main.dart';
import 'package:yatri_app/main.dart';

import 'auth/drivers/Dregister.dart';
import 'auth/users/login.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

// main app
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'auth/users/register.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text("Welcome to ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Saha Yatri",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset("./lib/assets/images/busstop.jpg"),
            ),
            const SizedBox(height: 20),
            const Text(
              "You are ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    //make round

                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                            child: Text(
                          'Passenger',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
                        )),
                      ),
                    )),
                const SizedBox(height: 20),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DSignUp()),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                            child: Text(
                          'Driver',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
                        )),
                      ),
                    )),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
