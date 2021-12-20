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

class CategoryBannerStream extends StatelessWidget {
  final Help4YouUser user;
  final TextEditingController searchController;

  CategoryBannerStream({
    @required this.user,
    @required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).serviceCategoryData,
      builder: (context, snapshot) {
        List<ServiceCategory> servicesCategory = snapshot.data;
        return Column(
          children: [
            SizedBox(height: 15.0),
            SearchBar(
              width: MediaQuery.of(context).size.width,
              hintText: "Search categories...",
              controller: searchController,
            ),
            SizedBox(
              height: 15.0,
            ),
            (snapshot.hasData)
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: servicesCategory.length,
                      itemBuilder: (context, index) {
                        return OccupationBanner(
                          buttonBanner: servicesCategory[index].buttonBanner,
                          occupation: servicesCategory[index].occupation,
                        );
                      },
                    ),
                  )
                : DoubleBounceLoading(),
          ],
        );
      },
    );
  }
}
