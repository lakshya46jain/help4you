// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/create_review.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/reviews_screen.dart/components/body.dart';

class ReviewsScreen extends StatelessWidget {
  final String professionalUID;

  ReviewsScreen({
    @required this.professionalUID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: SignatureButton(type: "Back Button"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateReviewScreen(
                    uid: professionalUID,
                  ),
                ),
              );
            },
            icon: Icon(
              CupertinoIcons.add,
              size: 25.0,
              color: Color(0xFFFEA700),
            ),
          ),
        ],
      ),
      body: ReviewsBody(
        professionalUID: professionalUID,
      ),
    );
  }
}
