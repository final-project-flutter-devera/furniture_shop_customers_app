import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Objects/customer.dart';
import 'package:furniture_shop/Objects/supplier.dart';
import 'package:furniture_shop/Providers/customer_provider.dart';
import 'package:furniture_shop/Providers/supplier_provider.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../Models/Product_model.dart';

class VisitStore extends StatefulWidget {
  final String supplierID;

  const VisitStore({super.key, required this.supplierID});

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  bool following = false;
  late Customer customer;
  late Supplier supplier;

  @override
  void initState() {
    _getCurrentCustomer();
    _getSupplier();
    super.initState();
  }

  _getCurrentCustomer() async {
    customer = await context
        .read<CustomerProvider>()
        .getCurrentCustomer()
        .then((value) => value);

    setState(() {
      following = customer.following!.contains(widget.supplierID);
    });
  }

  _getSupplier() async {
    supplier =
        await context.read<SupplierProvider>().getSupplier(widget.supplierID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double wMQ = MediaQuery.of(context).size.width;
    CollectionReference suppliers =
        FirebaseFirestore.instance.collection('Suppliers');
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: widget.supplierID)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: suppliers.doc(widget.supplierID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 135,
              leading: const AppBarBackButtonPop(),
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: [
                  data['storeCoverImage'] == ''
                      ? Image.asset(
                          'assets/Images/Images/boarding.png',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          data['storeCoverImage'],
                          fit: BoxFit.cover,
                        ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                        colors: [
                          AppColor.black,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 39,
                        backgroundColor: AppColor.white,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(data['storeLogo']),
                          backgroundColor: AppColor.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: wMQ * 0.5,
                        child: Text(
                          data['name'],
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              color: AppColor.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColor.amber,
                            size: 15,
                          ),
                          Text(
                            '5.0 / ',
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            ),
                          ),
                          Text(
                            "${supplier.follower?.length.toString() ?? '0'} ${context.localize('follower')}",
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (following) {
                            FirebaseMessaging.instance
                                .subscribeToTopic('follow');
                            customer.following?.remove(widget.supplierID);
                            supplier.follower?.remove(customer.cid);
                          } else {
                            FirebaseMessaging.instance
                                .unsubscribeFromTopic('follow');
                            customer.following?.add(widget.supplierID);
                            supplier.follower?.add(customer.cid);
                          }

                          context
                              .read<CustomerProvider>()
                              .updateCurrentCustomer(
                                  following: customer.following);

                          context.read<SupplierProvider>().updateSupplier(
                              supplier.sid,
                              follower: supplier.follower);
                          setState(() {
                            following = !following;
                          });
                        },
                        child: Container(
                            width: 110,
                            height: 35,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(width: 2, color: AppColor.white),
                            ),
                            child: following == true
                                ? Center(
                                    child: Text(
                                      'Following',
                                      style: GoogleFonts.nunito(
                                          color: AppColor.white),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      '+ Follow',
                                      style: GoogleFonts.nunito(
                                          color: AppColor.white),
                                    ),
                                  )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: AppColor.grey5,
                    highlightColor: AppColor.blur_grey,
                    child: const Scaffold(),
                  );
                }
                return SingleChildScrollView(
                  child: StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      return ProductModel(
                        products: snapshot.data!.docs[index],
                      );
                    },
                    staggeredTileBuilder: (context) =>
                        const StaggeredTile.fit(1),
                  ),
                );
              },
            ),
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
