import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Objects/supplier.dart';
import 'package:furniture_shop/Screen/5.%20Product/Visit_Store.dart';
import 'package:furniture_shop/Widgets/avatar.dart';

class SupplierListTile extends StatelessWidget {
  final Supplier supplier;
  const SupplierListTile({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const Border(
          bottom: BorderSide(color: AppColor.blur_grey),
          top: BorderSide(color: AppColor.blur_grey)),
      contentPadding: const EdgeInsets.all(10),
      leading: Avatar(
        name: supplier.name,
        avatarLink: supplier.profileimage,
      ),
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(
        supplier.name,
        textAlign: TextAlign.left,
        style: AppStyle.tab_title_text_style,
        overflow: TextOverflow.fade,
      ),
      trailing:
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove_outlined)),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VisitStore(supplierID: supplier.sid)));
      },
    );
  }
}
