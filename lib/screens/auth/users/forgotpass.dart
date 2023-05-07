import 'package:flutter/material.dart';
import 'package:yatri_app/components/appBar.dart';
import 'package:yatri_app/components/textfield.dart';
import 'package:yatri_app/main.dart';
import 'package:yatri_app/screens/auth/users/homepage.dart';

TextEditingController forgotemailController = TextEditingController();

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),

      //homepage

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/images/forgotpass.png"),
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Enter your email address and we will send you a link to reset your password',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            textfield(
              Controller: forgotemailController,
              hinttext: 'Email',
              labeltext: null,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black)),
              onPressed: () {
                //reset password
                if (emailController.text == forgotemailController.text &&
                    emailController.text != null &&
                    forgotemailController.text != Null) {
                  auth.sendPasswordResetEmail(
                      email: forgotemailController.text);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Password reset link sent to your email')));
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Back to Login'))
          ],
        ),
      ),
    );
  }
}
