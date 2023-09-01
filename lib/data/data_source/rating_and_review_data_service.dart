import 'package:furniture_shop/Objects/rating_and_review.dart';

abstract class RatingAndReviewDataService {
  Future<void> addReview(RatingAndReview review);
  Future<void> updateReview(
    String reviewID, {
    int? rating,
    String? review,
    bool? deleted,
  });
  Future<void> deleteReview(RatingAndReview review);
  Future<List<RatingAndReview>> getAllReviewsByProduct(String productID);
  Future<List<RatingAndReview>> getAllReviewsByUser(String userID);
}
