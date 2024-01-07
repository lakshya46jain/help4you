// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/screens/professionals_screen/listing_screen.dart';

class OccupationButton extends StatelessWidget {
  final String? buttonLogo;
  final String? occupation;

  const OccupationButton({
    Key? key,
    this.buttonLogo,
    this.occupation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessionalListingScreen(
              occupation: occupation!,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                height: 135.0,
                width: 135.0,
                imageUrl: buttonLogo!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
