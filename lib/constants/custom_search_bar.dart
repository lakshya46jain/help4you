// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class SearchBar extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  final String hintText;

  SearchBar({
    @required this.width,
    this.controller,
    @required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        width: width,
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Colors.grey[400],
          ),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 20.0,
            ),
            suffixIcon: Icon(
              FluentIcons.search_24_filled,
              color: Colors.grey,
              size: 25.0,
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
