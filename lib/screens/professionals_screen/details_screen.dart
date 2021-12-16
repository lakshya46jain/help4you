// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/reviews_model.dart';
import 'package:help4you/screens/reviews_screen.dart/reviews_screen.dart';
import 'package:help4you/screens/professionals_screen/components/details_body.dart';

class DetailsScreen extends StatelessWidget {
  final String professionalUID;
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;

  DetailsScreen({
    @required this.professionalUID,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
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
            CupertinoIcons.xmark,
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
                        CupertinoIcons.star_fill,
                        color: Color(0xFFFEA700),
                      ),
                      SizedBox(
                        width: 7.5,
                      ),
                      StreamBuilder(
                        stream: DatabaseService(
                          professionalUID: professionalUID,
                        ).reviewsData,
                        builder: (context, snapshot) {
                          double ratingTotal = 0;
                          double rating = 0;
                          List<Reviews> professionalRatings = snapshot.data;
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            for (Reviews professionalRatings
                                in professionalRatings) {
                              ratingTotal += professionalRatings.rating;
                              rating = ratingTotal / snapshot.data.length;
                            }
                          }
                          return Text(
                            "${rating.toStringAsFixed(1)}",
                            style: TextStyle(
                              height: 1.75,
                              color: Color(0xFF1C3857),
                              fontSize: 25.0,
                              fontFamily: "BalooPaaji",
                              fontWeight: FontWeight.w900,
                            ),
                          );
                        },
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
