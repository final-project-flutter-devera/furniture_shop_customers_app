import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  AppTextField({super.key, required this.labelText, required this.hintText});
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '${widget.labelText} ${context.localize('label_empty_field')}';
        }
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.blur_grey)),
          label: Text(
            widget.labelText,
            style: GoogleFonts.nunitoSans(
                fontSize: 12, color: AppColor.text_secondary),
          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.nunitoSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.text_secondary)),
      style: GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColor.black,
      ),
    );
  }
}
