// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class ProfessionalDetailBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          FluentIcons.arrow_left_24_regular,
          size: 25.0,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            FluentIcons.error_circle_24_regular,
            color: Colors.white,
            size: 25.0,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
