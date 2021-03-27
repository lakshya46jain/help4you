// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_icons/fluentui_icons.dart';
// File Imports

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        FluentSystemIcons.ic_fluent_arrow_left_filled,
        size: 25.0,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
