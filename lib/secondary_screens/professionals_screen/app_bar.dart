// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/secondary_screens/reviews_screen.dart/reviews_screen.dart';

class ProfessionalDetailAppBar extends StatelessWidget {
  final int rating;
  final String professionalUID;

  ProfessionalDetailAppBar({
    @required this.rating,
    @required this.professionalUID,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                FluentIcons.dismiss_24_filled,
                size: 25.0,
                color: Color(0xFFFEA700),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewsScreen(
                        professionalUID: professionalUID,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 0.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Color(0xFFDADADA),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FluentIcons.star_20_filled,
                        color: Color(0xFFFEA700),
                      ),
                      SizedBox(
                        width: 7.5,
                      ),
                      Text(
                        "$rating",
                        style: TextStyle(
                          height: 1.75,
                          color: Color(0xFF1C3857),
                          fontSize: 25.0,
                          fontFamily: "BalooPaaji",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
