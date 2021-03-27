// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/search_bar.dart';

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
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / (1792 / 100),
        ),
        child: SearchBar(
          hintText: "Search Professionals...",
        ),
      ),
    );
  }
}
