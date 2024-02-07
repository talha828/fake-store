import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_store/view/dashboard_screen/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validation_plus/validate.dart';

class Auth {
  static signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required double width,
    var setLoading,
  }) async {
    bool isValidEmail = _validateEmail(email, width);
    bool isValidPassword = _validatePassword(password, width);
    bool isMatchingPassword =
        _validateMatchingPassword(password, confirmPassword, width);

    if (isValidEmail && isValidPassword && isMatchingPassword) {
      setLoading(true);
        FirebaseApp secondaryApp = Firebase.app('Fake Store');
        FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .catchError((e) async {

              Get.snackbar(
                    "Authentication Failed",
                    e.toString(),
                    duration: const Duration(seconds: 5),
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.symmetric(
                        vertical: width * 0.05, horizontal: width * 0.05),
                  );
            });


        final prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);
        prefs.setString("name", name);
        prefs.setString("password", password);
        setLoading(false);
        Get.to(const DashboardScreen());

    }
  }

  static login({
    required String email,
    required String password,
    var setLoading,
    required double width,
  }) async {
    bool isValidEmail = _validateEmail(email, width);
    bool isValidPassword = _validatePassword(password, width);

    if (isValidEmail && isValidPassword) {
      setLoading(true);
      try {
        FirebaseApp secondaryApp = Firebase.app('Fake Store');
        FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);
        UserCredential userCredential = await auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .catchError((e) {
          Get.snackbar(
            "Authentication Failed",
            e.toString(),
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.symmetric(
                vertical: width * 0.05, horizontal: width * 0.05),
          );
        });

        setLoading(false);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);
        prefs.setString("password", password);
        Get.to(const DashboardScreen());
      } catch (e) {
        setLoading(false);
        Get.snackbar(
          "Login Failed",
          "Please check your email and password",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.symmetric(
              vertical: width * 0.05, horizontal: width * 0.05),
        );
      }
    }
  }

  static bool _validateEmail(String email, double width) {
    if (Validate.isValidEmail(email)) {
      return true;
    } else {
      Get.snackbar(
        "Invalid Email",
        "Please Provide Valid Email",
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(
            vertical: width * 0.05, horizontal: width * 0.05),
      );
      return false;
    }
  }

  static bool _validatePassword(String password, double width) {
    if (Validate.isValidPassword(password)) {
      return true;
    } else {
      Get.snackbar(
        "Incorrect password",
        "Min 6 and Max 12 characters At least one uppercase characterAt least one lowercase characterAt least one numberAt least one special character [@#!%?]",
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(
            vertical: width * 0.05, horizontal: width * 0.05),
      );
      return false;
    }
  }

  static bool _validateMatchingPassword(
      String password, String confirmPassword, double width) {
    if (password == confirmPassword) {
      return true;
    } else {
      Get.snackbar(
        "password not match",
        "Fill correct password",
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(
            vertical: width * 0.05, horizontal: width * 0.05),
      );
      return false;
    }
  }
}
