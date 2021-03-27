// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  SearchBar({
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / (1792 / 100),
        decoration: BoxDecoration(
          color: Color(0xFF979797).withOpacity(0.1),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
