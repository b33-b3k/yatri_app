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
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Welcome to "),
          const Text(
            "Sajha Yatayat",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text("Please sign in to continue"),
          Center(
            child: Image(
              image: const AssetImage('../../lib/assets/images/busstop.jpg',
                  package: 'yatri_app'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               const SizedBox(height: 60),
//               //logo
//               // Image.asset(),
//               Icon(
//                 Icons.directions_bus,
//                 size: 150,
//               ),

//               //Saha Yatri
//               const SizedBox(height: 40),
//               Text(
//                 'Saha Yatri',
//                 style: TextStyle(
//                   fontFamily: 'main',
//                   fontSize: 70,
//                 ),
//               ),

//               //Login button
//               const SizedBox(height: 70),
//               SizedBox(
//                 height: 50,
//                 width: 380,
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       side: BorderSide(
//                           width: 1, color: Color.fromARGB(255, 72, 71, 71)),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10))),
//                   onPressed: () {
//                     print("Pressed Login");
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => LoginPage()));
//                   },
//                   child: Text(
//                     "Login",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),

//               //label: Text("Login")

//               //Register
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 50,
//                 width: 380,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         side: BorderSide(width: 1, color: Colors.black),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () {
//                       print("Pressed Register");

//                       Navigator.pushNamed(context, '/signUp');
//                     },
//                     child: const Text(
//                       "Register",
//                       style: TextStyle(color: Colors.white),
//                     )),
//               ),
//               //Continue as guest
//               const SizedBox(height: 100),
//               InkWell(
//                 onTap: () {},
//                 child: const Text(
//                   "Continue as guest",
//                   style: TextStyle(
//                       decoration: TextDecoration.underline,
//                       color: Color.fromARGB(255, 24, 192, 122),
//                       fontSize: 15),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
