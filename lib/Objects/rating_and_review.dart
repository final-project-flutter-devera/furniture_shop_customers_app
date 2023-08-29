import 'package:cloud_firestore/cloud_firestore.dart';

class RatingAndReview {
  final String id;
  final String userID;
  final String productID;
  final String orderID;
  late int rating;
  String? review;
  late Timestamp? date;
  bool isDeleted;
  RatingAndReview(
      {required this.id,
      required this.userID,
      required this.productID,
      required this.orderID,
      required int rating,
      this.review,
      this.date,
      this.isDeleted = false}) {
    if (1 <= rating && rating <= 5) {
      this.rating = rating;
      date = Timestamp.now();
    } else {
      throw 'Rating must be between 1 and 5';
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'productID': productID,
      'orderID': orderID,
      'rating': rating,
      'review': review,
      'date': date,
      'isDeleted': isDeleted,
    };
  }

  factory RatingAndReview.fromJson(Map<String, dynamic> json) {
    return RatingAndReview(
        id: json['id'] as String,
        userID: json['userID'] as String,
        productID: json['productID'] as String,
        orderID: json['orderID'] as String,
        rating: json['rating'] as int,
        review: json['review'] as String?,
        date: json['date'] as Timestamp?,
        isDeleted: json['isDeleted'] as bool);
  }
}
