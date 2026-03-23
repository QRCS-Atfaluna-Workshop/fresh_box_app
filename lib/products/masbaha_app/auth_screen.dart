import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app_theme.dart';
import 'auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  final _auth = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 280.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 28.h),
                const Icon(Icons.spa_rounded, color: Colors.white, size: 48),
                SizedBox(height: 8.h),
                Text('مَسْبَحَة',
                  style: TextStyle(color: Colors.white, fontSize: 28.sp,
                    fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 4.h),
                Text('مرحباً بك مجدداً 🌿',
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                SizedBox(height: 28.h),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        topRight: Radius.circular(32.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.w),
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.05),
                                blurRadius: 8),
                            ],
                          ),
                          child: TabBar(
                            controller: _tab,
                            indicator: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            unselectedLabelColor: AppColors.textSecondary,
                            labelStyle: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w700),
                            tabs: const [
                              Tab(text: 'تسجيل الدخول'),
                              Tab(text: 'إنشاء حساب'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tab,
                            children: [
                              _LoginTab(auth: _auth),
                              _SignUpTab(auth: _auth),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginTab extends StatelessWidget {
  final AuthController auth;
  const _LoginTab({required this.auth});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('مرحباً! 👋',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800,
              color: AppColors.textPrimary)),
          SizedBox(height: 4.h),
          Text('سجّل دخولك للمتابعة',
            style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
          SizedBox(height: 28.h),

          TextField(
            controller: auth.emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textDirection: TextDirection.ltr,
            decoration: const InputDecoration(
              labelText: 'البريد الإلكتروني',
              hintText: 'example@mail.com',
              prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
            ),
          ),
          SizedBox(height: 16.h),

          Obx(() => TextField(
            controller: auth.passCtrl,
            obscureText: auth.obscurePass.value,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              hintText: '••••••••',
              prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
              suffixIcon: IconButton(
                icon: Icon(
                  auth.obscurePass.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => auth.obscurePass.toggle(),
              ),
            ),
          )),
          SizedBox(height: 8.h),

          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => _showForgotDialog(context, auth),
              child: Text('نسيت كلمة المرور؟',
                style: TextStyle(color: AppColors.primary,
                  fontSize: 13.sp, fontWeight: FontWeight.w600)),
            ),
          ),

          Obx(() => auth.errorMsg.value.isEmpty ? const SizedBox() :
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error, size: 18),
                  SizedBox(width: 8.w),
                  Expanded(child: Text(auth.errorMsg.value,
                    style: TextStyle(color: AppColors.error, fontSize: 13.sp))),
                ],
              ),
            ),
          ),

          Obx(() => ElevatedButton(
            onPressed: auth.isLoading.value ? null : auth.login,
            child: auth.isLoading.value
              ? const SizedBox(width: 24, height: 24,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Text('تسجيل الدخول'),
          )),

          SizedBox(height: 20.h),
          Center(
            child: Text('بيانات تجريبية: admin@test.com / 123456 ---- user@test.com / 123456',
              style: TextStyle(fontSize: 11.sp, color: AppColors.textLight)),
          ),
        ],
      ),
    );
  }

  void _showForgotDialog(BuildContext ctx, AuthController auth) {
    final emailCtrl = TextEditingController();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60.w, height: 60.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lock_reset, color: AppColors.primary, size: 32),
              ),
              SizedBox(height: 16.h),
              Text('استعادة كلمة المرور',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 8.h),
              Text('أدخل بريدك الإلكتروني وسنرسل لك رابط الاستعادة',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
              SizedBox(height: 16.h),
              TextField(
                controller: emailCtrl,
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(
                  hintText: 'example@mail.com',
                  prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  auth.forgotPassword(emailCtrl.text.trim());
                  Get.back();
                },
                child: const Text('إرسال'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpTab extends StatelessWidget {
  final AuthController auth;
  const _SignUpTab({required this.auth});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('أنشئ حسابك 🌱',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800,
              color: AppColors.textPrimary)),
          SizedBox(height: 4.h),
          Text('انضم إلى مجتمع الذاكرين',
            style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
          SizedBox(height: 24.h),

          TextField(
            controller: auth.nameCtrl,
            decoration: const InputDecoration(
              labelText: 'الاسم الكامل',
              prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
            ),
          ),
          SizedBox(height: 14.h),
          TextField(
            controller: auth.emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textDirection: TextDirection.ltr,
            decoration: const InputDecoration(
              labelText: 'البريد الإلكتروني',
              hintText: 'example@mail.com',
              prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
            ),
          ),
          SizedBox(height: 14.h),
          Obx(() => TextField(
            controller: auth.passCtrl,
            obscureText: auth.obscurePass.value,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
              suffixIcon: IconButton(
                icon: Icon(auth.obscurePass.value
                    ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textSecondary),
                onPressed: () => auth.obscurePass.toggle(),
              ),
            ),
          )),
          SizedBox(height: 14.h),
          Obx(() => TextField(
            controller: auth.confirmCtrl,
            obscureText: auth.obscureConf.value,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              labelText: 'تأكيد كلمة المرور',
              prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
              suffixIcon: IconButton(
                icon: Icon(auth.obscureConf.value
                    ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textSecondary),
                onPressed: () => auth.obscureConf.toggle(),
              ),
            ),
          )),
          SizedBox(height: 8.h),

          Obx(() => auth.errorMsg.value.isEmpty ? const SizedBox() :
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(children: [
                const Icon(Icons.error_outline, color: AppColors.error, size: 18),
                SizedBox(width: 8.w),
                Expanded(child: Text(auth.errorMsg.value,
                  style: TextStyle(color: AppColors.error, fontSize: 13.sp))),
              ]),
            ),
          ),

          Obx(() => ElevatedButton(
            onPressed: auth.isLoading.value ? null : auth.register,
            child: auth.isLoading.value
              ? const SizedBox(width: 24, height: 24,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Text('إنشاء الحساب'),
          )),
        ],
      ),
    );
  }
}
