import 'dart:async';
import 'package:fake_store/generated/assets.dart';
import 'package:fake_store/view/dashboard_screen/dashboard_screen.dart';
import 'package:fake_store/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  autoLogin() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    String? username = prefer.getString("email");
    String? password = prefer.getString("password");

      if (username != null && password != null && username != "null" && password != "null") {
        Get.to(const DashboardScreen());
      }else{
        Get.to(const LoginScreen());
      }
    }


  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
          () => autoLogin()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.logoLogo,
          scale: 3,
        ),
      ),
    );
  }
}
