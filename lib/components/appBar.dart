import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:yatri_app/screens/auth/users/profile.dart';

AppBar ApppBar(BuildContext context, var onPressed) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: IconButton(
        icon: const Icon(
          FeatherIcons.arrowLeftCircle,
          color: Colors.black,
          size: 40,
        ),
        onPressed: onPressed,
      ),
    ),

    //add a user section at the last of the appbar
    actions: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
        child: IconButton(
          icon: const Icon(
            FeatherIcons.user,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
      ),
    ],
  );
}
