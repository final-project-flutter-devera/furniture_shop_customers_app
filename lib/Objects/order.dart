enum OrderStatus { delivered, processing, canceled }

class Order {
  String number;
  DateTime date;
  //TODO: List of item, from this list total price will be calculated
  late double totalPrice;
  OrderStatus status;
  Order({
    required this.number,
    required this.date,
    required this.status,
  }) {
    //TODO: Calculate total price
    totalPrice = 0;
  }
}
