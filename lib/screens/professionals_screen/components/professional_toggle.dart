// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:animations/animations.dart';
// File Imports
import 'package:help4you/screens/professionals_screen/details_screen.dart';
import 'package:help4you/screens/professionals_screen/components/professional_card.dart';

class ProfessionalsToggle extends StatelessWidget {
  final String professionalUID;
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;
  final double rating;

  const ProfessionalsToggle({
    Key key,
    @required this.professionalUID,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
    @required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      clipBehavior: Clip.none,
      transitionDuration: const Duration(milliseconds: 750),
      openElevation: 0.0,
      closedElevation: 0.0,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (context, action) {
        return ProfessionalCard(
          uid: professionalUID,
          profilePicture: profilePicture,
          fullName: fullName,
          occupation: occupation,
          rating: rating,
        );
      },
      openBuilder: (context, action) {
        return DetailsScreen(
          professionalUID: professionalUID,
          profilePicture: profilePicture,
          fullName: fullName,
          occupation: occupation,
          phoneNumber: phoneNumber,
        );
      },
    );
  }
}
