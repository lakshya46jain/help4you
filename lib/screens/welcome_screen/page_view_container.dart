// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/welcome_screen/pages.dart';

class PageViewContainer extends StatelessWidget {
  final PageController pageController;
  final Function onPageChanged;

  PageViewContainer({
    @required this.pageController,
    @required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / (1792 / 1400),
      child: PageView(
        physics: ClampingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          // Page 1
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_1.svg",
            title: "Connect with people in your local area",
            description:
                "Help4You allows you to contact various workers in your area according to your requirement.",
          ),
          // Page 2
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_2.svg",
            title: "Live your life smarter with us!",
            description:
                "Help4You gives the ability to book professionals for various skills & will be able to compare the prices of all the professionals and choose who you would like to do the job for you.",
          ),
          // Page 3
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_3.svg",
            title: "Get a new experience of getting tasks done",
            description:
                "You will be able to chat with the professional to explain on ground situation of the problem being faced.",
          ),
          // Page 4
          Pages(
            graphicImage: "assets/graphics/Help4You_Illustration_4.svg",
            title: "Note",
            description:
                "The PROFESSIONALS that are seen on the app are not associated with Help4You. Help4You is a platform which allows professionals to get notified about the work & reach you.",
          ),
        ],
      ),
    );
  }
}
