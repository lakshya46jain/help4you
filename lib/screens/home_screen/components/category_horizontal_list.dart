// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/models/service_category_model.dart';
import 'package:help4you/screens/home_screen/components/occupation_button.dart';

class CategoryHorizontalList extends StatelessWidget {
  final Help4YouUser user;

  const CategoryHorizontalList({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).serviceCategoryData,
      builder: (context, snapshot) {
        List<ServiceCategoryLogo> servicesCategory = snapshot.data;
        if (snapshot.hasData) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20.0),
                ...List.generate(
                  servicesCategory.length,
                  (index) {
                    return OccupationButton(
                      buttonLogo: servicesCategory[index].buttonLogo,
                      occupation: servicesCategory[index].occupation,
                    );
                  },
                ),
                const SizedBox(width: 20.0),
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 135,
            width: 135,
          );
        }
      },
    );
  }
}
