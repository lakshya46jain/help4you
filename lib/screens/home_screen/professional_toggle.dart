// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:animations/animations.dart';
// File Imports
import 'package:help4you/screens/home_screen/professional_card.dart';
import 'package:help4you/screens/professionals_details/professionals_details.dart';

class ProfessionalsToggle extends StatelessWidget {
  final String uid;
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;
  final int services;
  final int rating;

  ProfessionalsToggle({
    @required this.uid,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
    @required this.services,
    @required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      clipBehavior: Clip.none,
      transitionDuration: Duration(milliseconds: 750),
      openElevation: 0.0,
      closedElevation: 0.0,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (context, action) {
        return ProfessionalCard(
          profilePicture: profilePicture,
          fullName: fullName,
          occupation: occupation,
          services: services,
          rating: rating,
        );
      },
      openBuilder: (context, action) {
        return ProfessionalsDetails(
          uid: uid,
          profilePicture: profilePicture,
          fullName: fullName,
          occupation: occupation,
          phoneNumber: phoneNumber,
        );
      },
    );
  }
}
