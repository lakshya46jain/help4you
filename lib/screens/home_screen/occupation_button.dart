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
        width: 90.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                height: 65,
                width: 65,
                imageUrl: imageUrl,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              occupation,
              style: TextStyle(
                color: Colors.black,
                height: 1.0,
                fontSize: 15.0,
                fontFamily: "BalooPaaji",
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
