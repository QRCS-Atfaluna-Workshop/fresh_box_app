import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_theme.dart';
import 'fake_api.dart';

class HisnController extends GetxController {
  final chapters   = <HisnChapterModel>[].obs;
  final isLoading  = true.obs;
  final search     = ''.obs;

  List<HisnChapterModel> get filtered => search.value.isEmpty
      ? chapters
      : chapters.where((c) => c.title.contains(search.value)).toList();

  @override
  void onInit() { super.onInit(); load(); }

  Future<void> load() async {
    isLoading.value = true;
    chapters.value = await FakeApiService.getHisnChapters();
    isLoading.value = false;
  }
}

class HisnScreen extends StatelessWidget {
  const HisnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(HisnController());

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160.h,
            backgroundColor: const Color(0xFFFF6B6B),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF9800)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('حصن المسلم',
                          style: TextStyle(color: Colors.white, fontSize: 24.sp,
                            fontWeight: FontWeight.w900)),
                        SizedBox(height: 4.h),
                        Text('أذكار وأدعية من السنة النبوية',
                          style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
                child: TextField(
                  onChanged: (v) => ctrl.search.value = v,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن ذكر...',
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
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
            return SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _ChapterCard(chapter: ctrl.filtered[i]),
                  childCount: ctrl.filtered.length,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  final HisnChapterModel chapter;
  const _ChapterCard({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => _HisnDetailScreen(chapter: chapter)),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
            blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w, height: 44.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B6B), Color(0xFFFF9800)]),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text('${chapter.id}',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp,
                    fontWeight: FontWeight.w800)),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chapter.title,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
                  SizedBox(height: 3.h),
                  Text('${chapter.adhkar.length} ذكر',
                    style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.chevron_left_rounded, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}

class _HisnDetailScreen extends StatelessWidget {
  final HisnChapterModel chapter;
  const _HisnDetailScreen({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B6B),
        title: Text(chapter.title,
          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: chapter.adhkar.map((z) => Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(z.text,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 16.sp, height: 1.8, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
              SizedBox(height: 12.h),
              Row(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B6B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(z.source,
                    style: TextStyle(fontSize: 11.sp, color: const Color(0xFFFF6B6B),
                      fontWeight: FontWeight.w600)),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text('${z.count}×',
                    style: TextStyle(fontSize: 11.sp, color: AppColors.primary,
                      fontWeight: FontWeight.w700)),
                ),
              ]),
            ],
          ),
        )).toList(),
      ),
    );
  }
}
