class RatingAndReview {
  final String id;
  late int rating;
  String? review;
  RatingAndReview({required this.id, required int rating, this.review}) {
    if (1 <= rating && rating <= 5) {
      this.rating = rating;
    } else {
      throw 'Rating must be between 1 and 5';
    }
  }

  //TODO: toJSON and fromJSON function
}
