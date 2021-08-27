// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/constants/search_bar.dart';
import 'package:help4you/models/service_category_model.dart';
import 'package:help4you/screens/categories_screen/components/occupation_banner.dart';

class CategoriesBody extends StatelessWidget {
  final TextEditingController searchController;
  final Help4YouUser user;

  CategoriesBody({
    @required this.searchController,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.0,
        ),
        SearchBar(
          width: MediaQuery.of(context).size.width,
          hintText: "Search categories...",
          controller: searchController,
        ),
        SizedBox(
          height: 15.0,
        ),
        Expanded(
          child: StreamBuilder(
            stream: DatabaseService(uid: user.uid).serviceCategoryData,
            builder: (context, snapshot) {
              List<ServiceCategory> servicesCategory = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: servicesCategory.length,
                  itemBuilder: (context, index) {
                    return OccupationBanner(
                      buttonBanner: servicesCategory[index].buttonBanner,
                      occupation: servicesCategory[index].occupation,
                    );
                  },
                );
              } else {
                return DoubleBounceLoading();
              }
            },
          ),
        ),
      ],
    );
  }
}
