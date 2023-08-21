import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:google_fonts/google_fonts.dart';

class FullScreenViewImages extends StatefulWidget {
  late List<dynamic> imagesList;

  FullScreenViewImages({super.key, required this.imagesList});

  @override
  State<FullScreenViewImages> createState() => _FullScreenViewImagesState();
}

class _FullScreenViewImagesState extends State<FullScreenViewImages> {
  final PageController _controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double hMQ = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leading: const AppBarBackButtonPop(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              ('${index + 1} / ${widget.imagesList.length}'),
              style: GoogleFonts.nunito(fontSize: 24),
            ),
          ),
          SizedBox(
            height: hMQ * 0.5,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              controller: _controller,
              children: imageList(),
            ),
          ),
          SizedBox(
            height: hMQ * 0.2,
            child: imageView(),
          ),
        ],
      ),
    );
  }

  List<Widget> imageList() {
    return List.generate(widget.imagesList.length, (index) {
      return InteractiveViewer(
          transformationController: TransformationController(),
          child: Image.network(widget.imagesList[index].toString()));
    });
  }

  Widget imageView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.imagesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _controller.jumpToPage(index);
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 4, color: AppColor.black)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(widget.imagesList[index]),
              ),
            ),
          );
        });
  }
}
