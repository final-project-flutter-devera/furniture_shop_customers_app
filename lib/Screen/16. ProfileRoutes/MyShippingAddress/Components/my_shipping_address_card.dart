import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Objects/address.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class MyShippingAddressCard extends StatelessWidget {
  final bool isMainAddress = false;
  final Address address = Address(
      name: 'My name',
      street: 'My Street',
      city: 'My City',
      state: 'My State',
      zipCode: 'My ZipCode',
      country: 'My Country');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(value: isMainAddress, onChanged: ((value) => {})),
            Text(
              context.localize('use_address'),
              style:
                  GoogleFonts.nunitoSans(fontSize: 18, color: AppColor.black),
            )
          ],
        ),
        Container(
          decoration: AppStyle.white_container_decoration,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 15),
                  child: Row(children: [
                    Text(
                      "User Name",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.edit,
                      color: AppColor.black,
                      size: 24,
                    )
                  ]),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Divider(
                    color: AppColor.blur_grey,
                    thickness: 3,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: Text(
                    '${address.street}, ${address.city}, ${address.zipCode}, ${address.state}, ${address.country}',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.nunitoSans(
                        color: AppColor.text_secondary, fontSize: 14),
                  ),
                )
              ]),
        ),
      ],
    );
  }
}
