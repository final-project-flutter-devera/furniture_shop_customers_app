import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';

AppBar DefaultAppBar({
  required BuildContext context,
  required String title,
  List<Widget> actions = const [],
}) {
  return AppBar(
    backgroundColor: AppColor.blur_grey,
    foregroundColor: AppColor.black,
    elevation: 0,
    actions: actions,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.keyboard_arrow_left,
        size: 40,
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: AppStyle.app_bar_title_text_style,
    ),
  );
}
