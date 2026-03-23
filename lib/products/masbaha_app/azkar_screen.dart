import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_theme.dart';
import 'fake_api.dart';

class AzkarController extends GetxController {
  final morningList  = <ZikrModel>[].obs;
  final eveningList  = <ZikrModel>[].obs;
  final morningDone  = <int>{}.obs;
  final eveningDone  = <int>{}.obs;
  final isLoading    = true.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    morningList.value = await FakeApiService.getMorningAzkar();
    eveningList.value = await FakeApiService.getEveningAzkar();
    isLoading.value = false;
  }

  void toggleMorning(int id) {
    if (morningDone.contains(id)) {
      morningDone.remove(id);
    } else {
      morningDone.add(id);
    }
  }

  void toggleEvening(int id) {
    if (eveningDone.contains(id)) {
      eveningDone.remove(id);
    } else {
      eveningDone.add(id);
    }
  }

  double get morningProgress =>
      morningList.isEmpty ? 0 : morningDone.length / morningList.length;
  double get eveningProgress =>
      eveningList.isEmpty ? 0 : eveningDone.length / eveningList.length;
}

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AzkarController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            SliverAppBar(
              pinned: true,
              expandedHeight: 150.h,
              backgroundColor: AppColors.gradientStart,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFFF6B6B)],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الأذكار اليومية',
                            style: TextStyle(color: Colors.white, fontSize: 22.sp,
                              fontWeight: FontWeight.w900)),
                          SizedBox(height: 4.h),
                          Text('حافظ على أذكارك كل يوم 🌙',
                            style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: Container(
                  margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: const Color(0xFFFF9800),
                    unselectedLabelColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                    tabs: const [
                      Tab(text: '☀️  أذكار الصباح'),
                      Tab(text: '🌙  أذكار المساء'),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: Obx(() {
            if (ctrl.isLoading.value) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            return TabBarView(
              children: [
                _ZikrList(
                  items: ctrl.morningList,
                  done: ctrl.morningDone,
                  progress: ctrl.morningProgress,
                  onToggle: ctrl.toggleMorning,
                  color: const Color(0xFFFF9800),
                ),
                _ZikrList(
                  items: ctrl.eveningList,
                  done: ctrl.eveningDone,
                  progress: ctrl.eveningProgress,
                  onToggle: ctrl.toggleEvening,
                  color: const Color(0xFF6C63FF),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _ZikrList extends StatelessWidget {
  final List<ZikrModel> items;
  final Set<int> done;
  final double progress;
  final void Function(int) onToggle;
  final Color color;

  const _ZikrList({
    required this.items, required this.done, required this.progress,
    required this.onToggle, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10)],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('تقدمك',
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  Text('${done.length} / ${items.length}',
                    style: TextStyle(fontSize: 13.sp, color: color, fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(height: 8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8.h,
                  backgroundColor: Colors.grey.shade100,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ],
          ),
        ),
        ...items.map((z) => _ZikrCard(
          zikr: z,
          isDone: done.contains(z.id),
          color: color,
          onTap: () => onToggle(z.id),
        )),
      ],
    );
  }
}

class _ZikrCard extends StatelessWidget {
  final ZikrModel zikr;
  final bool isDone;
  final Color color;
  final VoidCallback onTap;

  const _ZikrCard({required this.zikr, required this.isDone,
    required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: isDone ? color.withOpacity(0.07) : Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: isDone ? Border.all(color: color.withOpacity(0.3)) : null,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04),
              blurRadius: 8, offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.w, height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? color : Colors.grey.shade100,
                border: isDone ? null : Border.all(color: Colors.grey.shade300),
              ),
              child: isDone
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                : null,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(zikr.text,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 14.sp, height: 1.7,
                      color: isDone ? AppColors.textSecondary : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                      decorationColor: color),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.bookmark_outline_rounded,
                        size: 12, color: AppColors.textLight),
                      SizedBox(width: 4.w),
                      Text(zikr.source,
                        style: TextStyle(fontSize: 10.sp, color: AppColors.textLight)),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text('${zikr.count}×',
                          style: TextStyle(fontSize: 10.sp, color: color,
                            fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
