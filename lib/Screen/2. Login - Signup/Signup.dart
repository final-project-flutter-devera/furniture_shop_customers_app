import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Objects/customer.dart';
import 'package:furniture_shop/Providers/Auth_reponse.dart';
import 'package:furniture_shop/Providers/customer_provider.dart';
import 'package:furniture_shop/Widgets/CheckValidation.dart';
import 'package:furniture_shop/Widgets/MyMessageHandler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Widgets/TextLoginWidget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String name;
  late String email;
  late String password;
  late String repass;
  late String _uid;
  bool processing = false;
  bool strongPass = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _pwController = TextEditingController();
  bool visiblePassword = false;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('Customers');
  CollectionReference checkUID = FirebaseFirestore.instance.collection('UID');

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      if (strongPass == true) {
        if (password == repass) {
          setState(() {
            processing = true;
          });
          try {
            await AuthRepo.signUpWithEmailAndPassword(email, password);
            await AuthRepo.updateDisplayName(name);
            await AuthRepo.sendVerificationEmail();

            Customer _customer = Customer(
              cid: FirebaseAuth.instance.currentUser!.uid,
              name: name,
              email: email,
              role: 'customer',
            );
            await customers.doc(FirebaseAuth.instance.currentUser!.uid).set(_customer.toJson());

            await checkUID.doc(email).set({'uid': FirebaseAuth.instance.currentUser!.uid});

            _formKey.currentState!.reset();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/Login_cus');
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              MyMessageHandler.showSnackBar(_scaffoldKey,
                  'The password provided is too week \n (at least 6 words)');
              setState(() {
                processing = false;
              });
            } else if (e.code == 'email-already-in-use') {
              await FirebaseFirestore.instance
                  .collection('Customers')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get()
                  .then((DocumentSnapshot snapshot) async {
                if (snapshot.exists) {
                  if (snapshot.get('role') == "customer") {
                    await AuthRepo.signInWithEmailAndPassword(email, password);
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(
                          context, '/Customer_screen');
                    }
                  }
                } else {
                  var uID = await FirebaseFirestore.instance
                      .collection('UID')
                      .doc(email)
                      .get();
                  await customers.doc(uID['uid']).set({
                    'name': name,
                    'email': email,
                    'phone': '',
                    'address': '',
                    'profileimage': '',
                    'role': 'customer',
                    'cid': uID['uid'],
                  });
                  _formKey.currentState!.reset();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/Login_cus');
                  }
                }
              });
            }
          }
        } else {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
            _scaffoldKey,
            'Please fill re-confirm password match password',
          );
        }
      } else {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(
          _scaffoldKey,
          'Password so weak, please refill new strong password!',
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
        resizeToAvoidBottomInset: true,
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
                  const TextLoginSignup(
                    label: 'Hello!\n',
                    label2: 'Let\'s Sign up',
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
                                          'Please enter your name',
                                        );
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
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
                                        MyMessageHandler.showSnackBar(
                                          _scaffoldKey,
                                          'Please enter your email',
                                        );
                                      } else if (value.isValidEmail() ==
                                          false) {
                                        MyMessageHandler.showSnackBar(
                                          _scaffoldKey,
                                          'invalid email',
                                        );
                                      } else if (value.isValidEmail() == true) {
                                        return null;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    textCapitalization:
                                        TextCapitalization.characters,
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
                                    onChanged: (value) {
                                      password = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        MyMessageHandler.showSnackBar(
                                          _scaffoldKey,
                                          'Please enter your password',
                                        );
                                      }
                                      return null;
                                    },
                                    controller: _pwController,
                                    obscureText: !visiblePassword,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: GoogleFonts.nunito(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF909090),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(visiblePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              visiblePassword =
                                                  !visiblePassword;
                                            });
                                          },
                                        )),
                                  ),
                                  FlutterPwValidator(
                                      width: MediaQuery.of(context).size.width,
                                      height: 90,
                                      minLength: 6,
                                      uppercaseCharCount: 1,
                                      specialCharCount: 1,
                                      onSuccess: () {
                                        print('Match');
                                        setState(() {
                                          strongPass = true;
                                        });
                                      },
                                      onFail: () {
                                        setState(() {
                                          strongPass = false;
                                        });
                                      },
                                      controller: _pwController),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        MyMessageHandler.showSnackBar(
                                          _scaffoldKey,
                                          'Please enter your re - password',
                                        );
                                      }
                                      if (password != repass) {
                                        MyMessageHandler.showSnackBar(
                                            _scaffoldKey,
                                            'Re-confirm pass does not match');
                                      }
                                      return null;
                                    },
                                    obscureText: !visiblePassword,
                                    onChanged: (value) {
                                      repass = value;
                                    },
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    decoration: InputDecoration(
                                        labelText: 'Re - Confirm Password',
                                        labelStyle: GoogleFonts.nunito(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF909090),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(visiblePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              visiblePassword =
                                                  !visiblePassword;
                                            });
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: processing == true
                                  ? const CircularProgressIndicator()
                                  : GestureDetector(
                                      onTap: () {
                                        signUp();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: wMQ * 0.65,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Sign up',
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
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have account?',
                                    style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/Login_cus');
                                    },
                                    child: Text(
                                      'SIGN IN',
                                      style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF303030),
                                      ),
                                    ),
                                  ),
                                ],
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
