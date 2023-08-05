import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Screen/5.%20Product/Components/product_color_icon.dart';
import 'package:furniture_shop/Widgets/action_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPageStyle {
  static TextStyle item_title_text_style = GoogleFonts.gelasio(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle item_price_text_style = GoogleFonts.nunitoSans(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle item_rating_text_style = GoogleFonts.nunitoSans(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle purchase_amount_text_style = GoogleFonts.nunitoSans(
      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);

  static TextStyle item_description_text_style = GoogleFonts.nunitoSans(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      wordSpacing: 2,
      color: Color.fromARGB(255, 96, 96, 96));

  static TextStyle add_to_cart_button_text_style = GoogleFonts.nunitoSans(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
}

class ProductPage extends StatefulWidget {
  //TODO: Pass a product to display
  //final Product product;
  const ProductPage({
    super.key,
    //required this.product,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
                              fit: BoxFit.cover),
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
                                ProductColorIcon(color: Colors.white),
                                ProductColorIcon(
                                    color: Color.fromARGB(255, 180, 145, 108)),
                                ProductColorIcon(
                                    color: Color.fromARGB(255, 228, 203, 173)),
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
                        style: ProductPageStyle.item_title_text_style,
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      //Price and purchase amount
                      Row(
                        children: [
                          Text(
                            "\$ 50",
                            style: ProductPageStyle.item_price_text_style,
                          ),
                          Spacer(),
                          ActionButton(
                              boxShadow: [],
                              content: Icon(Icons.add),
                              size: Size(30, 30),
                              color: AppColor.grey5,
                              onPressed: () {}),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          Text(
                            '01',
                            style: ProductPageStyle.purchase_amount_text_style,
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          ActionButton(
                              boxShadow: [],
                              content: Icon(Icons.remove),
                              size: Size(30, 30),
                              color: AppColor.grey5,
                              onPressed: () {})
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      //TODO: Change to actual ratings
                      //TODO: Make every elements in this row TextButton that will show product's review
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 242, 201, 76),
                            size: 25,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(
                            '4.5',
                            style: ProductPageStyle.item_rating_text_style,
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text(
                            "(50 reviews)",
                            style: ProductPageStyle.item_description_text_style,
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      //TODO: Change to actual item description
                      Flexible(
                        fit: FlexFit.loose,
                        child: SingleChildScrollView(
                          child: Text(
                            'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
                            textAlign: TextAlign.justify,
                            style: ProductPageStyle.item_description_text_style,
                          ),
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
                                content: const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      size: 26,
                                      color: AppColor.black,
                                    ),
                                    Icon(
                                      Icons.bookmark,
                                      size: 20,
                                      color: AppColor.grey5,
                                    ),
                                  ],
                                ),
                                size: Size(60, 60),
                                color: AppColor.grey5,
                                onPressed: () {}),
                            const Padding(padding: EdgeInsets.only(right: 15)),
                            Expanded(
                              child: ActionButton(
                                  boxShadow: [],
                                  content: Text(
                                    "Add to cart",
                                    style: ProductPageStyle
                                        .add_to_cart_button_text_style,
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
