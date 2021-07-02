// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/secondary_screens/professionals_details_screen/body.dart';
import 'package:help4you/secondary_screens/professionals_details_screen/app_bar.dart';

class ProfessionalsDetailsScreen extends StatelessWidget {
  final String uid;
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;
  final int rating;

  ProfessionalsDetailsScreen({
    @required this.uid,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
    @required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: ProfessionalDetailAppBar(
            rating: rating,
          ),
        ),
        body: Body(
          professionalUid: uid,
          profilePicture: profilePicture,
          fullName: fullName,
          occupation: occupation,
          phoneNumber: phoneNumber,
          rating: rating,
        ),
      ),
    );
  }
}
