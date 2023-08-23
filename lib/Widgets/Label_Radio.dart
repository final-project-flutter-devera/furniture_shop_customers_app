import 'package:flutter/material.dart';
import '../Constants/Colors.dart';

class LabelRadio extends StatelessWidget {
  const LabelRadio(
      {super.key,
        required this.icon,
        required this.label,
        required this.widget,
        required this.groupValue,
        required this.value,
        required this.onChanged});

  final Icon icon;
  final String label;
  final Widget widget;
  final int groupValue;
  final int value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: ListTile(
        leading: icon,
        title: Text(label),
        subtitle: widget,
        trailing: Radio<int>(
          activeColor: AppColor.black,
          groupValue: groupValue,
          value: value,
          onChanged: (int? newValue) {
            onChanged(newValue);
          },
        ),
      ),
    );
  }
}
