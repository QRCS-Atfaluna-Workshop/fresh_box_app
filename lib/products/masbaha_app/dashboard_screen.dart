import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_theme.dart';
import 'fake_api.dart';

class DashboardController extends GetxController {
  final stats     = Rx<Map<String, dynamic>>({});
  final isLoading = true.obs;

  @override
  void onInit() { super.onInit(); load(); }

  Future<void> load() async {
    isLoading.value = true;
    stats.value = await FakeApiService.getDashboardStats();
    isLoading.value = false;
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(DashboardController());

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 140.h,
            backgroundColor: AppColors.dark,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.dark, Color(0xFF1B3A5C)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('لوحة الإدارة',
                              style: TextStyle(color: Colors.white, fontSize: 22.sp,
                                fontWeight: FontWeight.w900)),
                            SizedBox(height: 4.h),
                            Text('إحصائيات التطبيق',
                              style: TextStyle(color: Colors.white54, fontSize: 13.sp)),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: const Icon(Icons.admin_panel_settings_rounded,
                            color: AppColors.primary, size: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Obx(() {
            if (ctrl.isLoading.value) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator(color: AppColors.primary)));
            }
            final s = ctrl.stats.value;
            return SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 14.w,
                      mainAxisSpacing: 14.h,
                      childAspectRatio: 1.3,
                      children: [
                        _StatCard(
                          label: 'إجمالي المستخدمين',
                          value: '${s['totalUsers'] ?? 0}',
                          icon: Icons.people_alt_rounded,
                          color: AppColors.secondary,
                        ),
                        _StatCard(
                          label: 'نشطون اليوم',
                          value: '${s['activeToday'] ?? 0}',
                          icon: Icons.online_prediction_rounded,
                          color: AppColors.success,
                        ),
                        _StatCard(
                          label: 'إجمالي التسبيحات',
                          value: _formatNum(s['totalSebha'] ?? 0),
                          icon: Icons.radio_button_checked_rounded,
                          color: AppColors.primary,
                        ),
                        _StatCard(
                          label: 'الذكر الأكثر',
                          value: '🏆',
                          icon: Icons.star_rounded,
                          color: AppColors.warning,
                          subtitle: s['topZikr'] ?? '',
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    Text('آخر النشاطات',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary)),
                    SizedBox(height: 12.h),
                    ..._activities.map((a) => _ActivityTile(
                      icon: a['icon'] as IconData,
                      title: a['title'] as String,
                      sub: a['sub'] as String,
                      time: a['time'] as String,
                      color: a['color'] as Color,
                    )),

                    SizedBox(height: 24.h),

                    Text('أكثر المستخدمين تسبيحاً',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary)),
                    SizedBox(height: 12.h),
                    ..._topUsers.map((u) => _UserRankTile(user: u)),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatNum(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  static final _activities = [
    {'icon': Icons.person_add_alt_1_rounded, 'title': 'مستخدم جديد انضم',
     'sub': 'أحمد محمد', 'time': 'منذ 5 دقائق', 'color': AppColors.success},
    {'icon': Icons.radio_button_checked_rounded, 'title': 'تسبيح مكتمل 100×',
     'sub': 'الاء عزوم', 'time': 'منذ 12 دقيقة', 'color': AppColors.primary},
    {'icon': Icons.auto_awesome_rounded, 'title': 'أذكار الصباح مكتملة',
     'sub': 'مها مروان', 'time': 'منذ 30 دقيقة', 'color': const Color(0xFFFF9800)},
  ];

  static final _topUsers = [
    {'rank': 1, 'name': 'أحمد محمد', 'count': '12,450', 'badge': '🥇'},
    {'rank': 2, 'name': 'الاء عزوم',  'count': '9,820',  'badge': '🥈'},
    {'rank': 3, 'name': ' مها مروان', 'count': '7,340',  'badge': '🥉'},
    {'rank': 4, 'name': 'فاطمة أحمد', 'count': '5,110', 'badge': '4️⃣'},
  ];
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final String? subtitle;
  final IconData icon;
  final Color color;
  const _StatCard({required this.label, required this.value,
    required this.icon, required this.color, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [BoxShadow(color: color.withOpacity(0.12), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(value,
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w900, color: color)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
              if (subtitle != null)
                Text(subtitle!,
                  style: TextStyle(fontSize: 10.sp, color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title, sub, time;
  final Color color;
  const _ActivityTile({required this.icon, required this.title,
    required this.sub, required this.time, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Row(children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
            Text(sub, style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
          ]),
        ),
        Text(time, style: TextStyle(fontSize: 10.sp, color: AppColors.textLight)),
      ]),
    );
  }
}

class _UserRankTile extends StatelessWidget {
  final Map<String, dynamic> user;
  const _UserRankTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Row(children: [
        Text(user['badge'] as String, style: TextStyle(fontSize: 22.sp)),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(user['name'] as String,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text('${user['count']} تسبيحة',
            style: TextStyle(fontSize: 11.sp, color: AppColors.primary,
              fontWeight: FontWeight.w700)),
        ),
      ]),
    );
  }
}
