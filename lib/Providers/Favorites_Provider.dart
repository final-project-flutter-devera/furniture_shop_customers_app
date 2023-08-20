import 'package:flutter/foundation.dart';

import 'Product_class.dart';

class Favorites extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getFavoriteItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  Future<void> addFavoriteItems(
      String name,
      double price,
      int quantity,
      int availableQuantity,
      List imageList,
      String documentID,
      String supplierID,
      ) async {
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
  void removeProduct(Product product){
    _list.remove(product);
    notifyListeners();
  }
  void clearFavoritesList(){
    _list.clear();
    notifyListeners();
  }
  void removeThis(String id){
    _list.removeWhere((element) => element.documentID == id);
    notifyListeners();
  }
}
