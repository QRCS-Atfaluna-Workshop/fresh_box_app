import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_routes.dart';
import 'fake_api.dart';

class AuthController extends GetxController {
  final isLoading  = false.obs;
  final isLoggedIn = false.obs;
  final user       = Rxn<UserModel>();
  final errorMsg   = ''.obs;

  final nameCtrl    = TextEditingController();
  final emailCtrl   = TextEditingController();
  final passCtrl    = TextEditingController();
  final confirmCtrl = TextEditingController();
  final obscurePass = true.obs;
  final obscureConf = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, _checkSession);
  }

  Future<void> _checkSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('userEmail');
      final savedRole  = prefs.getString('userRole');
      if (savedEmail != null) {
        user.value = UserModel(
          id: '0',
          name: prefs.getString('userName') ?? '',
          email: savedEmail,
          role: savedRole ?? 'user',
        );
        isLoggedIn.value = true;
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      debugPrint('Session check error: $e');
    }
  }

  Future<void> login() async {
    errorMsg.value = '';
    if (emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      errorMsg.value = 'يرجى ملء جميع الحقول';
      return;
    }
    isLoading.value = true;
    final result = await FakeApiService.login(
        emailCtrl.text.trim(), passCtrl.text.trim());
    isLoading.value = false;

    if (result != null) {
      user.value = result;
      isLoggedIn.value = true;
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', result.email);
        await prefs.setString('userName',  result.name);
        await prefs.setString('userRole',  result.role);
      } catch (_) {}
      Get.offAllNamed(AppRoutes.home);
    } else {
      errorMsg.value = 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
    }
  }

  Future<void> register() async {
    errorMsg.value = '';
    if (nameCtrl.text.isEmpty || emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      errorMsg.value = 'يرجى ملء جميع الحقول';
      return;
    }
    if (passCtrl.text != confirmCtrl.text) {
      errorMsg.value = 'كلمة المرور غير متطابقة';
      return;
    }
    if (passCtrl.text.length < 6) {
      errorMsg.value = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
      return;
    }
    isLoading.value = true;
    final result = await FakeApiService.register(
        nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());
    isLoading.value = false;
    if (result != null) {
      user.value = result;
      isLoggedIn.value = true;
      Get.offAllNamed(AppRoutes.home);
    }
  }

  Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      errorMsg.value = 'أدخل البريد الإلكتروني';
      return;
    }
    isLoading.value = true;
    await FakeApiService.forgotPassword(email);
    isLoading.value = false;
    Get.snackbar(
      'تم الإرسال',
      'تم إرسال رابط استعادة كلمة المرور إلى بريدك',
      backgroundColor: const Color(0xFF00B4A0),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (_) {}
    user.value = null;
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.auth);
  }

  bool get isAdmin => user.value?.role == 'admin';

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.onClose();
  }
}
