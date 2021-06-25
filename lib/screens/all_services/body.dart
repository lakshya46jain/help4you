// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/service_category_model.dart';
import 'package:help4you/screens/home_screen/occupation_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).serviceCategoryData,
      builder: (context, snapshot) {
        List<ServiceCategory> servicesCategory = snapshot.data;
        return GridView.builder(
          itemCount: servicesCategory.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return OccupationButton(
              imageUrl: servicesCategory[index].imageUrl,
              occupation: servicesCategory[index].occupation,
            );
          },
        );
      },
    );
  }
}
