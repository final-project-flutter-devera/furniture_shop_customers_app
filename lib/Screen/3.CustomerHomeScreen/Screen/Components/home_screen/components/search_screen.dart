import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/List/ListCategory.dart';
import 'package:furniture_shop/Screen/3.CustomerHomeScreen/Screen/Components/home_screen/components/product_thumbnail.dart';
import 'package:furniture_shop/Widgets/default_app_bar.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:furniture_shop/scripts/remove_diacritics.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  SearchController searchController = SearchController();
  String searchInput = '';
  String? mainCategory;
  int orderBy = 0;
  String? subCategory;
  List<dynamic> queryResult = [];
  List<DropdownMenuItem>? subCategoryList;
  bool mainCategorySelected = false;
  bool menuOpen = false;
  _productQuery() async {
    queryResult = [];
    final Query query = FirebaseFirestore.instance.collection('products');
    final List<dynamic> querySnapshot;
    if (orderBy == 0) {
      querySnapshot = await query
          .where('mainCategory', isEqualTo: mainCategory)
          .where('subCategory', isEqualTo: subCategory)
          .get()
          .then((value) => value.docs);
    } else if (orderBy == 1) {
      querySnapshot = await query
          .where('mainCategory', isEqualTo: mainCategory)
          .where('subCategory', isEqualTo: subCategory)
          .orderBy('price', descending: true)
          .get()
          .then((value) => value.docs);
    } else {
      querySnapshot = await query
          .where('mainCategory', isEqualTo: mainCategory)
          .where('subCategory', isEqualTo: subCategory)
          .orderBy('price', descending: false)
          .get()
          .then((value) => value.docs);
    }
    for (final item in querySnapshot) {
      if (removeDiacritics(item['proName'] as String)
          .toLowerCase()
          .contains(removeDiacritics(searchController.text).toLowerCase())) {
        queryResult.add(item);
      }
    }
    setState(() {});
  }

  Timer? _debounce;
  _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _productQuery();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final List<DropdownMenuEntry<String>> mainCategory =
    //     <DropdownMenuEntry<String>>[];
    // for (final category in MainCategory) {
    //   mainCategory
    //       .add(DropdownMenuEntry<String>(value: category, label: category));
    // }
    return Scaffold(
        appBar: DefaultAppBar(
          context: context,
          title: '',
          titleWidget: CupertinoSearchTextField(
            controller: searchController,
            onChanged: (query) {
              if (query.isEmpty) {
                setState(() {
                  queryResult = [];
                });
              } else {
                _onSearchChanged(query);
              }
            },
            onSubmitted: (value) => _productQuery(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _productQuery();
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  setState(() {
                    menuOpen = !menuOpen;
                  });
                },
                icon: Icon(menuOpen ? Icons.menu_open : Icons.menu))
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              curve: Curves.easeInCirc,
              duration: const Duration(milliseconds: 500),
              height: menuOpen ? 50 : 0.0,
              color: AppColor.blur_grey,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    DropdownButton(
                      hint: Text(context.localize('hint_select_main_category')),
                      items: categoryMain
                          .map((category) => DropdownMenuItem(
                              value: category, child: Text(category)))
                          .toList(),
                      value: mainCategory,
                      onChanged: (value) {
                        subCategory = null;
                        if (value == categoryMain[0]) {
                          mainCategory = null;
                          mainCategorySelected = false;
                        } else {
                          mainCategory = value;
                          mainCategorySelected = true;
                        }
                        subCategoryList = switch (mainCategory) {
                          'Chair' => categoryChair
                              .map((category) => DropdownMenuItem(
                                  value: category, child: Text(category)))
                              .toList(),
                          'Table' => categoryTable
                              .map((category) => DropdownMenuItem(
                                  value: category, child: Text(category)))
                              .toList(),
                          'Armchair' => categoryArmchair
                              .map((category) => DropdownMenuItem(
                                  value: category, child: Text(category)))
                              .toList(),
                          'Bed' => categoryBed
                              .map((category) => DropdownMenuItem(
                                  value: category, child: Text(category)))
                              .toList(),
                          'Lamp' => categoryLamp
                              .map((category) => DropdownMenuItem(
                                  value: category, child: Text(category)))
                              .toList(),
                          _ => null,
                        };
                        setState(() {});
                      },
                    ),
                    const Spacer(),
                    DropdownButton(
                      disabledHint: Text(context
                          .localize('disabled_hint_select_sub_category')),
                      hint: Text(context.localize('hint_select_sub_category')),
                      value: subCategory,
                      items: subCategoryList,
                      onChanged: (value) {
                        if (value == subCategoryList![0].value) {
                          subCategory = null;
                        } else {
                          subCategory = value;
                        }
                        setState(() {});
                      },
                    ),
                    const Spacer(),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Order by',
                  style: AppStyle.secondary_text_style,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: DropdownButton(
                    hint: Text(context.localize('hint_select_sub_category')),
                    value: orderBy,
                    items: const <DropdownMenuItem<int>>[
                      DropdownMenuItem(value: 0, child: Text('None')),
                      DropdownMenuItem(value: -1, child: Text('Low to High')),
                      DropdownMenuItem(value: 1, child: Text('High to Low')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        orderBy = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
                child: GridView.count(
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    children: queryResult
                        .map((product) => ProductThumbnail(product: product))
                        .toList()))
          ],
        ));
  }
}
