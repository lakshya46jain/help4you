// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/secondary_screens/professional_listing_screen/body.dart';
import 'package:help4you/secondary_screens/professional_listing_screen/app_bar.dart';

class ProfessionalListingScreen extends StatelessWidget {
  final String occupation;

  ProfessionalListingScreen({
    @required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: ProfessionalListingAppBar(
            occupation: occupation,
          ),
        ),
        body: Body(
          occupation: occupation,
        ),
      ),
    );
  }
}
