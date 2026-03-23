import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_theme.dart';
import 'fake_api.dart';

class MasbahaController extends GetxController {
  final count       = 0.obs;
  final selectedIdx = 0.obs;
  final isLoading   = true.obs;
  final adhkar      = <ZikrModel>[].obs;

  ZikrModel? get current =>
      adhkar.isEmpty ? null : adhkar[selectedIdx.value];

  @override
  void onInit() {
    super.onInit();
    loadAdhkar();
  }

  Future<void> loadAdhkar() async {
    isLoading.value = true;
    adhkar.value = await FakeApiService.getMasbahaList();
    isLoading.value = false;
  }

  void increment() {
    HapticFeedback.lightImpact();
    count.value++;
  }

  void reset() {
    count.value = 0;
  }

  void changeZikr(int index) {
    selectedIdx.value = index;
    count.value = 0;
  }
}

class MasbahaScreen extends StatelessWidget {
  const MasbahaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(MasbahaController());

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<int>(
                      offset: Offset(0, 48.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                      color: Colors.white,
                      elevation: 8,
                      icon: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 8)],
                        ),
                        child: const Icon(Icons.tune_rounded, color: AppColors.textPrimary, size: 20),
                      ),
                      onSelected: ctrl.changeZikr,
                      itemBuilder: (_) => List.generate(ctrl.adhkar.length, (i) {
                        final z = ctrl.adhkar[i];
                        return PopupMenuItem<int>(
                          value: i,
                          child: Row(
                            children: [
                              Icon(
                                i == ctrl.selectedIdx.value
                                    ? Icons.radio_button_checked_rounded
                                    : Icons.radio_button_off_rounded,
                                color: AppColors.primary, size: 18,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(z.text.replaceAll('\n', ' '),
                                  style: TextStyle(fontSize: 13.sp,
                                    fontWeight: i == ctrl.selectedIdx.value
                                        ? FontWeight.w700 : FontWeight.w400)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                    Row(
                      children: [
                        Text('مَسْبَحَة',
                          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w900,
                            color: AppColors.primary)),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.gradientStart, AppColors.gradientEnd]),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(22.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withOpacity(0.08),
                        blurRadius: 16, offset: const Offset(0, 6)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.spa_rounded, color: AppColors.primary, size: 14),
                            SizedBox(width: 5.w),
                            Text('الذكر الحالي',
                              style: TextStyle(fontSize: 12.sp, color: AppColors.primary,
                                fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Obx(() => Text(
                        ctrl.current?.text ?? '',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary, height: 1.6),
                      )),
                      SizedBox(height: 12.h),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark_outline_rounded,
                            color: AppColors.textSecondary, size: 14),
                          SizedBox(width: 4.w),
                          Text(ctrl.current?.source ?? '',
                            style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text('${ctrl.current?.count ?? 0} مرة',
                              style: TextStyle(fontSize: 10.sp, color: AppColors.warning,
                                fontWeight: FontWeight.w700)),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 36.h),

              GestureDetector(
                onTap: ctrl.increment,
                child: Obx(() {
                  final progress = (ctrl.current?.count ?? 100) > 0
                      ? ctrl.count.value / (ctrl.current?.count ?? 100)
                      : 0.0;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 220.w, height: 220.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.primary.withOpacity(0.15),
                              AppColors.primary.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200.w, height: 200.w,
                        child: CircularProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          strokeWidth: 6,
                          backgroundColor: Colors.white,
                          valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                        ),
                      ),
                      Container(
                        width: 176.w, height: 176.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.gradientStart, Color(0xFF009B8A)],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${ctrl.count.value}',
                              style: TextStyle(fontSize: 58.sp, fontWeight: FontWeight.w900,
                                color: Colors.white, height: 1)),
                            SizedBox(height: 4.h),
                            Text('تسبيحة',
                              style: TextStyle(fontSize: 14.sp, color: Colors.white70)),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const Spacer(),

              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: GestureDetector(
                  onTap: ctrl.reset,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.08),
                          blurRadius: 12, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh_rounded, color: AppColors.primary, size: 20),
                        SizedBox(width: 8.w),
                        Text('إعادة الضبط',
                          style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
