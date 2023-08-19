import 'package:flutter/material.dart';
import 'package:furniture_shop/Objects/product.dart';

//Used for product card in favorite list
class MiniProductCard extends StatefulWidget {
  final Product product;
  const MiniProductCard({super.key, required this.product});

  @override
  State<MiniProductCard> createState() => _MiniProductCardState();
}

class _MiniProductCardState extends State<MiniProductCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
