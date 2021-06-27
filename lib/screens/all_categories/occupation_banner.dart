// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/screens/professional_listing/professional_listing.dart';

class OccupationBanner extends StatelessWidget {
  final String buttonBanner;
  final String occupation;

  OccupationBanner({
    this.buttonBanner,
    this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfessionalListing(
                occupation: occupation,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: buttonBanner,
          ),
        ),
      ),
    );
  }
}
