
// ============================================================
// auth_flow.dart  — FreshBOX complete auth (Login + SignUp)
// كل شاشات الـ forgot/reset/success أصبحت dialogs
// لا توجد دوال مكررة — _socialBtn و _buildAppTitle مشتركة
// ============================================================
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pro/products/restaurant_app/food_app.dart';

// ─────────────────────────────────────────────────────────────
// SHARED WIDGETS  (مشتركة بين كل الشاشات — بدون تكرار)
// ─────────────────────────────────────────────────────────────

/// شعار التطبيق Fresh**BOX**
Widget buildAppTitle() => RichText(
      text: const TextSpan(children: [
        TextSpan(
            text: 'Fresh',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black)),
        TextSpan(
            text: 'BOX',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.redAccent)),
      ]),
    );

/// زرا Google / Facebook — مشترك
Widget buildSocialButtons() => Column(children: [
      const Row(children: [
        Expanded(child: Divider()),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("OR", style: TextStyle(color: Colors.grey))),
        Expanded(child: Divider()),
      ]),
      SizedBox(height: 20.h),
      _socialBtn("Continue With Google", Colors.white, Colors.black87,
          Icons.g_mobiledata,
          isOutlined: true),
      SizedBox(height: 12.h),
      _socialBtn("Continue With Facebook", const Color(0xFF1877F2),
          Colors.white, Icons.facebook),
      SizedBox(height: 20.h),
    ]);

Widget _socialBtn(String txt, Color bg, Color textCol, IconData icon,
    {bool isOutlined = false}) {
  void onTap() => Get.snackbar("Info", "$txt coming soon!",
      backgroundColor: Colors.orange, colorText: Colors.white);

  final shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r));
  final child = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Icon(icon, color: textCol, size: 22.sp),
    SizedBox(width: 10.w),
    Text(txt,
        style: TextStyle(
            color: textCol, fontSize: 15.sp, fontWeight: FontWeight.w500)),
  ]);

  return SizedBox(
    width: double.infinity,
    height: 50.h,
    child: isOutlined
        ? OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300), shape: shape),
            child: child)
        : ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: bg, foregroundColor: textCol, shape: shape),
            child: child),
  );
}

/// حقل نص مشترك مع Obx
Widget buildField(
  String label,
  TextEditingController ctrl,
  IconData icon,
  RxnString error, {
  bool obscure = false,
  VoidCallback? toggleObscure,
  RxBool? obscureRx,
  TextInputType keyboardType = TextInputType.text,
}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );
  return Obx(() => TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        obscureText: obscureRx?.value ?? false,
        decoration: InputDecoration(
          labelText: label,
          hintText: "Enter your $label",
          errorText: error.value,
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixIcon: toggleObscure != null
              ? IconButton(
                  icon: Icon(
                      (obscureRx?.value ?? false)
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey),
                  onPressed: toggleObscure)
              : null,
          border: border,
          enabledBorder: border,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ));
}

/// زر أساسي أحمر
Widget buildPrimaryButton(String label, VoidCallback onTap) => SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: Text(label,
            style:
                TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
      ),
    );

// ─────────────────────────────────────────────────────────────
// AUTH CONTROLLER  (موحّد — بدون تكرار)
// ─────────────────────────────────────────────────────────────
class AuthController extends GetxController {
  // ── Login ──────────────────────────────────────────────────
  final loginEmailError = RxnString();
  final loginPassError  = RxnString();
  final loginObscure    = true.obs;

  // ── SignUp ─────────────────────────────────────────────────
  final usernameError = RxnString();
  final emailError    = RxnString();
  final passError     = RxnString();
  final signupObscure = true.obs;

  // ── Forgot / Reset ─────────────────────────────────────────
  final forgotEmailError          = RxnString();
  final forgotEmail               = ''.obs;
  final resetPasswordError        = RxnString();
  final resetConfirmPasswordError = RxnString();
  final resetObscure              = true.obs;
  final resetConfirmObscure       = true.obs;

