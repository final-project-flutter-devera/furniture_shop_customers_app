import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Objects/supplier.dart';
import 'package:furniture_shop/localization/app_localization.dart';

class SupplierSearchDelegate extends SearchDelegate {
  final BuildContext context;
  final List<Supplier> followingSuppliers;
  SupplierSearchDelegate(
      {required this.context, required this.followingSuppliers});
  //TODO: Implement search history?
  @override
  String? get searchFieldLabel => context.localize('label_search_for_supplier');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
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
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Supplier> suggestion = [];
    if (query.isNotEmpty) {
      followingSuppliers.forEach((supplier) {
        if (supplier.name.contains(query)) {
          suggestion.add(supplier);
        }
      });
    }
    return const SizedBox();
  }
}
