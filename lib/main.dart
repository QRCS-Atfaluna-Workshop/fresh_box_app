import 'package:flutter/material.dart';
import 'package:pro/products/Products_app.dart';
import 'package:pro/products/food_app.dart';
import 'package:pro/products/login_screen.dart';
import 'package:pro/products/sign_up_screen.dart';
import 'package:pro/task1.dart';
import 'package:pro/task4.dart';
import 'package:pro/task2.dart';
import 'package:pro/task3.dart';
import 'package:pro/task4_2.dart';
import 'package:pro/task5.dart' show MyUltimateApp;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
      // PopularFoodScreen(),
      // Fourth2App(),
      SignUpScreen(),
      // FourthApp(),
      // ThirdthApp (),
      // SecondApp (),
      // MyUltimateApp(),
      // FirstApp(),
      // MoreScreen(),
      // FoodApp(),
      // LoginScreen(), 
      //  NotificationsScreen(), 
    );
  }
}
