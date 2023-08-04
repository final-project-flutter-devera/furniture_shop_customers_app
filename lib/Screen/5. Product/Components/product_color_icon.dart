import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';

class ProductColorIcon extends StatefulWidget {
  final Color color;
  const ProductColorIcon({super.key, required this.color});

  @override
  State<ProductColorIcon> createState() => _ProductColorIconState();
}

class _ProductColorIconState extends State<ProductColorIcon> {
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: CircleAvatar(
        backgroundColor: Color.fromARGB((selected) ? 255 : 155, 144, 144, 144),
        radius: 17,
        child: CircleAvatar(
            backgroundColor: AppColor.white,
            radius: 12,
            child: CircleAvatar(
              backgroundColor: widget.color,
              radius: 12,
            )),
      ),
    );
  }
}
