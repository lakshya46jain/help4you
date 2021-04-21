// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/professional_listing/body.dart';
import 'package:help4you/screens/professional_listing/app_bar.dart';

class ProfessionalListing extends StatelessWidget {
  final String occupation;

  ProfessionalListing({
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
