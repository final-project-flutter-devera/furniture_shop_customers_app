import 'dart:async';

import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Objects/customer.dart';
import 'package:furniture_shop/Objects/supplier.dart';
import 'package:furniture_shop/Providers/supplier_provider.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/following_store/components/loading_supplier_list_tile.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/following_store/components/supplier_list_tile.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/following_store/components/supplier_search_delegate.dart';
import 'package:furniture_shop/Widgets/default_app_bar.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:provider/provider.dart';

class FollowingStore extends StatefulWidget {
  final Customer currentCustomer;
  const FollowingStore({super.key, required this.currentCustomer});

  @override
  State<FollowingStore> createState() => _FollowingStoreState();
}

class _FollowingStoreState extends State<FollowingStore> {
  var isLoading = true;
  late List<Supplier> followingSuppliers;

  @override
  void initState() {
    _getFollowingSuppliers();
    super.initState();
  }

  _getFollowingSuppliers() async {
    List<Supplier> _followingSuppliers = [];

    List<Future<Supplier>> requests = [];
    widget.currentCustomer.following?.forEach((supplierID) {
      requests.add(context.read<SupplierProvider>().getSupplier(supplierID));
    });
    _followingSuppliers = await Future.wait(requests);
    followingSuppliers = _followingSuppliers;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
            context: context,
            title: context.localize(
              'followed_suppliers_option',
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: SupplierSearchDelegate(
                            context: context,
                            followingSuppliers: followingSuppliers));
                  },
                  icon: const Icon(Icons.search))
            ]),
        body: widget.currentCustomer.following == null ||
                widget.currentCustomer.following!.isEmpty
            ? Center(
                child: Text(
                  context.localize('label_no_supplier_followed'),
                  style: AppStyle.tab_title_text_style,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.currentCustomer.following!.length,
                itemBuilder: ((context, index) {
                  if (isLoading) return const LoadingSupplierListTile();
                  return SupplierListTile(supplier: followingSuppliers[index]);
                }),
              ));
  }
}
