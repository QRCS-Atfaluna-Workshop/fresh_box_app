import 'package:flutter/material.dart';
import 'package:pro/products/Products_app.dart';
import 'package:pro/products/login_screen.dart';
import 'package:pro/task1.dart';

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
      home:FirstApp(),
      // MoreScreen(),
      // FoodApp(),
      // LoginScreen(), 
      //  NotificationsScreen(), 
    );
  }
}
