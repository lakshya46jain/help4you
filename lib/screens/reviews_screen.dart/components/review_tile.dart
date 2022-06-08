// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports

class ReviewTile extends StatelessWidget {
  final String reviewId;
  final String customerUID;
  final Timestamp timeStamp;
  final double rating;
  final String review;
  final bool isRecommended;

  const ReviewTile({
    Key key,
    @required this.reviewId,
    @required this.customerUID,
    @required this.timeStamp,
    @required this.rating,
    @required this.review,
    @required this.isRecommended,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(customerUID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Customer Data Strings
          String profilePicture = snapshot.data["Profile Picture"];
          String fullName = snapshot.data["Full Name"];

          // Review Tile
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 33,
                      backgroundImage: CachedNetworkImageProvider(
                        profilePicture,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  fullName,
                                  style: const TextStyle(
                                    height: 1.0,
                                    fontSize: 20.0,
                                    color: Color(0xFF1C3857),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.64,
                                  child: Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(timeStamp.toDate().toLocal()),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7.5),
                            SimpleStarRating(
                              rating: rating,
                              filledIcon: const Icon(
                                CupertinoIcons.star_fill,
                                size: 25.0,
                                color: Color(0xFFFEA700),
                              ),
                              nonFilledIcon: Icon(
                                CupertinoIcons.star_fill,
                                size: 25.0,
                                color: const Color(0xFF95989A).withOpacity(0.3),
                              ),
                            ),
                            const SizedBox(height: 7.5),
                            Opacity(
                              opacity: 0.64,
                              child: Text(
                                review,
                                maxLines: null,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              padding: const EdgeInsets.all(8.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                  width: 3,
                                  color:
                                      const Color(0xFF95989A).withOpacity(0.2),
                                ),
                              ),
                              width: (isRecommended == true) ? 175.5 : 215.5,
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      (isRecommended == true)
                                          ? Icons.thumb_up_rounded
                                          : Icons.thumb_down_rounded,
                                      color: (isRecommended == true)
                                          ? Colors.lightGreen
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 7.5),
                                    Text(
                                      (isRecommended == true)
                                          ? "Recommended"
                                          : "Do Not Recommend",
                                      style: const TextStyle(fontSize: 17.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 4.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF95989A).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
