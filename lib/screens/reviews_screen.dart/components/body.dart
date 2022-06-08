// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/svg.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/reviews_model.dart';
import 'package:help4you/screens/reviews_screen.dart/components/review_tile.dart';

class ReviewsBody extends StatelessWidget {
  final String professionalUID;

  const ReviewsBody({
    Key key,
    @required this.professionalUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(professionalUID: professionalUID).reviewsData,
      builder: (context, snapshot) {
        List<Reviews> reviews = snapshot.data;
        if (snapshot.hasData) {
          if (reviews.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              physics: const BouncingScrollPhysics(),
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
          return Container();
        }
      },
    );
  }
}
