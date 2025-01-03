import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_project/Auth/register.dart';
import 'package:vehicle_project/Auth/splashscreen.dart';
import 'package:vehicle_project/Auth/welcome_screen.dart';
import 'package:vehicle_project/Home/golden.dart';
import 'package:vehicle_project/Home/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lusail Number',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  const SplashScreen());
        // home:  WelcomeScreen());

  }
}
