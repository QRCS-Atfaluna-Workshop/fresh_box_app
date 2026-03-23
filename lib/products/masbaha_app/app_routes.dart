import 'package:get/get.dart';

import 'auth_screen.dart';
import 'azkar_screen.dart';
import 'dashboard_screen.dart';
import 'hisn_screen.dart';
import 'home_screen.dart';
import 'masbaha_screen.dart';
import 'splash_screen.dart';
class AppRoutes {
  static const splash    = '/';
  static const auth      = '/auth';
  static const home      = '/home';
  static const masbaha   = '/masbaha';
  static const azkar     = '/azkar';
  static const hisn      = '/hisn';
  static const dashboard = '/dashboard';

  static final pages = [
    GetPage(name: splash,    page: () => const SplashScreen()),
    GetPage(name: auth,      page: () => const AuthScreen()),
    GetPage(name: home,      page: () => const HomeScreen()),
    GetPage(name: masbaha,   page: () => const MasbahaScreen()),
    GetPage(name: azkar,     page: () => const AzkarScreen()),
    GetPage(name: hisn,      page: () => const HisnScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
  ];
}
