// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/svg.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/constants/loading.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/reviews_model.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/secondary_screens/create_review.dart';
import 'package:help4you/secondary_screens/reviews_screen.dart/review_tile.dart';

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
        leading: CustomBackButton(),
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
              FluentIcons.add_24_filled,
              size: 25.0,
              color: Color(0xFFFEA700),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: DatabaseService(professionalUID: professionalUID).reviewsData,
        builder: (context, snapshot) {
          List<Reviews> reviews = snapshot.data;
          if (snapshot.hasData) {
            if (reviews.length == 0) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: SvgPicture.asset(
                      "assets/graphics/Help4You_Illustration_6.svg",
                    ),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: reviews.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ReviewTile(
                    reviewId: reviews[index].reviewId,
                    customerUID: reviews[index].customerUID,
                    timeStamp: reviews[index].timestamp,
                    rating: reviews[index].rating,
                    review: reviews[index].review,
                    isRecommended: reviews[index].isRecommended,
                  );
                },
              );
            }
          } else {
            return DoubleBounceLoading();
          }
        },
      ),
    );
  }
}
