import 'package:cloud_firestore/cloud_firestore.dart';

// Reviews Model
class Reviews {
  final String reviewId;
  final double rating;
  final String review;
  final bool isRecommended;
  final Timestamp timestamp;
  final String customerUID;
  final String professionalUID;

  Reviews({
    this.reviewId,
    this.rating,
    this.review,
    this.isRecommended,
    this.timestamp,
    this.customerUID,
    this.professionalUID,
  });
}
