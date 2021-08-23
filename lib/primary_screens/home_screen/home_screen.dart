// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/search_bar.dart';
import 'package:help4you/primary_screens/home_screen/header.dart';
import 'package:help4you/primary_screens/home_screen/occupation_list_builder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              HomeHeader(),
              SizedBox(
                height: 5.0,
              ),
              SearchBar(
                hintText: "Search locations...",
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 20.0,
              ),
              OccupationListBuilder(),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.43,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF1C3857),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
