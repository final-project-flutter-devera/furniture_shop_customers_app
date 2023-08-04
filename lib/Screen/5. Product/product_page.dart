import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Screen/5.%20Product/Components/product_color_icon.dart';
import 'package:furniture_shop/Widgets/action_button.dart';

class ProductPage extends StatelessWidget {
  //TODO: Pass a product to display
  //final Product product;
  const ProductPage({
    super.key,
    //required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: constraints.maxHeight * 0.6,
                child: Stack(
                  children: [
                    // Product photos
                    Positioned(
                      left: constraints.maxWidth * 0.15,
                      child: Container(
                        height: constraints.maxHeight * 0.6,
                        width: constraints.maxWidth * 0.85,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5))),
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                          //Fix itemCount
                          itemCount: 1,
                          //TODO: Change into online photo fetch
                          itemBuilder: (context, index) => Image(
                              image: AssetImage(
                                'assets/Images/Images/minimal_stand.png',
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    //Go Back button
                    Positioned(
                        top: constraints.maxHeight * 0.09,
                        left: constraints.maxWidth * 0.08,
                        child: ActionButton(
                            content: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 40,
                            ),
                            size: const Size(50, 50),
                            color: AppColor.white,
                            //TODO: Change to Navigator.pop()
                            onPressed: () {},
                            boxShadow: AppStyle
                                .white_container_shadow_on_white_background)),
                    //Product color choice
                    //TODO: Change to using Product's actual list of color
                    //TODO: Change from Row to ListView in case product has mutiple colors
                    Positioned(
                        top: constraints.maxHeight * 0.2,
                        left: constraints.maxWidth * 0.07,
                        child: Container(
                            width: 65,
                            //height = 2 * icon * (17 + 15)
                            //where 17 is icon radius and 15 is padding
                            height: 192,
                            constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight * 0.4),
                            decoration: const BoxDecoration(
                                color: AppColor.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)),
                                boxShadow: AppStyle
                                    .white_container_shadow_on_white_background),
                            child: Column(
                              children: [
                                ProductColorIcon(color: Colors.red),
                                ProductColorIcon(color: Colors.green),
                                ProductColorIcon(color: Colors.blue),
                              ],
                            ))),
                  ],
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.4,
                width: double.infinity,
                padding: EdgeInsets.all(25),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Minimal Stand",
                        textAlign: TextAlign.start,
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      //Price and purchase amount
                      Row(
                        children: [
                          Text("\$ 50"),
                          Spacer(),
                          ActionButton(
                              boxShadow: [],
                              content: Icon(Icons.add),
                              size: Size(30, 30),
                              color: AppColor.grey5,
                              onPressed: () {}),
                          Text(
                            '01',
                          ),
                          ActionButton(
                              boxShadow: [],
                              content: Icon(Icons.remove),
                              size: Size(30, 30),
                              color: AppColor.grey5,
                              onPressed: () {})
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 15)),
                      //TODO: Change to actual ratings
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      //TODO: Change to actual item description
                      const Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ',
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Row(
                          children: [
                            ActionButton(
                                boxShadow: [],
                                content: Icon(Icons.bookmark, size: 24),
                                size: Size(60, 60),
                                color: AppColor.grey5,
                                onPressed: () {}),
                            const Padding(padding: EdgeInsets.only(right: 15)),
                            Expanded(
                              child: ActionButton(
                                  boxShadow: [],
                                  content: Text(
                                    "Add to cart",
                                  ),
                                  size: Size(60, 60),
                                  color: AppColor.primary,
                                  onPressed: () {}),
                            ),
                          ],
                        ),
                      )
                      //Review
                      //Description
                      //Bookmark and Add to cart
                    ]),
              )
              //Item name
            ],
          ),
        ));
  }
}
