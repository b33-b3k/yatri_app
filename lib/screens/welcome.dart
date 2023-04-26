import 'package:flutter/material.dart';
import 'package:yatri_app/main.dart';
import 'package:yatri_app/main.dart';
import 'package:yatri_app/screens/auth/register.dart';
import 'auth/login.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

// main app
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Welcome to ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                )),
            Text(
              "Sajha Yatayat",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text("Please sign in to continue"),
            Center(
              child: Image(
                image: AssetImage('../../lib/assets/images/busstop.jpg',
                    package: 'yatri_app'),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //make round

                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text("Login"),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: Text("Register"),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
