import 'package:flutter/material.dart';

import '../../components/appBar.dart';
import '../../components/textfield.dart';
import '/main.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApppBar(context, () {
        Navigator.popAndPushNamed(context, '/login');
      }),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Row(
              children: const [
                Text(
                  "Forgot Password ?",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: const Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey,
                ),
              )),
          textfield(
            hinttext: 'Email',
            Controller: emailController,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: 300,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Send",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
