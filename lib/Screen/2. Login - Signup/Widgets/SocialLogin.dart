import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  final String image;
  final String label;
  final dynamic onPressed ;

  const SocialLogin({super.key, required this.image, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(image),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}


