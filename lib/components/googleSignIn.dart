import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:yatri_app/screens/mapApp.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var name;
var email;
var photo;
var uid;

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  //sign in
  await FirebaseAuth.instance.signInWithCredential(credential);
  //name
  final name = googleUser?.displayName;
  //email
  final email = googleUser?.email;
  //photo
  final photo = googleUser?.photoUrl;
  //uid
  final uid = googleUser?.id;

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class Login extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
              onTap: () async {
                await signInWithGoogle();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MapApp()));
              },
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.google),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Signin with google"),
                  )
                ],
              )),
        ],
      ),
    ));
  }
}
