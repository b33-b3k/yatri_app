import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yatri_app/components/appBar.dart';
import 'package:yatri_app/components/textfield.dart';
import 'package:yatri_app/components/googleSignIn.dart';

import '../../../components/transition.dart';
import '../../../main.dart';
import 'homepage.dart';
import 'Dlogin.dart';

class DSignUp extends StatefulWidget {
  const DSignUp({super.key});

  @override
  State<DSignUp> createState() => _DSignUpState();
}

class _DSignUpState extends State<DSignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController _busCompanyController = TextEditingController();
  final TextEditingController _busColorController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _confirmPassController.dispose();
    phoneController.dispose();
    _busCompanyController.dispose();
    _busColorController.dispose();

    super.dispose();
  }

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> registerUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Driver registered successfully")),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == "user-not-found") {
        errorMessage = "No user found for that email";
      } else if (e.code == "wrong-password") {
        errorMessage = "Wrong password provided for that user";
      } else if (e.code == "email-already-exists") {
        errorMessage = "Email already exists";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("errorMessage")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //center

              Container(
                //image

                child: Image.asset('lib/assets/images/registerbus.png',
                    height: 500, width: double.infinity),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Row(
                  children: const [
                    Text(
                      "Register as a Driver",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  children: const [
                    Text(
                      "Create an account to continue",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),

              textfield(Controller: userNameController, hinttext: 'Name'),
              textfield(
                Controller: _emailController,
                hinttext: 'Email',
              ),
              textfield(
                Controller: _passwordController,
                hinttext: 'Password',
                obscureText: true,
              ),
              textfield(
                Controller: confirmPassController,
                hinttext: 'Confirm Password',
                obscureText: true,
              ),
              textfield(Controller: phoneController, hinttext: 'Phone number'),
              textfield(Controller: _busColorController, hinttext: "Bus Color"),
              textfield(
                  Controller: _busCompanyController, hinttext: "Bus Company"),

              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: TextButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    //update display name

                    //set email name last name to the firebase database

                    try {
                      final userCredentials = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                      await user?.updateDisplayName(userNameController.text);
                      String? uid = credential?.user?.uid;
                      await addUserDetails(
                        userNameController.text,
                        _emailController.text,
                        phoneController.text,
                        _busColorController.text,
                        _busCompanyController.text,

                        // _emailController.text,
                        // _busColorController.text,
                        // _busCompanyController.text
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("User registered successfully")),
                      );
                    } on FirebaseAuthException catch (e) {
                      String errorMessage;
                      if (e.code == "user-not-found") {
                        errorMessage = "No user found for that email";
                      } else if (e.code == "wrong-password") {
                        errorMessage = "Wrong password provided for that user";
                      } else if (e.code == "email-already-exists") {
                        errorMessage = "Email already exists";
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.code)),
                      );
                    }
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Container(
                child: Column(
                  children: [
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Text("Or Sign Up with",
                    //     style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w100,
                    //     )),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    // Column(
                    //   children: [
                    //     SignInButton(Buttons.Google,
                    //         text: "Google", onPressed: () {}),
                    //     SizedBox(
                    //       height: 20,
                    //     ),
                    //     //facebook
                    //     // SignInButton(Buttons.Facebook,
                    //     //     text: " Facebook",
                    //     //     padding: EdgeInsets.all(10),

                    //     //     onPressed: () async {
                    //     //       await signInWithFacebook().then((result) {
                    //     //         if (result != null) {
                    //     //           Navigator.push(
                    //     //               context, SlideRightRoute(page: HomePage()));
                    //     //         }
                    //     //       });
                    //     //     },
                    //     //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Row(
                //make a text button to login
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      //open dlogin
                      Navigator.push(
                          context, SlideRightRoute(page: DLoginPage()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//firebase firestore function to update the database for driver

Future<void> addUserDetails(
  String firstName,
  String email,
  String phoneNumber,
  String busColor,
  String busCompany,
) async {
  await FirebaseFirestore.instance
      .collection('Drivers')
      .doc('bibek')
      .set({
        'First Name': firstName,
        'Email': email,
        'Bus Company': busCompany,
        'Bus Color': busColor,
        'Phone Number': phoneNumber,
      })
      .then((value) => print('User Added'))
      .catchError((error) => print('Failed to add user: $error'));
}
