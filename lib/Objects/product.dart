import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String proID; //Primary key
  final String sid;
  String proName;
  String prodesc;
  String proImages;
  String mainCategory;
  List<String>? subCategory;
  int inStock;
  double discount;
  double price;
  bool isDeleted;
  Product({
    required this.proID,
    required this.sid,
    required this.proName,
    required this.prodesc,
    required this.proImages,
    required this.mainCategory,
    this.subCategory,
    required this.price,
    required this.inStock,
    required this.discount,
    this.isDeleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'proID': proID,
      'sid': sid,
      'proName': proName,
      'prodesc': prodesc,
      'proImages': proImages,
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'price': price,
      'inStock': inStock,
      'discount': discount,
      'isDeleted': isDeleted,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        proID: json['proID'] as String,
        sid: json['sid'],
        proName: json['proName'] as String,
        prodesc: json['description'] as String,
        proImages: json['proImages'],
        mainCategory: json['mainCategory'],
        subCategory: json['subCategory'],
        price: json['price'] as double,
        inStock: json['stock'],
        discount: json['discount'],
        isDeleted: json['isDeleted'] as bool);
  }
}
