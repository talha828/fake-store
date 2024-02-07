import 'dart:async';

import 'package:fake_store/constant/constant.dart';
import 'package:fake_store/generated/assets.dart';
import 'package:fake_store/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Fake Store",
    options: const FirebaseOptions(
        appId: '1:972122140698:android:fd48f8c6875a463938e1a3',
        apiKey: 'AIzaSyD2UGPoQvAq9Fbq86Tj12GUn0BjpDmJOuc',
        messagingSenderId: '972122140698',
        projectId: 'fake-store-1f625'
    )
  );
  Firebase.app("Fake Store");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryTextTheme:
            GoogleFonts.mulishTextTheme(Theme.of(context).textTheme),
        primarySwatch: createMaterialColor(themeColorDart),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
