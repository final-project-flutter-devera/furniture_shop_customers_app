import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String buyerID;
  final String sellerID;
  String? ratingAndReviewID;

  List<String> productID;
  List<int> amount;

  double totalPrice;
  late Timestamp? orderDate;

  Timestamp? deliveryDate;
  Timestamp? cancelDate;
  late String? status;

  Order({
    required this.id,
    required this.buyerID,
    required this.sellerID,
    required this.productID,
    required this.amount,
    this.ratingAndReviewID,
    this.totalPrice = 0,
    this.status = 'Processing',
    this.orderDate,
    this.deliveryDate,
    this.cancelDate,
  }) {
    //TODO: Calculate totalPrice later
    if (this.orderDate == null) orderDate = Timestamp.now();
  }

  void updateStatus(String status) {
    this.status = status;
  }

  void updateDeliveryDate() {
    if (this.deliveryDate == null)
      this.deliveryDate = Timestamp.now();
    else
      throw 'This order already has a delivery date';
  }

  void cancelOrder() {
    if (this.cancelDate == null)
      this.cancelDate = Timestamp.now();
    else
      throw 'This order is already canceled';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerID': buyerID,
      'sellerID': sellerID,
      'ratingAndReviewID': ratingAndReviewID,
      'productID': productID,
      'amount': amount,
      'totalPrice': totalPrice,
      'status': status,
      'orderDate': orderDate.toString(),
      'deliveryDate': deliveryDate.toString(),
      'cancelDate': cancelDate.toString(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      buyerID: json['buyerID'] as String,
      sellerID: json['sellerID'] as String,
      ratingAndReviewID: json['ratingAndReviewID'] as String?,
      productID: json['productID'] as List<String>,
      amount: json['amount'] as List<int>,
      status: json['status'] as String,
      totalPrice: json['totalPrice'] as double,
      orderDate: json['orderDate'] as Timestamp,
      deliveryDate: json['deliveryDate'] as Timestamp?,
      cancelDate: json['cancelDate'] as Timestamp?,
    );
  }
}
