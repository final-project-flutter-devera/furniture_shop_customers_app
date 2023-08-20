import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Providers/Favorites_Provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../Constants/Colors.dart';
import '../../../../Models/Favorites_model.dart';
import '../../../../Providers/Cart_Provider.dart';
import '../../../../Widgets/AppBarTitle.dart';
import 'CartScreen.dart';
import 'SearchScreen.dart';
import 'package:badges/badges.dart' as badges;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    var wMQ = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: SvgPicture.asset('assets/Images/Icons/search.svg',
                height: 24, width: 24)),
        title: const AppBarTitle(label: 'Favorites'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: badges.Badge(
              showBadge: context.read<Cart>().getItems.isEmpty ? false :true,
              badgeContent: Text(
                context.watch<Cart>().getItems.length.toString(),
              ),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: AppColor.amber,
              ),
              badgeAnimation: const badges.BadgeAnimation.fade(),
              child: SvgPicture.asset(
                'assets/Images/Icons/cart.svg',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: context.watch<Favorites>().getFavoriteItems.isNotEmpty
          ? const FavoritesProduct()
          : FavoritesProductEmpty(wMQ: wMQ),
    );
  }
}

class FavoritesProduct extends StatelessWidget {
  const FavoritesProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Favorites>(
      builder: (context, favorites, child) {
        return ListView.builder(
          itemCount: favorites.count,
          itemBuilder: (context, index) {
            final product = favorites.getFavoriteItems[index];
            return FavoritesModel(product: product);
          },
        );
      },
    );
  }
}

class FavoritesProductEmpty extends StatelessWidget {
  const FavoritesProductEmpty({
    super.key,
    required this.wMQ,
  });

  final double wMQ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hey! Your Favorites is empty!',
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }
}
