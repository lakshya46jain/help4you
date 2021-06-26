// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/screens/professional_listing/professional_listing.dart';

class OccupationButton extends StatelessWidget {
  final String imageUrl;
  final String occupation;

  OccupationButton({
    this.imageUrl,
    this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Container(
        width: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                height: 135,
                width: 135,
                imageUrl: imageUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
