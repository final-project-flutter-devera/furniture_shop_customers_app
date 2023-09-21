import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Screen/5.%20Product/Products_Detail_Screen.dart';

class ProductThumbnail extends StatelessWidget {
  final dynamic product;
  const ProductThumbnail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(products: product),
          )),
      child: SizedBox(
        width: screenWidth * 0.4,
        height: screenWidth * 0.7,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: FancyShimmerImage(
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              imageUrl: product['proImages'][0],
              shimmerHighlightColor: AppColor.highlightShimmerColor,
              shimmerBaseColor: AppColor.baseShimmerColor,
              shimmerBackColor: AppColor.widgetShimmerColor,
              boxFit: BoxFit.cover,
            ),
          ),
          Text(
            product['proName'],
            textAlign: TextAlign.left,
            style: AppStyle.tab_title_text_style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "\$${product['price'].toString()}",
            textAlign: TextAlign.center,
            style: AppStyle.tab_title_text_style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ]),
      ),
    );
  }
}
