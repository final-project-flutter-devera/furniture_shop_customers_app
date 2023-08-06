import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoLoginSignup extends StatelessWidget {
  const LogoLoginSignup({
    super.key,
    required this.wMQ,
  });

  final double wMQ;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(color: Colors.black, height: 1, width: wMQ * 0.25),
              SvgPicture.asset(
                'assets/Images/Icons/SofaLogin.svg',
                height: 100,
                width: 100,
              ),
              Container(color: Colors.black, height: 1, width: wMQ * 0.25),
            ],
          ),
        ],
      ),
    );
  }
}
