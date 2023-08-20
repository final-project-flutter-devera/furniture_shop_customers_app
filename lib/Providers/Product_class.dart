class Product {
  String name;
  double price;
  int quantity;
  int availableQuantity;
  List imageList;
  String documentID;
  String supplierID;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    required this.availableQuantity,
    required this.imageList,
    required this.documentID,
    required this.supplierID,
  });
  void increase(){
    quantity++;
  }
  void decrease(){
    quantity--;
  }
}