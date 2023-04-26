import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yatri_app/components/tripHistory.dart';
import 'package:yatri_app/screens/auth/homepage.dart';
import 'package:yatri_app/screens/auth/login.dart';
import 'package:yatri_app/screens/mymap.dart';
import 'package:yatri_app/screens/profile.dart';
import 'package:yatri_app/screens/auth/register.dart';
import 'package:yatri_app/screens/splashscreen.dart';
import 'package:yatri_app/screens/welcome.dart';
import '/components/appBar.dart';
import 'firebase_options.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import '/screens/mapApp.dart';
import '/components/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import '/screens/auth/login.dart';
import '/screens/auth/forgotpass.dart';
import '/screens/auth/verify.dart';
import '/components/googleSignIn.dart';

final auth = FirebaseAuth.instance;
final user = auth.currentUser;

final emailtext = user?.email;
var emailController = TextEditingController();
var passwordController = TextEditingController();
var userNameController = TextEditingController();
var confirmPassController = TextEditingController();
final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});
Widget getLandingPage() {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // show a loading indicator while we wait for the authentication state to initialize
        return const CircularProgressIndicator();
      }
      //welcome page but only for once
      if (snapshot.connectionState == ConnectionState.none) {
        return const WelcomePage();
      }

      if (snapshot.hasData) {
        // user is logged in, display home page

        return HomePage();
      } else {
        // user is not logged in, display sign-up page
        return SignUp();
      }
    },
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    ),
    home: getLandingPage(),
    routes: {
      '/mapApp': (context) => MapApp(),
      '/forgotPass': (context) => const ForgotPass(),
      '/signUp': (context) => const SignUp(),
      '/login': (context) => const LoginPage(),
      '/verify': (context) => const Verify(),
      '/welcome': (context) => const WelcomePage(),
      '/profile': (context) => ProfileScreen(),
      '/tripHistory': (context) => const TripHistory(),
      '/home': (context) => const HomePage(),
      '/splash': (context) => const SplashScreen(),

      //verify null
    },
    debugShowCheckedModeBanner: false,
  ));
}

//email

