import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Signup.dart';
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
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    double wMQ = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoLoginSignup(wMQ: wMQ),
            const TextLoginSignup(
              label: 'Hello \n',
              label2: 'WELCOME BACK',
            ),
            Expanded(
              child: Padding(
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
                                    return 'Please enter your email';
                                  }
                                  return null;
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
                                obscureText: !visiblePassword,
                                controller: TextEditingController(),
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
                          child: GestureDetector(
                            onTap: () {},
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
                            processing == true
                                ? const CircularProgressIndicator()
                                : SocialLogin(
                                    image: 'assets/Images/Icons/guest.png',
                                    label: 'Guest',
                                    onPressed: () async {
                                      setState(() {
                                        processing = true;
                                      });
                                      await FirebaseAuth.instance
                                          .signInAnonymously();
                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CustomerHomeScreen(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Signup()));
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginSupplier(),
                                  ),
                                );
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
            ),
          ],
        ),
      ),
    );
  }
}
