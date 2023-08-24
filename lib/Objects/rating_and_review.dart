import 'package:cloud_firestore/cloud_firestore.dart';

class RatingAndReview {
  final String id;
  late int rating;
  String? review;
  late Timestamp? date;
  RatingAndReview(
      {required this.id, required int rating, this.review, this.date}) {
    if (1 <= rating && rating <= 5) {
      this.rating = rating;
      date = Timestamp.now();
    } else {
      throw 'Rating must be between 1 and 5';
    }
  }

  //TODO: toJSON and fromJSON function
}
