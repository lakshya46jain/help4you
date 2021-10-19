// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/models/reviews_model.dart';
import 'package:help4you/screens/professionals_screen/components/professional_toggle.dart';

class ListingScreenBody extends StatefulWidget {
  final String occupation;

  ListingScreenBody({
    @required this.occupation,
  });

  @override
  State<ListingScreenBody> createState() => _ListingScreenBodyState();
}

class _ListingScreenBodyState extends State<ListingScreenBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .where("Account Type", isEqualTo: "Professional")
          .where("Occupation", isEqualTo: widget.occupation)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length == 0) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: SvgPicture.asset(
                    "assets/graphics/Help4You_Illustration_6.svg",
                  ),
                ),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                return StreamBuilder(
                  stream: DatabaseService(
                    professionalUID: documentSnapshot["User UID"],
                  ).reviewsData,
                  builder: (context, snapshot) {
                    double ratingTotal = 0;
                    double rating = 0;
                    List<Reviews> professionalRatings = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.active) {
                      for (Reviews professionalRatings in professionalRatings) {
                        ratingTotal += professionalRatings.rating;
                        rating = ratingTotal / snapshot.data.length;
                        rating = num.parse(rating.toStringAsFixed(1));
                      }
                    }
                    return ProfessionalsToggle(
                      professionalUID: documentSnapshot["User UID"],
                      profilePicture: documentSnapshot["Profile Picture"],
                      fullName: documentSnapshot["Full Name"],
                      occupation: documentSnapshot["Occupation"],
                      phoneNumber: documentSnapshot["Phone Number"],
                      rating: rating,
                    );
                  },
                );
              },
            );
          }
        } else {
          return DoubleBounceLoading();
        }
      },
    );
  }
}
