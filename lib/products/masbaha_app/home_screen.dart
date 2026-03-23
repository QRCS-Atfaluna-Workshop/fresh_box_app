import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_theme.dart';
import 'auth_controller.dart';
import 'azkar_screen.dart';
import 'dashboard_screen.dart';
import 'hisn_screen.dart';
import 'masbaha_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _auth = Get.find<AuthController>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const _HomePage(),
      const AzkarScreen(),
      const MasbahaScreen(),
      const HisnScreen(),
      if (_auth.isAdmin) const DashboardScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4)),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textLight,
            selectedLabelStyle: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(fontSize: 11.sp),
            elevation: 0,
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'الرئيسية'),
              const BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_rounded), label: 'الأذكار'),
              const BottomNavigationBarItem(icon: Icon(Icons.radio_button_checked_rounded), label: 'المسبحة'),
              const BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'حصن المسلم'),
              if (_auth.isAdmin)
                const BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'الإدارة'),
            ],
          ),
        ),
      ),
    );
  }
}


class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.gradientStart,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('السلام عليكم 👋',
                                  style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                                SizedBox(height: 4.h),
                                Text(auth.user.value?.name ?? 'الزائر',
                                  style: TextStyle(color: Colors.white, fontSize: 20.sp,
                                    fontWeight: FontWeight.w800)),
                              ],
                            )),
                            GestureDetector(
                              onTap: auth.logout,
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _HadithCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            title: Text('مَسْبَحَة',
              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800)),
          ),

          SliverPadding(
            padding: EdgeInsets.all(20.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الوصول السريع',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
                  SizedBox(height: 16.h),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 14.h,
                    childAspectRatio: 1.2,
                    children: const [
                      _QuickCard(icon: Icons.wb_sunny_rounded,  label: 'أذكار الصباح',
                        color: Color(0xFFFF9800), subLabel: 'ابدأ يومك بذكر الله'),
                      _QuickCard(icon: Icons.nights_stay_rounded, label: 'أذكار المساء',
                        color: Color(0xFF6C63FF), subLabel: 'اختم نهارك بالذكر'),
                      _QuickCard(icon: Icons.radio_button_checked_rounded, label: 'المسبحة',
                        color: Color(0xFF00B4A0), subLabel: 'سبّح واستغفر'),
                      _QuickCard(icon: Icons.menu_book_rounded, label: 'حصن المسلم',
                        color: Color(0xFFFF6B6B), subLabel: 'أدعية وأذكار يومية'),
                    ],
                  ),

                  SizedBox(height: 24.h),
                  Text('آية اليوم',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
                  SizedBox(height: 12.h),
                  _AyaCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HadithCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white30),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: Colors.white70, size: 20),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              '«خير الكلام بعد القرآن أربع: سبحان الله، والحمد لله، ولا إله إلا الله، والله أكبر»',
              style: TextStyle(color: Colors.white, fontSize: 11.sp, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final Color color;
  const _QuickCard({required this.icon, required this.label,
    required this.color, required this.subLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
              SizedBox(height: 2.h),
              Text(subLabel,
                style: TextStyle(fontSize: 10.sp, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AyaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A2332), Color(0xFF0D3B4F)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '﴿ وَاذْكُر رَّبَّكَ كَثِيرًا وَسَبِّحْ بِالْعَشِيِّ وَالْإِبْكَارِ ﴾',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.sp, height: 1.8,
              fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          Text('سورة آل عمران - آية 41',
            style: TextStyle(color: AppColors.primary, fontSize: 12.sp)),
        ],
      ),
    );
  }
}
