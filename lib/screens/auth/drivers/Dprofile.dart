import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yatri_app/components/appBar.dart';
import 'package:yatri_app/components/button.dart';
import 'package:yatri_app/components/textfield.dart';
import 'package:yatri_app/databasefunctions.dart';
import 'package:yatri_app/main.dart';
import 'package:yatri_app/screens/auth/users/forgotpass.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../../../components/dropdown.dart';
import '../../../components/photoUploader.dart';

FirebaseStorage storage = FirebaseStorage.instance;

// //access first name from database
// String? firstName = FirebaseFirestore.instance
//     .collection('Users')
//     .doc()
//     .get()
//     .then((doc) => doc.get('firstName')) as String?;

class DProfileScreen extends StatefulWidget {
  static final String path = "lib/screens/profile_screen.dart";

  @override
  State<DProfileScreen> createState() => _DProfileScreenState();
}

class _DProfileScreenState extends State<DProfileScreen> {
  String? uploadedPhotoUrl;
  void get_photo() async {
    var uploadedPhotoUrl = await FirebaseFirestore.instance
        .collection('Users')
        .doc()
        .get()
        .then((doc) => doc.get('photoUrl'));
    setState(() {
      uploadedPhotoUrl = uploadedPhotoUrl;
    });
  }

  final PhotoUploader _photoUploader = PhotoUploader();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_photo();
  }

  void _capturePhotoAndUpload() async {
    final fileName = await _photoUploader.capturePhotoAndUploadToFirestore();
    if (fileName != null) {
      final url = await _photoUploader.getPhotoUrl(fileName);
      setState(() {
        uploadedPhotoUrl = url.toString();
      });
    }
  }

  void _selectPhotoAndUpload() async {
    final fileName = await _photoUploader.selectPhotoAndUploadToFirestore();
    if (fileName != null) {
      final url = await _photoUploader.getPhotoUrl(fileName);
      setState(() {
        uploadedPhotoUrl = url.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
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
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                uploadedPhotoUrl ??
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _selectPhotoAndUpload();

                                //push image url to database firebase in reference
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(emailtext)
                                    .set({
                                  'photoUrl': uploadedPhotoUrl,
                                });
                                //snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Photo Updated'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$userName",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: AutofillHints.name,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ListTile(
                  //padding

                  leading: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  title: const Text('Personal Information'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInfoPage(),
                      ),
                    );
                  }),

              //sized box
              const SizedBox(
                height: 10,
              ),
              ListTile(
                  leading: const Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  title: const Text('Change Password'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    );
                  }),

              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text('Location'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),

              const ListTile(
                leading: Icon(Icons.settings, color: Colors.blue),
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(Icons.help, color: Colors.blue),
                title: Text('Help'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              const ListTile(
                leading: Icon(Icons.info, color: Colors.blue),
                title: Text('About'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  //firebase logout
                  auth.signOut();

                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: const Text(
                    'Log out',
                    //red box
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController busNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userNameController.text = '$userName';
    emailController.text = '$emailtext';

    // getDrivers();
    // busNameController.text = driversList[0].BusNumber!;
    // userNameController.text = driversList[0].FirstName!;
    // emailController.text = driversList[0].Email!;
    // phoneController.text = driversList[0].PhoneNumber!;
    // busColorController.text = driversList[0].BusColor!;
    // busNumberController.text = driversList[0].BusNumber!;
    // busCompanyController.text = driversList[0].BusCompany!;
    // busCapacity.text = driversList[0].BusCapacity! as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Driver",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 16),
              Stack(
                  alignment: Alignment.bottomRight,

                  //stack

                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ]),
              const SizedBox(height: 16),
              Text(emailController.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 16),
              textfield(
                Controller: userNameController,
                hinttext: "First Name",
                labeltext: 'First Name',
              ),
              textfield(
                Controller: phoneController,
                hinttext: "Phone Number",
                labeltext: "Phone",
              ),
              textfield(
                Controller: busNameController,
                hinttext: "Bus name",
                labeltext: 'Bus name',
              ),
              textfield(
                Controller: busCompanyController,
                hinttext: "Bus Company",
                labeltext: "Bus Company",
              ),
              textfield(
                Controller: busColorController,
                hinttext: "Bus Color",
                labeltext: "Bus Color",
              ),
              textfield(
                Controller: busNumberController,
                hinttext: "Bus Number",
                labeltext: "Bus Number",
              ),
              textfield(
                Controller: busCapacity,
                hinttext: "Bus Capacity",
                labeltext: "Bus Capacity",
              ),
              const SizedBox(height: 16),
              RouteDropdown(
                  labelText: 'Route',
                  hintText: 'Select a route',
                  routes: ['Route 1', 'Route 2', 'Route 3', 'Route 4'],
                  onValueChanged: (String value) {
                    setState(() {
                      var _selectedRoute = value;
                    });
                  }),
              const SizedBox(height: 16),
              RoundedButton(
                  text: "    Save    ",
                  color: Colors.blue,
                  onPressed: () async {
                    await updateUserData(
                      userNameController.text,
                      phoneController.text,
                      busColorController.text,
                      busCompanyController.text,
                      busNameController.text,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> updateUserData(
  String firstName,
  String phoneNumber,
  String busColor,
  String busCompany,
  String busName,
) async {
  await FirebaseFirestore.instance
      .collection('Drivers')
      .doc('bibek')
      .set({
        'First Name': firstName,
        'Bus Company': busCompany,
        'Bus Color': busColor,
        'Phone Number': phoneNumber,
        'Bus Name': busName,
      })
      .then((value) => print('User Added'))
      .catchError((error) => print('Failed to add user: $error'));
}
