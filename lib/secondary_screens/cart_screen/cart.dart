// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/secondary_screens/cart_screen/body.dart';
import 'package:help4you/secondary_screens/cart_screen/app_bar.dart';
import 'package:help4you/secondary_screens/cart_screen/bottom_navigation_bar.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / (1792 / 100),
        ),
        child: CartAppBar(),
      ),
      body: Body(),
      bottomNavigationBar: CartNavBar(),
    );
  }
}
