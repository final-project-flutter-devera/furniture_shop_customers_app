import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Objects/customer.dart';
import 'package:furniture_shop/Providers/Auth_reponse.dart';
import 'package:furniture_shop/Providers/customer_provider.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/my_review/my_review.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/my_shipping_address/my_shipping_address.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/following_store/following_store.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Login.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Widgets/ShowAlertDialog.dart';
import '../../../13. MyOrderScreen/My_Order_Screen.dart';
import 'Profile/EditInfo.dart';
import 'home_screen/components/search_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customer =
      FirebaseFirestore.instance.collection('Customers');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  late Customer _customer;
  bool isLoading = true;

  _getCurrentCustomer() async {
    _customer = await context.read<CustomerProvider>().getCurrentCustomer();
    setState(() {
      isLoading = false;
    });
  }

  var isAnonymous;
  @override
  void initState() {
    isAnonymous = FirebaseAuth.instance.currentUser!.isAnonymous;
    _getCurrentCustomer();
    /*FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
        setState(() {
          documentId = user.uid;
        });
      }
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wMQ = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          leading: AppBarButtonPush(
            aimRoute: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductSearch()));
            },
            icon: SvgPicture.asset(
              'assets/Images/Icons/search.svg',
              height: 24,
              width: 24,
            ),
          ),
          title: const AppBarTitle(label: 'Profile'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/Images/Icons/Logout.svg',
                  height: 24, width: 24),
              onPressed: () async {
                MyAlertDialog.showMyDialog(
                  context: context,
                  title: 'Log out',
                  content: 'Are you sure log out?',
                  tabNo: () {
                    Navigator.pop(context);
                  },
                  tabYes: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, '/Welcome_boarding');
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: isAnonymous
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Must login for more features'),
                    MaterialButton(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: AppColor.white),
                        ),
                        color: AppColor.black,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        }),
                  ],
                ),
              )
            : isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : () {
                    List tabRoute = [
                      const MyOrderScreen(),
                      MyShippingAddress(
                        currentCustomer: _customer,
                      ),
                      null,
                      MyReview(),
                      FollowingStore(
                        currentCustomer: _customer,
                      ),
                      null
                    ];
                    List<String> tabName = [
                      context.localize('my_order_option'),
                      context.localize('shipping_addresses_option'),
                      context.localize('payment_methods_option'),
                      context.localize('my_reviews_option'),
                      context.localize('followed_suppliers_option'),
                      context.localize('setting_option'),
                    ];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColor.amber,
                                    radius: 45,
                                    child: _customer.profileimage == null ||
                                            _customer.profileimage == ''
                                        ? const CircleAvatar(
                                            backgroundColor: AppColor.white,
                                            radius: 40,
                                            backgroundImage: AssetImage(
                                                'assets/Images/Images/avatarGuest.jpg'),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: AppColor.white,
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                              _customer.profileimage!,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: wMQ * 0.5,
                                    child: Text.rich(
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: _customer.name == ''
                                                ? 'Guest'.toUpperCase()
                                                : _customer.name.toUpperCase(),
                                            style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black,
                                            ),
                                          ),
                                          const TextSpan(text: '\n'),
                                          TextSpan(
                                            text: _customer.email == ''
                                                ? 'Anonymous'
                                                : _customer.email,
                                            style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    isAnonymous
                                        ? Navigator.pushNamed(
                                            context, '/Login_cus')
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditInfo(
                                                customer: _customer,
                                              ),
                                            ),
                                          );
                                  },
                                  icon: SvgPicture.asset(
                                      'assets/Images/Icons/edit.svg')),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: tabName.length,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      isAnonymous
                                          ? Navigator.pushNamed(
                                              context, '/Login_cus')
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      tabRoute[index]));
                                    },
                                    child: PhysicalModel(
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.grey,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 80,
                                          width: wMQ,
                                          decoration: const BoxDecoration(
                                            color: AppColor.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  tabName[index],
                                                  style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18),
                                                ),
                                                const Icon(
                                                    Icons.arrow_forward_ios),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }());
    // Tex
  }
}
