import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:latlong2/latlong.dart';
import 'package:yatri_app/components/textfield.dart';
import 'package:yatri_app/screens/auth/homepage.dart';
import 'package:yatri_app/screens/auth/login.dart';

import '../../components/appBar.dart';
import '../../main.dart';

final user = FirebaseAuth.instance.currentUser;

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //verify with email firebase
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              FeatherIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: const Text(
                  "Verify your email",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )),
            //image inside a circle
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: const CircleAvatar(
                radius: 150,
                backgroundImage:
                    AssetImage('../../lib/assets/images/verify.png'),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: const Text(
                  '''We have sent you an email with a link to verify your account.''',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              child: TextButton(
                onPressed: () async {
                  //resend verification email??

                  if (user?.emailVerified == true) {
                    //if email is verified then go to login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    //if email is not verified then show error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please verify your email'),
                      ),
                    );
                  }
                },
                child: const Text(
                  //resend the veification link??

                  "Verify ",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ));
  }
}