  // ── OTP ────────────────────────────────────────────────────
  final otp      = ''.obs;
  final seconds  = 30.obs;
  Timer? _timer;

  // ── State ──────────────────────────────────────────────────
  final isLoggedIn = false.obs;
  final userEmail  = ''.obs;

  // ── Toggles ────────────────────────────────────────────────
  void toggleLogin()            => loginObscure.value   = !loginObscure.value;
  void toggleSignup()           => signupObscure.value  = !signupObscure.value;
  void toggleReset()            => resetObscure.value   = !resetObscure.value;
  void toggleResetConfirm()     => resetConfirmObscure.value = !resetConfirmObscure.value;

  // ── Login ──────────────────────────────────────────────────
  void validateAndLogin(String email, String password) {
    loginEmailError.value =
        email.isEmpty ? "Please enter email" : !email.contains('@') ? "Enter a valid email" : null;
    loginPassError.value =
        password.isEmpty ? "Please enter password" : password.length < 6 ? "Min 6 characters" : null;

    if (loginEmailError.value == null && loginPassError.value == null) {
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
      _successSnack("Login Successful!");
    }
  }

  // ── SignUp ─────────────────────────────────────────────────
  void validateAndSignUp(String user, String email, String pass) {
    usernameError.value = user.isEmpty ? "Please enter username" : null;
    emailError.value = email.isEmpty
        ? "Please enter email"
        : !email.contains('@')
            ? "Enter a valid email"
            : null;
    passError.value = pass.isEmpty
        ? "Please enter password"
        : pass.length < 6
            ? "Min 6 characters"
            : null;

    if (usernameError.value == null &&
        emailError.value == null &&
        passError.value == null) {
      userEmail.value = email;
      _startOtp();
      _showOtpDialog(
        email: email,
        onVerify: _verifySignupOtp,
        onResend: () {
          _startOtp();
          _showOtpDialog(
              email: email,
              onVerify: _verifySignupOtp,
              onResend: () {});
        },
      );
    }
  }

  void _verifySignupOtp(String entered) {
    if (entered == otp.value) {
      Get.back();
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
      _successSnack("Account created successfully!");
    } else {
      _errorSnack("Invalid OTP ❌");
    }
  }

  // ── Forgot Password ────────────────────────────────────────
  void validateAndSendResetLink(String email) {
    forgotEmailError.value = email.isEmpty
        ? "Please enter email"
        : !email.contains('@')
            ? "Enter a valid email"
            : null;

    if (forgotEmailError.value == null) {
      forgotEmail.value = email;
      _startOtp();
      _showOtpDialog(
        email: email,
        onVerify: _verifyResetOtp,
        onResend: () {
          _startOtp();
          _showOtpDialog(
              email: email,
              onVerify: _verifyResetOtp,
              onResend: () {});
        },
      );
    }
  }

  void _verifyResetOtp(String entered) {
    if (entered == otp.value) {
      Get.back(); // أغلق OTP dialog
      _showResetPasswordDialog();
    } else {
      _errorSnack("Invalid OTP ❌");
    }
  }

