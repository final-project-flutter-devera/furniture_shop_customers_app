import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_shop/Constants/enums.dart';

class Order {
  final String id;
  final String orderID;
  final String customerID;
  //Each ID will correspond to quantity index
  final List<String> productID;
  final List<int> quantity;

  //TODO: Add review ID

  late double totalPrice;
  OrderStatus status;
  String address;

  //Order Date
  late DateTime purchaseDate;
  DateTime? deliveryDate;

  Order({
    required this.id,
    required this.orderID,
    required this.customerID,
    required this.productID,
    required this.quantity,
    this.status = OrderStatus.processing,
    required this.address,
  }) {
    purchaseDate = DateTime.now();

    //TODO: Fetch each product to get price and calculate total price
    totalPrice = 0;
  }
  void updateStatus(OrderStatus status) {
    this.status = status;
  }

  void updateDeliveryDate(DateTime deliveryDate) {
    this.deliveryDate = deliveryDate;
  }

  //TODO: toJSON and fromJSON function
}
