// Reviews Model
import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews {
  final reviewId;
  final String professionalUID;
  final String customerUID;
  final Timestamp timestamp;
  final double rating;
  final String review;
  final bool isRecommended;

  Reviews({
    this.reviewId,
    this.professionalUID,
    this.customerUID,
    this.timestamp,
    this.rating,
    this.review,
    this.isRecommended,
  });
}
