// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/professionals_screen/components/listing_body.dart';

class ProfessionalListingScreen extends StatelessWidget {
  final String occupation;

  ProfessionalListingScreen({
    @required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: SignatureButton(type: "Back Button"),
        title: Text(
          occupation,
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListingScreenBody(
        occupation: occupation,
      ),
    );
  }
}
