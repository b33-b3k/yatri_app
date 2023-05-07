import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yatri_app/components/photoUploader.dart';
import 'package:yatri_app/components/tripHistory.dart';
import 'package:yatri_app/screens/auth/drivers/Dprofile.dart';
import 'package:yatri_app/screens/auth/drivers/Dregister.dart';
import 'package:yatri_app/screens/auth/users/homepage.dart';
import 'package:yatri_app/screens/auth/users/login.dart';
import 'package:yatri_app/screens/maps/mymap.dart';
import 'package:yatri_app/screens/auth/users/profile.dart';
import 'package:yatri_app/screens/auth/users/register.dart';
import 'package:yatri_app/screens/splashscreen.dart';
import 'package:yatri_app/screens/welcome.dart';
import '/components/appBar.dart';
import 'firebase_options.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'screens/maps/mapApp.dart';
import '/components/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'screens/auth/users/login.dart';
import 'screens/auth/users/forgotpass.dart';
import '/components/googleSignIn.dart';

final auth = FirebaseAuth.instance;
final user = auth.currentUser;
UserCredential? credential;

//set display name
var displayName = user?.displayName;

// final String? uid = user?.uid;

final userName = user?.displayName;

final emailtext = user?.email;
var emailController = TextEditingController();
var passwordController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController busCompanyController = TextEditingController();
final TextEditingController busColorController = TextEditingController();
final TextEditingController busNumberController = TextEditingController();
final TextEditingController busCapacity = TextEditingController();

var userNameController = TextEditingController();
var confirmPassController = TextEditingController();
final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

//widget get landing page
Widget getLandingPage() {
  if (auth.currentUser != null) {
    return const HomePage();
  } else {
    return const WelcomePage();
  }
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
    home: HomePage(),
    routes: {
      '/mapApp': (context) => MapApp(),
      '/forgotPass': (context) => ForgotPassword(),
      '/signUp': (context) => const SignUp(),
      '/login': (context) => const LoginPage(),
      '/welcome': (context) => const WelcomePage(),
      '/profile': (context) => ProfileScreen(),
      '/tripHistory': (context) => const TripHistory(),
      '/home': (context) => const HomePage(),
      '/splash': (context) => const SplashScreen(),
      '/dsignUp': (context) => const DSignUp(),
      '/dprofile': (context) => DProfileScreen(),

      //verify null
    },
    debugShowCheckedModeBanner: false,
  ));
}

//email
