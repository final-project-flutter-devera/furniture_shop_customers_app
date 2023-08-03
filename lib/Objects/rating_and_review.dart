class RatingAndReview {
  //TODO: change user variable into user object
  String user;

  //Rating value from 1 to 5
  int rating;
  DateTime reviewDate;
  String description;
  RatingAndReview(
      {required this.user,
      required this.rating,
      required this.reviewDate,
      required this.description});
}
