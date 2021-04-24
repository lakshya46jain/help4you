// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/all_services/all_services.dart';
import 'package:help4you/screens/home_screen/announcement_page_view.dart';
import 'package:help4you/screens/home_screen/occupation_list_builder.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 220.0,
            width: double.infinity,
            child: AnnouncementPageView(),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Services",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllServicesScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          OccupationListBuilder(),
        ],
      ),
    );
  }
}