  // ── Reset Password ─────────────────────────────────────────
  void validateAndResetPassword(String pass, String confirm) {
    resetPasswordError.value = pass.isEmpty
        ? "Please enter password"
        : pass.length < 9
            ? "Min 9 characters"
            : !RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\$%^&*()])').hasMatch(pass)
                ? "Must contain uppercase, lowercase & special character"
                : null;

    resetConfirmPasswordError.value = confirm.isEmpty
        ? "Please confirm password"
        : pass != confirm
            ? "Passwords do not match"
            : null;

    if (resetPasswordError.value == null &&
        resetConfirmPasswordError.value == null) {
      Get.back(); // أغلق reset dialog
      _showSuccessDialog();
    }
  }

  // ── OTP helpers ────────────────────────────────────────────
  void _startOtp() {
    otp.value = (10000 + Random().nextInt(89999)).toString();
    seconds.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        t.cancel();
      }
    });
    // للتطوير — اعرض الـ OTP في snackbar
    Get.snackbar("OTP Code", "Code: ${otp.value}",
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 5));
  }

  // ── Snack helpers ──────────────────────────────────────────
  void _successSnack(String msg) => Get.snackbar("✅ Success", msg,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);

  void _errorSnack(String msg) => Get.snackbar("❌ Error", msg,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

// ─────────────────────────────────────────────────────────────
// DIALOGS
// ─────────────────────────────────────────────────────────────

/// Dialog مشترك للـ OTP (signup + forgot password)
void _showOtpDialog({
  required String email,
  required void Function(String) onVerify,
  required VoidCallback onResend,
}) {
  final ctrl = Get.find<AuthController>();
  final otpCtrls = List.generate(5, (_) => TextEditingController());
  final nodes = List.generate(5, (_) => FocusNode());

  Get.dialog(
    barrierDismissible: false,
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──────────────────────────────────────
            Text("OTP Authentication",
                style: TextStyle(
                    fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Text("A code has been sent to",
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600])),
            SizedBox(height: 4.h),
            Text(email,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
            SizedBox(height: 24.h),

            // ── 5 boxes ─────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (i) {
                return SizedBox(
                  width: 50.w,
                  height: 55.h,
                  child: TextField(
                    controller: otpCtrls[i],
                    focusNode: nodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: TextStyle(
                        fontSize: 22.sp, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.h),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 2)),
                    ),
                    onChanged: (v) {
                      if (v.isNotEmpty && i < 4) nodes[i + 1].requestFocus();
                      if (v.isEmpty && i > 0) nodes[i - 1].requestFocus();
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 20.h),

            // ── Resend ──────────────────────────────────────
            Obx(() => Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text("Didn't receive code? ",
                        style: TextStyle(
                            fontSize: 13.sp, color: Colors.grey[600])),
                    GestureDetector(
                      onTap: ctrl.seconds.value == 0
                          ? () {
                              for (var c in otpCtrls) c.clear();
                              nodes[0].requestFocus();
                              onResend();
                            }
                          : null,
                      child: Text("Resend",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: ctrl.seconds.value == 0
                                  ? Colors.redAccent
                                  : Colors.grey)),
                    ),
                    if (ctrl.seconds.value > 0)
                      Text(" (${ctrl.seconds.value}s)",
                          style: TextStyle(
                              fontSize: 13.sp, color: Colors.grey[500])),
                  ],
                )),
            SizedBox(height: 20.h),

            // ── Continue ────────────────────────────────────
            buildPrimaryButton("Continue", () {
              final entered = otpCtrls.map((e) => e.text).join();
              if (entered.length == 5) {
                onVerify(entered);
              } else {
                Get.snackbar("Error", "Please enter complete OTP",
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM);
              }
            }),
          ],
        ),
      ),
    ),
//   ).then((_) {
//     for (var c in otpCtrls) c.dispose();
//     for (var n in nodes) n.dispose();
//   }
);
}

/// Dialog — Forgot Password (email input)
void _showForgotPasswordDialog() {
  final ctrl = Get.find<AuthController>();
  final emailCtrl = TextEditingController();

  Get.dialog(
    barrierDismissible: false,
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password Recovery",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(height: 8.h),
                      Text(
                        "Enter your email. We'll send a verification code to reset your password.",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey[600],
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    ctrl.forgotEmailError.value = null;
                    Get.back();
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // ── Email field ─────────────────────────────────
            buildField(
              "Email Id",
              emailCtrl,
              Icons.email_outlined,
              ctrl.forgotEmailError,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24.h),

            // ── Continue ────────────────────────────────────
            buildPrimaryButton("Continue", () {
              ctrl.validateAndSendResetLink(emailCtrl.text.trim());
            }),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    ),
  // ).then((_) => emailCtrl.dispose()
  );
}

