// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/constants/loading.dart';
import 'package:help4you/screens/professionals_screen/components/professional_toggle.dart';

class ListingScreenBody extends StatelessWidget {
  final String occupation;

  ListingScreenBody({
    @required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .where("Account Type", isEqualTo: "Professional")
          .where("Occupation", isEqualTo: occupation)
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
                return ProfessionalsToggle(
                  professionalUID: documentSnapshot["User UID"],
                  profilePicture: documentSnapshot["Profile Picture"],
                  fullName: documentSnapshot["Full Name"],
                  occupation: documentSnapshot["Occupation"],
                  phoneNumber: documentSnapshot["Phone Number"],
                  rating: 0,
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
