// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/models/service_category_model.dart';
import 'package:help4you/primary_screens/home_screen/occupation_button.dart';
import 'package:help4you/secondary_screens/categories_screen/categories_screen.dart';

class OccupationListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFF1C385A),
                  fontFamily: "BalooPaaji",
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoriesScreen(),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color(0xFFFEA700),
                    fontFamily: "BalooPaaji",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        StreamBuilder(
          stream: DatabaseService(uid: user.uid).serviceCategoryData,
          builder: (context, snapshot) {
            List<ServiceCategory> servicesCategory = snapshot.data;
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    ...List.generate(
                      servicesCategory.length,
                      (index) {
                        return OccupationButton(
                          buttonLogo: servicesCategory[index].buttonLogo,
                          occupation: servicesCategory[index].occupation,
                        );
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                height: 135,
                width: 135,
              );
            }
          },
        ),
      ],
    );
  }
}
