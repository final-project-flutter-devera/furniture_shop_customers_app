import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../Models/Product_model.dart';

class GalleryBed extends StatefulWidget {
  const GalleryBed({super.key});

  @override
  State<GalleryBed> createState() => _GalleryBedState();
}

class _GalleryBedState extends State<GalleryBed> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('mainCategory', isEqualTo: 'Bed')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return ProductModel(products: snapshot.data!.docs[index],);
            },
            staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
          ),
        );
      },
    );
  }
}

