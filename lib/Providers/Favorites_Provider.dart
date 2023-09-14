import 'package:flutter/foundation.dart';
import 'package:furniture_shop/Providers/SQL_helper.dart';

import 'Product_class.dart';

class Favorites extends ChangeNotifier {
  static List<Product> _list = [];

  List<Product> get getFavoriteItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  void addFavoriteItems(Product product) async {
    await SQLHelper.insertWish(product).whenComplete(() => _list.add(product));
    notifyListeners();
  }

  loadWishItemsProvider() async {
    List<Map> data = await SQLHelper.loadWishItems();
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

  void removeProduct(Product product) async {
    await SQLHelper.deleteWishItem(product.documentID)
        .whenComplete(() => _list.remove(product));
    notifyListeners();
  }

  void clearFavoritesList() async {
    await SQLHelper.deleteAllWishItems().whenComplete(() => _list.clear());
    notifyListeners();
  }

  void removeThis(String id) async {
    await SQLHelper.deleteWishItem(id).whenComplete(() => _list
        .removeWhere((element) => element.documentID == id));

    notifyListeners();
  }
}
