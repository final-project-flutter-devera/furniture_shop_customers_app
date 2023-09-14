import 'package:flutter/foundation.dart';
import 'package:furniture_shop/Providers/SQL_helper.dart';
import 'Product_class.dart';

class Cart extends ChangeNotifier {
  static List<Product> _list = [];

  List<Product> get getItems {
    notifyListeners();
    return _list;
  }

  double get totalPrice {
    var total = 0.0;
    for (var product in _list) {
      total += product.price * product.quantity;
    }
    return total;
  }

  int? get count {
    return _list.length;
  }

  void addItems(Product product) async {
    await SQLHelper.insertCart(product).whenComplete(() => _list.add(product));
    notifyListeners();
  }

  loadCartItemsProvider() async {
    List<Map> data = await SQLHelper.loadCartItems();
    _list = data.map((product) {
      return Product(
        documentID: product['documentID'],
        name: product['name'],
        price: product['price'],
        quantity: product['quantity'],
        availableQuantity: product['availableQuantity'],
        imageList: product['imageList'],
        supplierID: product['supplierID'],
      );
    }).toList();
    notifyListeners();
  }

  void increment(Product product) async {
    await SQLHelper.updateQuantity(product, 'increment')
        .whenComplete(() => product.increase());
    notifyListeners();
  }

  Future<void> decrementByOne(Product product) async {
    await SQLHelper.updateQuantity(product, 'decrement')
        .whenComplete(() => product.decrease());
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    await SQLHelper.deleteCartItem(product.documentID);
    _list.remove(product);
    notifyListeners();
  }

  Future<void> clearAllProduct() async {
    await SQLHelper.deleteAllCartItems().whenComplete(() => _list.clear());

    notifyListeners();
  }
}