/// Dialog — Reset Password (new + confirm)
void _showResetPasswordDialog() {
  final ctrl = Get.find<AuthController>();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  Get.dialog(
    barrierDismissible: false,
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────
              Text("Reset Your Password",
                  style: TextStyle(
                      fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 6.h),
              Text(
                "At least 9 characters, with uppercase and lowercase letters",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 20.h),

              // ── Password ──────────────────────────────────
              buildField(
                "Password",
                passCtrl,
                Icons.lock_outline,
                ctrl.resetPasswordError,
                obscureRx: ctrl.resetObscure,
                toggleObscure: ctrl.toggleReset,
              ),
              SizedBox(height: 14.h),

              // ── Confirm ───────────────────────────────────
              buildField(
                "Confirm Password",
                confirmCtrl,
                Icons.lock_outline,
                ctrl.resetConfirmPasswordError,
                obscureRx: ctrl.resetConfirmObscure,
                toggleObscure: ctrl.toggleResetConfirm,
              ),
              SizedBox(height: 12.h),

              // ── Requirements ──────────────────────────────
              Obx(() => _PasswordRequirements(
                    password: passCtrl.text,
                    error: ctrl.resetPasswordError.value,
                  )),
              SizedBox(height: 20.h),

              // ── Continue ──────────────────────────────────
              buildPrimaryButton("Continue", () {
                ctrl.validateAndResetPassword(
                    passCtrl.text.trim(), confirmCtrl.text.trim());
              }),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    ),
  // ).then((_) {
  //   passCtrl.dispose();
  //   confirmCtrl.dispose();
  //   ctrl.resetPasswordError.value = null;
  //   ctrl.resetConfirmPasswordError.value = null;
  // }
  );
}

/// Dialog — Password Reset Success
void _showSuccessDialog() {
  Get.dialog(
    barrierDismissible: false,
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Container(
        padding: EdgeInsets.all(28.r),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Check icon ────────────────────────────────
            Container(
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle_rounded,
                  color: Colors.green, size: 64.sp),
            ),
            SizedBox(height: 20.h),
            Text("Congratulations!",
                style: TextStyle(
                    fontSize: 22.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),
            Text(
              "You successfully reset your password.\nNow you are good to go.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.6),
            ),
            AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: 1.0,
          child: SvgPicture.asset(
            'assets/images/013.svg',
            width: 120,
            height: 120,
          ),
        ),
            SizedBox(height: 28.h),
            buildPrimaryButton("Jump Into Home", () {
              Get.to(() => PopularFoodScreen ()) ;
            }),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// PASSWORD REQUIREMENTS WIDGET
// ─────────────────────────────────────────────────────────────
class _PasswordRequirements extends StatelessWidget {
  final String password;
  final String? error;
  const _PasswordRequirements({required this.password, this.error});

  @override
  Widget build(BuildContext context) {
    final hasUpper = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecial =
        password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Req("1 CAPITAL letter", hasUpper),
        _Req("1 number", hasNumber),
        _Req("1 special character like @,#,\$,;,/", hasSpecial),
      ],
    );
  }
}

class _Req extends StatelessWidget {
  final String text;
  final bool met;
  const _Req(this.text, this.met);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Row(children: [
          Icon(
            met ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            size: 14.sp,
            color: met ? Colors.green : Colors.grey[400],
          ),
          SizedBox(width: 6.w),
          Text(text,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: met ? Colors.green : Colors.grey[500])),
        ]),
      );
}

