import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Login.dart';
import 'package:furniture_shop/Widgets/CheckValidation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/Colors.dart';
import '../../Widgets/MyMessageHandler.dart';
import '../4. SupplierHomeScreen/Screen/SupplierHomeScreen.dart';

class LoginSupplier extends StatefulWidget {
  const LoginSupplier({super.key});

  @override
  State<LoginSupplier> createState() => _LoginSupplierState();
}

class _LoginSupplierState extends State<LoginSupplier> {
  bool visiblePassword = false;
  late String email;
  late String pass;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void signIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
        final User? user = FirebaseAuth.instance.currentUser;
        final userID = user!.uid;
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(userID)
            .get()
            .then((DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            if (snapshot.get('role') == "supplier") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupplierHomeScreen(),
                ),
              );
            }
          }
        });
      } else {
        MyMessageHandler.showSnackBar(_scaffoldKey, 'Please fill all fields');
      }
      _formKey.currentState!.reset();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MyMessageHandler.showSnackBar(
          _scaffoldKey,
          'Your email provided not found',
        );
      } else if (e.code == 'wrong-password') {
        MyMessageHandler.showSnackBar(
          _scaffoldKey,
          'Your password provided is wrong',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double wMQ = MediaQuery.of(context).size.width;

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                color: Colors.black,
                                height: 1,
                                width: wMQ * 0.25),
                            SvgPicture.asset(
                              'assets/Images/Icons/SofaLogin.svg',
                              height: 100,
                              width: 100,
                            ),
                            Container(
                                color: Colors.black,
                                height: 1,
                                width: wMQ * 0.25),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'HELLO !\n',
                            style: GoogleFonts.merriweather(
                              color: const Color(0xFF909090),
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                          TextSpan(
                            text: 'MY CUTE SUPPLIER',
                            style: GoogleFonts.merriweather(
                              color: const Color(0xFF303030),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1.88,
                              letterSpacing: 1.20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        MyMessageHandler.showSnackBar(
                                          _scaffoldKey,
                                          'please enter your email',
                                        );
                                        return 'please enter your email';
                                      } else if (value.isValidEmail() ==
                                          false) {
                                        MyMessageHandler.showSnackBar(
                                          _scaffoldKey,
                                          'invalid email',
                                        );
                                        return 'invalid email';
                                      } else if (value.isValidEmail() == true) {
                                        return null;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF909090),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        pass = value;
                                      });
                                    },
                                    obscureText: !visiblePassword,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF909090),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            visiblePassword = !visiblePassword;
                                          });
                                        },
                                        icon: Icon(visiblePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forgot Password',
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF303030),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: GestureDetector(
                                onTap: signIn,
                                child: Container(
                                  height: 50,
                                  width: wMQ * 0.65,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Log in',
                                      style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: MaterialButton(
                                  height: 50,
                                  color: AppColor.grey,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'CUSTOMER LOGIN',
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
