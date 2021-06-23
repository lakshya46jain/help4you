// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/home_screen/header.dart';
import 'package:help4you/constants/custom_search_bar.dart';
import 'package:help4you/screens/home_screen/announcement_page_view.dart';
import 'package:help4you/screens/home_screen/occupation_list_builder.dart';

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
                hintText: "Location",
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 220.0,
                width: double.infinity,
                child: AnnouncementPageView(),
              ),
              OccupationListBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
