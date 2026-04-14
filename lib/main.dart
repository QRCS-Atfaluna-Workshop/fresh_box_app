import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro/custom_text_field.dart';
import 'package:pro/products/masbaha_app/app_routes.dart';
import 'package:pro/products/masbaha_app/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pro/products/restaurant_app/food_app.dart';
import 'package:pro/products/restaurant_app/froget_pass_screen.dart';
import 'package:pro/products/restaurant_app/sign_up_screen.dart' hide AuthController;
import 'package:pro/products/restaurant_app/splash_screen.dart';
import 'package:pro/task13.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp( 
    MyApp222()
    // MyApp111()
    );
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
        return GetMaterialApp(

          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () =>LoginScreen()   , binding: AuthBinding(),

            //  const SplashScreen()
            ),
            GetPage(name: '/signup', page: () => SignUpScreen()),
            GetPage(name: '/login', page: () => LoginScreen()),
           
            GetPage(name: '/home', page: () => const PopularFoodScreen()),
          ],
          // home: const SplashScreen(),
        );
      },
    );
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Cairo', primarySwatch: Colors.blue),
          home:
              // OnboardingScreen(),
              // SignUpScreen(),
              SplashScreen(),
          // CounterScreen(),
          // Task11(),
          // ModernScreen(),
          // Task10(),
          // MoreScreen(),
          // MyUltimateApp(),
          // StoreScreen(),
          // HomePage(),
          // MasbahaScreen(),
          // MyWidget(),
          // PopularFoodScreen(),
          // Fourth2App(),
          // FourthApp(),
          // ThirdthApp (),
          // SecondApp (),
          // MyUltimateApp(),
          // FirstApp(),
          // MoreScreen(),
          // FoodApp(),
          // LoginScreen(),
          //  NotificationsScreen(),
          // LoginForm(),
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
// import 'package:flutter/material.dart';
// import 'custom_text_field.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter custom_text_field',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         useMaterial3: true,
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Login Screen")),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: LoginForm(),
//         ),
//       ),
//     );
//   }
// }

class LoginForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextField(
            label: "Email",
            hint: "Enter your Gmail",
            icon: Icons.email,
            controller: emailController,
            validator: (value) =>
                value!.isEmpty ? "Email cannot be empty" : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: "Password",
            hint: "Enter your password",
            icon: Icons.lock,
            obscureText: true,
            controller: passwordController,
            validator: (value) =>
                value!.length < 6 ? "Password must be at least 6 chars" : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              print("Email: ${emailController.text}");
              print("Password: ${passwordController.text}");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    'Data submitted successfully!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
