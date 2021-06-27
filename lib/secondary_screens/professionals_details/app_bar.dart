// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/constants/back_button.dart';

class ProfessionalDetailAppBar extends StatelessWidget {
  final int rating;

  ProfessionalDetailAppBar({
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: CustomBackButton(),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      height: 1.5,
                      color: Colors.black,
                      fontSize: 25.0,
                      fontFamily: "BalooPaaji",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}