// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/back_button.dart';

class CartAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: CustomBackButton(),
      title: Text(
        "My Cart",
        style: TextStyle(
          fontSize: 25.0,
          color: Color(0xFF1C3857),
          fontFamily: "BalooPaaji",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}