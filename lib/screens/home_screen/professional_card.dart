// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports

class ProfessionalCard extends StatelessWidget {
  final String fullName;
  final String occupation;
  final int rating;
  final String profilePicture;
  final int services;

  ProfessionalCard({
    @required this.fullName,
    @required this.occupation,
    @required this.rating,
    @required this.profilePicture,
    @required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 35.0),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 20.0,
                    color: Color(0xFFDADADA),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 95.0,
                  top: 15.0,
                  bottom: 15.0,
                  right: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      occupation,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rating",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 2.5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FluentSystemIcons.ic_fluent_star_filled,
                                  color: Colors.yellow[600],
                                  size: 14.0,
                                ),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Text(
                                  "$rating",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Services",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 2.5,
                            ),
                            Text(
                              "$services",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: SizedBox(
              height: 110,
              width: 110,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFFF5F6F9),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 20.0,
                      color: Color(0xFFDADADA),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    imageUrl: profilePicture,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
