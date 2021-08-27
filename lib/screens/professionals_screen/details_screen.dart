// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/screens/reviews_screen.dart/reviews_screen.dart';
import 'package:help4you/screens/professionals_screen/components/details_body.dart';

class DetailsScreen extends StatelessWidget {
  final String professionalUID;
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;
  final int rating;

  DetailsScreen({
    @required this.professionalUID,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
    @required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            FluentIcons.dismiss_24_filled,
            size: 25.0,
            color: Color(0xFFFEA700),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewsScreen(
                      professionalUID: professionalUID,
                    ),
                  ),
                );
              },
              child: FractionallySizedBox(
                heightFactor: 0.75,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 0.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        color: Color(0xFFDADADA),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FluentIcons.star_20_filled,
                        color: Color(0xFFFEA700),
                      ),
                      SizedBox(
                        width: 7.5,
                      ),
                      Text(
                        "$rating",
                        style: TextStyle(
                          height: 1.75,
                          color: Color(0xFF1C3857),
                          fontSize: 25.0,
                          fontFamily: "BalooPaaji",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: DetailsScreenBody(
        profilePicture: profilePicture,
        fullName: fullName,
        occupation: occupation,
        phoneNumber: phoneNumber,
        professionalUID: professionalUID,
      ),
    );
  }
}
