class Product {
  String name;
  double price;
  int quantity;
  int availableQuantity;

  // List imageList;
  String imageList;
  String documentID;
  String supplierID;

  Product({
    required this.documentID,
    required this.name,
    required this.price,
    required this.quantity,
    required this.availableQuantity,
    required this.imageList,
    required this.supplierID,
  });

  void increase() {
    quantity++;
  }

  void decrease() {
    quantity--;
  }

  Map<String, dynamic> toMap() {
    return {
      'documentID': documentID,
      'name': name,
      'price': price,
      'quantity': quantity,
      'availableQuantity': availableQuantity,
      'imageList': imageList,
      'supplierID': supplierID,
    };
  }

  @override
  String toString() {
    return 'Product {name: $name, price: $price, quantity: $quantity, availableQuantity: $availableQuantity,}';
  }
}
