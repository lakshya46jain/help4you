// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/search_bar.dart';
import 'package:help4you/screens/home_screen/components/header.dart';
import 'package:help4you/screens/home_screen/components/occupation_list_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              const Header(),
              const SizedBox(height: 5.0),
              SearchBar(
                hintText: "Search locations...",
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 20.0),
              const OccupationListBuilder(),
              const SizedBox(height: 20.0),
              Container(
                height: MediaQuery.of(context).size.height * 0.43,
                width: double.infinity,
                decoration: const BoxDecoration(
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
