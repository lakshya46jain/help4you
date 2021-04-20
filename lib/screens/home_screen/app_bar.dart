// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/screens/cart_screen/cart.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Home",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            FluentIcons.cart_24_regular,
            color: Colors.black,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
