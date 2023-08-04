import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final List<BoxShadow> boxShadow;
  final Widget content;
  final Size size;
  final Color color;
  ActionButton({
    super.key,
    required this.boxShadow,
    required this.content,
    required this.size,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: boxShadow,
      ),
      child: Center(
        child: content,
      ),
    );
  }
}
