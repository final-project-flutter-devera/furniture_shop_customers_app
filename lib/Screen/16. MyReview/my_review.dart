import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Screen/16.%20MyReview/Components/my_review_card.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';

class MyReview extends StatelessWidget {
  const MyReview({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.blur_grey,
        appBar: AppBar(
          backgroundColor: AppColor.blur_grey,
          foregroundColor: AppColor.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.keyboard_arrow_left,
              size: 40,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 40,
              ),
            ),
          ],
          centerTitle: true,
          title: Text(
            'My reviews',
            style: AppStyle.app_bar_title_text_style,
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 10),
                child: MyReviewCard(),
              ),
            ))
          ],
        ));
  }
}
