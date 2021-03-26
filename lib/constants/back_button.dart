// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// File Imports

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.chevronLeft,
        size: 25.0,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
