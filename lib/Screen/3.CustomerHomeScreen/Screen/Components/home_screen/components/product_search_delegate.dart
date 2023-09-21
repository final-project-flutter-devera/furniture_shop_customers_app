import 'dart:async';

import 'package:flutter/material.dart';
import 'package:furniture_shop/localization/app_localization.dart';

class ProductSearchDelegate extends SearchDelegate {
  final BuildContext parentContext;

  ProductSearchDelegate({required this.parentContext});
  @override
  String? get searchFieldLabel =>
      parentContext.localize('label_product_search');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
      IconButton(
          onPressed: () {
            Scaffold.of(parentContext).openEndDrawer();
          },
          icon: const Icon(Icons.menu_open))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    query;
    return SizedBox();
  }

  Timer? _debounce;
  Future<List<dynamic>> _onSearchChanged(String query) async {
    Completer<List<dynamic>> completer = Completer();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      completer.complete();
    });
    return completer.future;
  }

  _productSearch() {}
}
