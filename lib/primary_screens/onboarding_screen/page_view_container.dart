// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/primary_screens/onboarding_screen/pages.dart';

class PageViewContainer extends StatelessWidget {
  final PageController pageController;
  final Function onPageChanged;

  PageViewContainer({
    @required this.pageController,
    @required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        physics: ClampingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          // Page 1
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_1.svg",
            title: "Connect With Professionals",
            description:
                "Connect with professionals in your locality according to your requirement.",
          ),
          // Page 2
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_2.svg",
            title: "Live Smarter!",
            description:
                "Compare prices of professionals and book them according to your convenience.",
          ),
          // Page 3
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_3.svg",
            title: "New Experiences",
            description:
                "Explain on ground situation to professional through chat for easier diagnosis.",
          ),
          // Page 4
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_4.svg",
            title: "Important Note",
            description:
                "The PROFESSIONALS are not associated with Help4You in any way.",
          ),
        ],
      ),
    );
  }
}
