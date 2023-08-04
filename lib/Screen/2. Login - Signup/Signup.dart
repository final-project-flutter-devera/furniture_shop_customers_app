import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Login.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Widgets/CheckValidation.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Widgets/MyMessageHandler.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Widgets/TextLoginWidget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/Colors.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _repasswordController = TextEditingController();

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String name;
  late String email;
  late String pass;
  late String repass;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool visiblePassword = false;

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
                                    controller: _nameController,
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
                                    controller: _emailController,
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
                                    controller: _passwordController,
                                    onChanged: (valuepass) {
                                      repass = valuepass;
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
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        MyMessageHandler.showSnackBar(
                                          _scaffoldKey,
                                          'Please enter your re - password',
                                        );
                                      }
                                      if (value != repass) {
                                        MyMessageHandler.showSnackBar(
                                          _scaffoldKey,
                                          're - password does not match',
                                        );
                                      }
                                      return null;
                                    },
                                    obscureText: !visiblePassword,
                                    controller: _repasswordController,
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
                              child: GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      name = _nameController.text;
                                      email = _emailController.text;
                                      pass = _passwordController.text;
                                      repass = _repasswordController.text;
                                    });
                                  } else {
                                    MyMessageHandler.showSnackBar(
                                      _scaffoldKey,
                                      'Please fill all fields',
                                    );
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: wMQ * 0.65,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
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
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => const Login()));
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
