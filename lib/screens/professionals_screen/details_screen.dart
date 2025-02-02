// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
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

  const DetailsScreen({
    Key? key,
    required this.professionalUID,
    required this.profilePicture,
    required this.fullName,
    required this.occupation,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
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
            padding: const EdgeInsets.only(right: 15.0),
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
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 0.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
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
                    const Icon(
                      CupertinoIcons.star_fill,
                      color: Color(0xFFFEA700),
                    ),
                    const SizedBox(width: 7.5),
                    StreamBuilder(
                      stream: DatabaseService(
                        professionalUID: professionalUID,
                      ).reviewsData,
                      builder: (context, AsyncSnapshot snapshot) {
                        double ratingTotal = 0;
                        double rating = 0;
                        List<Reviews>? professionalRatings =
                            snapshot.data as List<Reviews>?;
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          for (Reviews professionalRatings
                              in professionalRatings!) {
                            ratingTotal += professionalRatings.rating!;
                            rating = ratingTotal / snapshot.data.length;
                          }
                        }
                        return Text(
                          rating.toStringAsFixed(1),
                          style: GoogleFonts.balooPaaji2(
                            height: 1.75,
                            color: const Color(0xFF1C3857),
                            fontSize: 25.0,
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
