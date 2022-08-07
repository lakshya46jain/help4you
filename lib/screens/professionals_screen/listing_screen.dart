// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/professionals_screen/components/listing_body.dart';

class ProfessionalListingScreen extends StatelessWidget {
  final String occupation;

  const ProfessionalListingScreen({
    Key key,
    @required this.occupation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: const SignatureButton(type: "Back Button"),
        title: Text(
          occupation,
          style: GoogleFonts.balooPaaji2(
            fontSize: 25.0,
            color: const Color(0xFF1C3857),
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
