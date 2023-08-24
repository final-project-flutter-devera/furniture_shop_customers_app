import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsDashboard extends StatelessWidget {
  const AnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var wMQ = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leading: const AppBarBackButtonPop(),
        title: const AppBarTitle(label: 'Analytics'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: wMQ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnalysisMode(label: 'sold out', value: 100),
            AnalysisMode(label: 'products sold', value: 100),
            AnalysisMode(label: 'balance', value: 100),
          ],
        ),
      ),
    );
  }
}

class AnalysisMode extends StatelessWidget {
  final String label;
  final dynamic value;

  const AnalysisMode({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    var wMQ = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: 30,
          width: wMQ * 0.9,
          decoration: BoxDecoration(
            color: AppColor.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColor.white),
            ),
          ),
        ),
        Container(
          height: 150,
          width: wMQ * 0.9,
          decoration: BoxDecoration(
            color: AppColor.grey5,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              value.toString(),
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColor.blue),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
