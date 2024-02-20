import 'dart:io';
import 'package:fake_store/constant/constant.dart';
import 'package:fake_store/firebase/auth.dart';
import 'package:fake_store/generated/assets.dart';
import 'package:fake_store/view/login_screen/login_screen.dart';
import 'package:fake_store/widgets/fake_button.dart';
import 'package:fake_store/widgets/faketextfield.dart';
import 'package:fake_store/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String hintText = "xyz01@gmail.com";
  String labelText = "Email";
  String countryText = 'Select Your Country';
  bool obscureText = true;
  bool isLoading = false;

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.04, horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Image.asset(
                      Assets.imageSignup,
                      height: width * 0.4,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    Text(
                      "Sign Up",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.08),
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    FakeTextField(
                        obscureText: false,
                        controller: name,
                        hintText: "Talha Iqbal",
                        labelText: "Name"),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    FakeTextField(
                        obscureText: false,
                        controller: email,
                        hintText: "xzy01@gmail.com",
                        labelText: "Email"),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    FakeTextField(
                      obscureText: obscureText,
                      controller: password,
                      hintText: "pass@11",
                      labelText: "Password",
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: width * 0.04),
                        child: InkWell(
                            onTap: () => setState(() {
                                  obscureText = obscureText ? false : true;
                                }),
                            child: FaIcon(obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash)),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    FakeTextField(
                        obscureText: obscureText,
                        controller: confirmPassword,
                        hintText: "pass@11",
                        labelText: "Confirm Password"),
                    SizedBox(
                      height: width * 0.2,
                    ),
                    FakeButton(onTap: ()=> Auth.signUp(
                                name: name.text,
                                email: email.text,
                                password: password.text,
                                confirmPassword: confirmPassword.text,
                                width: width,
                                setLoading: (bool value){setState(() {isLoading=value;});}), width: width, title: "SignUp Now"),
                    SizedBox(
                      height: width * 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () => Get.to(const LoginScreen()),
                          child: const Text(
                            "Sign In",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: themeColorDart,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            isLoading
                ? const Positioned.fill(child: LoadingIndicator())
                : Container()
          ],
        ),
      ),
    );
  }
}
