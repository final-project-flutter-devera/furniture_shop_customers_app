import 'package:flutter/foundation.dart';
import 'Product_class.dart';


class Cart extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  double get totalPrice {
    var total = 0.0;
    for(var product in _list ){
      total += product.price * product.quantity;
    } return total;
  }

  int? get count {
   return _list.length;
  }

  void addItems(
    String name,
    double price,
    int quantity,
    int availableQuantity,
    List imageList,
    String documentID,
    String supplierID,
  ) {
    final product = Product(
        name: name,
        price: price,
        quantity: quantity,
        availableQuantity: availableQuantity,
        imageList: imageList,
        documentID: documentID,
        supplierID: supplierID);
    _list.add(product);
    notifyListeners();
  }
  void increment(Product product){
    product.increase();
    notifyListeners();
  }
  void decrementByOne(Product product){
    product.decrease();
    notifyListeners();
  }
  void removeProduct(Product product){
    _list.remove(product);
    notifyListeners();
  }
  void clearAllProduct(){
    _list.clear();
    notifyListeners();
  }
}
