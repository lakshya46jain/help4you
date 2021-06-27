// Flutter Imports
import 'package:flutter/material.dart';
import 'package:help4you/constants/custom_search_bar.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/service_category_model.dart';
import 'package:help4you/screens/all_categories/occupation_banner.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          SearchBar(
            width: MediaQuery.of(context).size.width,
            hintText: "Search for categories",
          ),
          SizedBox(
            height: 25.0,
          ),
          StreamBuilder(
            stream: DatabaseService(uid: user.uid).serviceCategoryData,
            builder: (context, snapshot) {
              List<ServiceCategory> servicesCategory = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: servicesCategory.length,
                itemBuilder: (context, index) {
                  return OccupationBanner(
                    buttonBanner: servicesCategory[index].buttonBanner,
                    occupation: servicesCategory[index].occupation,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
