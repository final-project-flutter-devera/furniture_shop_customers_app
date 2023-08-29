import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id; //Primary key
  String name;
  String description;
  List<String>? images;
  List<String> mainCategory;
  List<String>? subCategory;
  double price;
  bool isDeleted;
  Product({
    required this.id,
    required this.name,
    required this.description,
    this.images,
    required this.mainCategory,
    this.subCategory,
    required this.price,
    this.isDeleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'price': price,
      'images': images,
      'isDeleted': isDeleted,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        images: json['images'] as List<String>?,
        mainCategory: json['mainCategory'] as List<String>,
        subCategory: json['subCategory'] as List<String>?,
        price: json['price'] as double,
        isDeleted: json['isDeleted'] as bool);
  }
}
