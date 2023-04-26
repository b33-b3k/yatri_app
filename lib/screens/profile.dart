import 'package:flutter/material.dart';
import 'package:yatri_app/components/appBar.dart';
import 'package:yatri_app/main.dart';
import 'package:yatri_app/screens/auth/forgotpass.dart';
import 'package:yatri_app/screens/newpassword.dart';
import 'auth/login.dart';

class ProfileScreen extends StatelessWidget {
  static final String path = "lib/screens/profile_screen.dart";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
//make a back button to go back to the screen
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(
                            'https://instagram.fktm16-1.fna.fbcdn.net/v/t51.2885-15/250685273_4642429349174040_194915824605885135_n.jpg?stp=dst-jpg_e35_p1080x1080&_nc_ht=instagram.fktm16-1.fna.fbcdn.net&_nc_cat=100&_nc_ohc=Byldtqae1mUAX-kUgbD&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=MjY5NTk4MTUwMTc0NzcxNTE0Mg%3D%3D.2-ccb7-5&oh=00_AfBRQRbJO_NY36_Y0xEhqcisUabKNVtruRpfLayVG2tnOA&oe=6434DD63&_nc_sid=30a2ef'),
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bibek Adhikari',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: AutofillHints.name,
                              ),
                            ),
                            Text(
                              //take an email from emailcontroller
                              '$emailtext',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Personal Information'),
                trailing: Icon(Icons.arrow_forward_ios),

                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => PersonalInfo(),
                //     ),
                //   );
                // }
              ),
              ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Change Password'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPassword(),
                      ),
                    );
                  }),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                leading: Icon(Icons.help),
                title: Text('Help'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              TextButton(
                onPressed: () {
                  //firebase logout
                  auth.signOut();

                  Navigator.popAndPushNamed(context, '/login');
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
