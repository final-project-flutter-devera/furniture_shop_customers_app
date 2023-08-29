import 'package:furniture_shop/Objects/rating_and_review.dart';

abstract class RatingAndReviewDataService {
  Future<void> addReview(RatingAndReview review);
  Future<void> updateReview(RatingAndReview review);
  Future<void> deleteReview(RatingAndReview review);
  Future<List<RatingAndReview>> getAllReviewsByProduct(String productID);
  Future<List<RatingAndReview>> getAllReviewsByUser(String userID);
}
