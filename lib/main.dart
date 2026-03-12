import 'package:flutter/material.dart';
import 'package:pro/products/dikr_screen.dart';
import 'package:pro/task6.dart';

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
      theme: ThemeData(fontFamily: 'Arial', primarySwatch: Colors.blue),
      home:
      MasbahaScreen(),
      // MyWidget(),
      // PopularFoodScreen(),
      // Fourth2App(),
      // SignUpScreen(),
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
