import 'package:furniture_shop/Objects/rating_and_review.dart';

class Product {
  //Product title
  String title;

  double price;
  //Product description
  String description;

  //TODO: Maybe change into another variable type in the future???
  //First element is thumbnail
  List<String> image;

  List<RatingAndReview> review;
  Product(
      {required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.review});
}
