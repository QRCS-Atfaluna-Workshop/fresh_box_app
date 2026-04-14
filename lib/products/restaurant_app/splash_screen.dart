import 'package:flutter/material.dart';
import 'package:pro/products/restaurant_app/food_widgets.dart';
import 'package:pro/products/restaurant_app/food_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro/products/restaurant_app/froget_pass_screen.dart';
import 'package:pro/products/restaurant_app/sign_up_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {

//   double opacity = 0;

//   @override
//   void initState() {
//     super.initState();
//     _start();
//   }

//   void _start() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     setState(() => opacity = 1);

//     await Future.delayed(const Duration(seconds: 2));

//     final prefs = await SharedPreferences.getInstance();
//     final seen = prefs.getBool('seenOnboarding') ?? false;

//     if (seen) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const PopularFoodScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const OnboardingScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedOpacity(
//           duration: const Duration(milliseconds: 800),
//           opacity: opacity,
//           child:
//           SvgPicture.asset(
//                         'assets/images/logo.svg',
//                         width: 80,
//                         height: 80,),

       
//         ),
//       ),
//     );
//   }
// }

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int index = 0;

  final pages = [
    {
      "image": "assets/images/Onboarding_1.svg",
      "title": "Order Food Around You",
      "desc": "When you order, we’ll hook you up with exclusive coupons"
    },
    {
      "image": "assets/images/Onboarding_2.svg",
      "title": "Receive the Great Food",
      "desc": "We deliver the best food within an hour"
    },
    {
      "image": "assets/images/Onboarding_3.svg",
      "title": "Hot Delivery to Home",
      "desc": "Fast delivery to your doorstep"
    },
  ];

  // void finishOnboarding() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('seenOnboarding', true);

  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (_) => const PopularFoodScreen()),
  //   );
  // }
  void finishOnboarding() {
  final box = GetStorage();

  box.write('seenOnboarding', true); 

  Get.offAll(() =>  SignUpScreen()); 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          const SizedBox(height: 60),

          RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Fresh',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.black, 
        ),
      ),
      TextSpan(
        text: 'BOX',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.red,
        ),
      ),
    ],
  ),
),


          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: pages.length,
              onPageChanged: (i) => setState(() => index = i),
              itemBuilder: (_, i) {
                final item = pages[i];
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    key: ValueKey(i),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// SVG IMAGE
                      SvgPicture.asset(
                        item['image']!,
                        height: 300,
                      ),

                      const SizedBox(height: 40),

                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          item['desc']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

         SmoothPageIndicator(
  controller: controller,
  count: pages.length,
  effect: ExpandingDotsEffect(
    dotHeight: 6,
    dotWidth: 6,
    expansionFactor: 3, 
    activeDotColor: Colors.black,
    dotColor: Colors.grey,
  ),
),


          const SizedBox(height: 20),

          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if (index != pages.length - 1)
        TextButton(
          onPressed: finishOnboarding,
          child: const Text('Skip', style: TextStyle(color: Colors.black)),
        )
      else
        const SizedBox(),

      if (index == pages.length - 1)
        Expanded(
          child: ElevatedButton(
            onPressed: finishOnboarding,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      else
        ElevatedButton(
          onPressed: () {
            controller.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(color: Colors.white),
          ),
        ),
    ],
  ),
),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => opacity = 1);

    await Future.delayed(const Duration(seconds: 2));

    bool seen = box.read('seenOnboarding') ?? false;
    bool isLogged = box.read('logged') ?? false;

    if (seen) {
      if (isLogged) {
        Get.offAll(() => const PopularFoodScreen());
      } else {
        Get.offAll(() =>  SignUpScreen());
      }
    } else {
      Get.offAll(() => const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: opacity,
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}

