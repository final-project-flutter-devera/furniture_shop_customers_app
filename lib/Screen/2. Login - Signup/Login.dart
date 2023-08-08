import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Signup.dart';
import 'package:furniture_shop/Widgets/CheckValidation.dart';
import 'package:furniture_shop/Widgets/MyMessageHandler.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/Colors.dart';
import '../../Widgets/LogoLoginSignup.dart';
import '../../Widgets/SocialLogin.dart';
import '../../Widgets/TextLoginWidget.dart';
import '../3.CustomerHomeScreen/Screen/CustomerHomeScreen.dart';
import 'LoginSupplier.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visiblePassword = false;
  late String email;
  late String pass;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool processingGuest = false;
  bool processingAccountMail = false;

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        processingAccountMail = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
        _formKey.currentState!.reset();
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/Customer_screen');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          MyMessageHandler.showSnackBar(
            _scaffoldKey,
            'User not found',
          );
          setState(() {
            processingAccountMail = false;
          });
        } else if (e.code == 'wrong-password') {
          MyMessageHandler.showSnackBar(
            _scaffoldKey,
            'Your password provided is wrong',
          );
          setState(() {
            processingAccountMail = false;
          });
        }
      }
    } else {
      MyMessageHandler.showSnackBar(
        _scaffoldKey,
        'Please fill al fields',
      );
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoLoginSignup(wMQ: wMQ),
                  const TextLoginSignup(
                    label: 'Hello \n',
                    label2: 'WELCOME BACK',
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
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    decoration: InputDecoration(
                                      labelText: 'Mail',
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
                              padding: const EdgeInsets.all(10),
                              child: processingAccountMail == true
                                  ? const CircularProgressIndicator()
                                  : GestureDetector(
                                      onTap: signIn,
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
                                            'Log in',
                                            style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SocialLogin(
                                  image: 'assets/Images/Icons/google.jpg',
                                  label: 'Google',
                                  onPressed: () {},
                                ),
                                SocialLogin(
                                  image: 'assets/Images/Icons/fb.png',
                                  label: 'Facebook',
                                  onPressed: () {},
                                ),
                                processingGuest == true
                                    ? const CircularProgressIndicator()
                                    : SocialLogin(
                                        image: 'assets/Images/Icons/guest.png',
                                        label: 'Guest',
                                        onPressed: () async {
                                          setState(() {
                                            processingGuest = true;
                                          });
                                          await FirebaseAuth.instance
                                              .signInAnonymously();
                                          if (context.mounted) {
                                            Navigator.pushReplacementNamed(
                                                context, '/Customer_screen');
                                          }
                                        },
                                      ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, '/Signup_cus');
                                },
                                child: Text(
                                  'SIGN UP',
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF303030),
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
                                    Navigator.pushReplacementNamed(context, '/Login_sup');
                                  },
                                  child: Text(
                                    'SUPPLIER LOGIN',
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
