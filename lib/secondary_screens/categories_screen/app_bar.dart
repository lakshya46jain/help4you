// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/back_button.dart';

class CategoriesAppBar extends StatefulWidget {
  final TextEditingController textController;

  CategoriesAppBar({
    this.textController,
  });

  @override
  _CategoriesAppBarState createState() => _CategoriesAppBarState();
}

class _CategoriesAppBarState extends State<CategoriesAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: CustomBackButton(),
      title: Text(
        "Categories",
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