// ─────────────────────────────────────────────────────────────
// LOGIN SCREEN
// ─────────────────────────────────────────────────────────────
class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();

  final passCtrl = TextEditingController();

  // permanent: true حتى يُشارَك مع SignUpScreen بدون تكرار
  final AuthController _ctrl =
      Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: buildAppTitle(),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Let's Sign You In",
                style: TextStyle(
                    fontSize: 28.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            Text("Welcome back, you've been missed!",
                style: TextStyle(
                    color: Colors.grey[600], fontSize: 16.sp)),
            SizedBox(height: 32.h),

            // Email
            buildField("Email Id", emailCtrl, Icons.email_outlined,
                _ctrl.loginEmailError,
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 16.h),

            // Password
            buildField("Password", passCtrl, Icons.lock_outline,
                _ctrl.loginPassError,
                obscureRx: _ctrl.loginObscure,
                toggleObscure: _ctrl.toggleLogin),
            SizedBox(height: 8.h),

            // Forgot Password → يفتح dialog مباشرة
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _showForgotPasswordDialog,
                style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent),
                child: Text("Forgot Password?",
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 8.h),

            buildPrimaryButton("Log In", () {
              _ctrl.validateAndLogin(
                  emailCtrl.text.trim(), passCtrl.text.trim());
            }),
            SizedBox(height: 20.h),

            // Sign Up link
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: TextStyle(color: Colors.grey[600])),
                  TextButton(
                    onPressed: () => Get.toNamed('/signup'),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent),
                    child: Text("Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
            buildSocialButtons(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SIGN UP SCREEN  (مُنظَّف — يستخدم AuthController المشترك)
// ─────────────────────────────────────────────────────────────
class SignUpScreen extends StatefulWidget {

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userCtrl  = TextEditingController();

  final emailCtrl = TextEditingController();

  final passCtrl  = TextEditingController();

  // Get.find لأن AuthController تم تسجيله في LoginScreen أو AppBinding
  final AuthController _ctrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: buildAppTitle(),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Let's get Started",
                style: TextStyle(
                    fontSize: 28.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            Text("Create an account to continue!",
                style: TextStyle(
                    color: Colors.grey[600], fontSize: 16.sp)),
            SizedBox(height: 32.h),

            buildField("Username", userCtrl, Icons.person_outline,
                _ctrl.usernameError),
            SizedBox(height: 16.h),
            buildField("Email Id", emailCtrl, Icons.email_outlined,
                _ctrl.emailError,
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 16.h),
            buildField("Password", passCtrl, Icons.lock_outline,
                _ctrl.passError,
                obscureRx: _ctrl.signupObscure,
                toggleObscure: _ctrl.toggleSignup),
            SizedBox(height: 24.h),

            buildPrimaryButton("Sign Up", () {
              _ctrl.validateAndSignUp(
                userCtrl.text.trim(),
                emailCtrl.text.trim(),
                passCtrl.text.trim(),
              );
            }),
            SizedBox(height: 20.h),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(color: Colors.grey[600])),
                  TextButton(
                    onPressed: () => Get.toNamed('/login'),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent),
                    child: Text("Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
            buildSocialButtons(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// APP BINDING  (ضع هذا في main.dart)
// ─────────────────────────────────────────────────────────────
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}

// ─────────────────────────────────────────────────────────────
// HOME SCREEN (placeholder)
// ─────────────────────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildAppTitle(),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_rounded,
                color: Colors.green, size: 80),
            SizedBox(height: 20.h),
            Text("Welcome to FreshBOX!",
                style: TextStyle(
                    fontSize: 24.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Text("You have successfully logged in!",
                style: TextStyle(
                    fontSize: 16.sp, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MAIN APP  (في main.dart أضف هذا)
// ─────────────────────────────────────────────────────────────
class MyApp111 extends StatelessWidget {
  const MyApp111({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => GetMaterialApp(
        title: 'FreshBOX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Poppins',
        ),
        initialBinding: AuthBinding(),
        initialRoute: '/login',
        getPages: [
          GetPage(name: '/login',  page: () => LoginScreen()),
          GetPage(name: '/signup', page: () => SignUpScreen()),
          GetPage(name: '/home',   page: () =>                 PopularFoodScreen () ),

        ],
      ),
    );
  }
}