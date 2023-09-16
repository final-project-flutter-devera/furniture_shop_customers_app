import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Widgets/star_ratings.dart';
import 'package:google_fonts/google_fonts.dart';

class MyReviewCard extends StatelessWidget {
  const MyReviewCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle.white_container_decoration,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  'assets/Images/Images/review_thumbnail.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Item name",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        color: AppColor.text_secondary,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "\$ Item price",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        color: AppColor.black,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(children: [
              StarRatings(ratings: 4),
              const Spacer(),
              Text(
                "Date",
                style: GoogleFonts.nunitoSans(
                  fontSize: 12,
                  color: AppColor.text_secondary,
                ),
              ),
            ]),
          ),
          LimitedBox(
            maxHeight: MediaQuery.of(context).size.height * 0.2,
            child: Text(
              "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description ",
              textAlign: TextAlign.justify,
              overflow: TextOverflow.fade,
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                color: AppColor.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
