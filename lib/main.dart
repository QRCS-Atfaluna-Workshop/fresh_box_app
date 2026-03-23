import 'package:flutter/material.dart';
import 'package:pro/products/restaurant_app/products_app.dart';
import 'package:pro/products/masbaha_app/app_routes.dart';
import 'package:pro/products/masbaha_app/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MasbahaApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Cairo', primarySwatch: Colors.blue),
      home:
      MoreScreen(),
      // MyUltimateApp(),
      // StoreScreen(),
      // HomePage(),
      // MasbahaScreen(),
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
      },
    );
  }
}
class MasbahaApp extends StatelessWidget {
  const MasbahaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 14 base
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'مَسْبَحَة',
        theme: AppTheme.light,
        textDirection: TextDirection.rtl,
        locale: const Locale('ar', 'SA'),
        getPages: AppRoutes.pages,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pro/products/calc_app/app_theme.dart';
// import 'package:pro/products/calc_app/calculator_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Force dark status bar + dark nav bar
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarIconBrightness: Brightness.light,
//     systemNavigationBarColor: Color(0xFF0E0E14),
//   ));
//   // Portrait only
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   runApp(const CalcApp());
// }

// class CalcApp extends StatelessWidget {
//   const CalcApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, __) => GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'حاسبة',
//         theme: AppTheme.dark,
//         textDirection: TextDirection.rtl,
//         locale: const Locale('ar'),
//         home: const CalculatorScreen(),
//       ),
//     );
//   }
// }
