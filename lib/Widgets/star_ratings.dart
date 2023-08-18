import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';

class StarRatings extends StatelessWidget {
  final int ratings;
  const StarRatings({super.key, required this.ratings});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: Row(
          children: [
            ...List<Widget>.generate(
                5,
                (index) => Icon(
                      Icons.star,
                      color: (index < ratings)
                          ? const Color(0xFFF2C94C)
                          : AppColor.grey,
                      size: 20,
                    ))
          ],
        ));
  }
}
