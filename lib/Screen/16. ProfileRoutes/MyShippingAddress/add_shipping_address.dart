import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/MyShippingAddress/Components/app_text_field.dart';
import 'package:furniture_shop/Widgets/action_button.dart';
import 'package:furniture_shop/Widgets/default_app_bar.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class AddShipingAddress extends StatefulWidget {
  @override
  State<AddShipingAddress> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShipingAddress> {
  String? countryValue = '';
  String? stateValue = '';
  String? cityValue = '';
  String? address = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
          context: context,
          title: context.localize('add_shipping_address_app_bar_title')),
      body: Form(
        key: _formKey,
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: AppTextField(
              labelText: context.localize('label_full_name'),
              hintText: context.localize('place_holder_full_name'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: AppTextField(
              labelText: context.localize('label_address'),
              hintText: context.localize('place_holder_address'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: AppTextField(
              labelText: context.localize('label_zipcode'),
              hintText: context.localize('place_holder_zipcode'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: CSCPicker(
              layout: Layout.vertical,
              showCities: true,
              showStates: true,
              flagState: CountryFlag.DISABLE,
              countrySearchPlaceholder: context.localize('label_country'),
              stateSearchPlaceholder: context.localize('label_city'),
              citySearchPlaceholder: context.localize('label_district'),
              countryDropdownLabel: context.localize('place_holder_country'),
              stateDropdownLabel: context.localize('place_holder_city'),
              cityDropdownLabel: context.localize('place_holder_district'),
              countryFilter: [CscCountry.Vietnam, CscCountry.United_States],
              dropdownItemStyle: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value;
                });
              },
            ),
          ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 35),
              child: ActionButton(
                  boxShadow: [],
                  content: Text(
                    context.localize('label_save_button'),
                    style: AppStyle.text_style_on_black_button,
                  ),
                  size: Size(double.infinity, 60),
                  color: AppColor.black,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  })),
        ]),
      ),
    );
  }
}
