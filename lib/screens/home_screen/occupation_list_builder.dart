// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/models/service_category_model.dart';
import 'package:help4you/screens/all_services/all_services.dart';
import 'package:help4you/screens/home_screen/occupation_button.dart';

class OccupationListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Services",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontFamily: "BalooPaaji",
                  fontWeight: FontWeight.w900,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllServicesScreen(),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(0, 147, 255, 1.0),
                    fontFamily: "BalooPaaji",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder(
          stream: DatabaseService(uid: user.uid).serviceCategoryData,
          builder: (context, snapshot) {
            List<ServiceCategory> servicesCategory = snapshot.data;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    servicesCategory.length,
                    (index) {
                      return OccupationButton(
                        imageUrl: servicesCategory[index].imageUrl,
                        occupation: servicesCategory[index].occupation,
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
