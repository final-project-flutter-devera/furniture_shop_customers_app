import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Widgets/ShowAlertDialog.dart';
import 'Profile/EditInfo.dart';
import 'SearchScreen.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;

  const ProfileScreen({super.key, required this.documentId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    final wMQ = MediaQuery.of(context).size.width;
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous
          ? anonymous.doc(widget.documentId).get()
          : customers.doc(widget.documentId).get(),
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
            backgroundColor: AppColor.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColor.white,
              leading: AppBarButtonPush(
                aimRoute: const SearchScreen(),
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
            body: Padding(
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
                            child: data['profileimage'] == ''
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
                                      data['profileimage'],
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
                                    text: data['name'] == ''
                                        ? 'Guest'.toUpperCase()
                                        : data['name'].toUpperCase(),
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  const TextSpan(text: '\n'),
                                  TextSpan(
                                    text: data['email'] == ''
                                        ? 'Anonymous'
                                        : data['email'],
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditInfo(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 80,
                              width: wMQ,
                              decoration: const BoxDecoration(
                                color: AppColor.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.grey,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset(0, 7),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'My order \n',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    'Alreadyyyyyyyyyyyyyyyyyyy',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios),
                                  ],
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
            ),
          );
          // Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
