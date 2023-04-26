import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:yatri_app/components/googleSignIn.dart';
import 'package:yatri_app/components/transition.dart';
import 'package:yatri_app/main.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yatri_app/components/appBar.dart';
import 'package:yatri_app/components/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yatri_app/main.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:yatri_app/screens/auth/homepage.dart';
import 'package:yatri_app/screens/auth/register.dart';
import 'package:yatri_app/screens/mapApp.dart';

import '../../components/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigningIn = true;

  @override
  void initState() {
    // TODO: implement initState

    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Image(
                  image: const AssetImage('lib/assets/images/login.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  children: const [
                    Text(
                      "Log in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //image
              textfield(
                hinttext: 'Email',
                Controller: emailController,
              ),
              textfield(
                hinttext: 'Password',
                Controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black),
                child: TextButton(
                  onPressed: () async {
                    final email = emailController.text;
                    final password = passwordController.text;

                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (user != null && !user!.emailVerified) {
                        await user!.sendEmailVerification();
                      }
                      //login
                      if (user!.emailVerified) {
                        Navigator.push(
                            context, SlideRightRoute(page: HomePage()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Logged in successfully")),
                        );
                      } else {
                        Navigator.pushNamed(context, '/verify');
                      }
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
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                //image
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(page: SignUp()));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.blue,
                            textBaseline: TextBaseline.alphabetic),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    children: [
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const Text("Or Login with",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          SignInButton(Buttons.Google, text: "Google",
                              onPressed: () async {
                            setState(() {
                              _isSigningIn = true;
                            });

                            User? user = await Authentication.signInWithGoogle(
                                context: context);

                            setState(() {
                              _isSigningIn = false;
                            });

                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          //facebook
                          SignInButton(Buttons.Facebook,
                              text: " Facebook",
                              padding: const EdgeInsets.all(10),
                              onPressed: () {}
                              // onPressed: () async {
                              //   await signInWithFacebook().then((result) {
                              //     if (result != null) {
                              //       Navigator.push(
                              //           context, SlideRightRoute(page: HomePage()));
                              //     }
                              //   });
                              // },
                              ),
                        ],
                      ),
                    ],
                    //make a google sign button??
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
