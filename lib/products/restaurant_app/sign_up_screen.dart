// import 'package:flutter/material.dart';
// import 'package:pro/products/restaurant_app/froget_pass_screen.dart';
// import 'package:pro/products/restaurant_app/login_screen.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class SignUpScreen extends StatefulWidget {
// //    const SignUpScreen({super.key});

// //   @override
// //   State<SignUpScreen> createState() => _SignUpScreenState();
// // }

// // class _SignUpScreenState extends State<SignUpScreen> {
// //   final TextEditingController usernameController = TextEditingController();
// //   final TextEditingController emailController    = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();

// //   bool obscure = true;
// //   String? usernameError;
// //   String? emailError;
// //   String? passError;

// //   void signUp() {
// //     setState(() {
// //       usernameError = usernameController.text.isEmpty ? "Please enter username" : null;

// //       if (emailController.text.isEmpty) {
// //         emailError = "Please enter email";
// //       } else if (!emailController.text.contains('@')) {
// //         emailError = "Enter a valid email";
// //       } else {
// //         emailError = null;
// //       }

// //       if (passwordController.text.isEmpty) {
// //         passError = "Please enter password";
// //       } else if (passwordController.text.length < 6) {
// //         passError = "Password must be at least 6 characters";
// //       } else {
// //         passError = null;
// //       }

// //       if (usernameError == null && emailError == null && passError == null) {
// //         Navigator.push(context, MaterialPageRoute(builder: (_) =>  PopularFoodScreen()));
// //         ScaffoldMessenger.of(context).showSnackBar(
// //            SnackBar(
// //             content: Text('Account created successfully!'),
// //             backgroundColor: Colors.green,
// //           ),
// //         );
// //       }
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,

// //       appBar: AppBar(
// //         title:   RichText(
// //   text: TextSpan(
// //     children: [
// //       TextSpan(
// //         text: 'Fresh',
// //         style: TextStyle(
// //           fontWeight: FontWeight.bold,
// //           fontSize: 30,
// //           color: Colors.black, 
// //         ),
// //       ),
// //       TextSpan(
// //         text: 'BOX',
// //         style: TextStyle(
// //           fontWeight: FontWeight.bold,
// //           fontSize: 30,
// //           color: Colors.red,
// //         ),
// //       ),
// //     ],
// //   ),
// // ),
// //         centerTitle: true,
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //       ),

// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding:  EdgeInsets.all(24.r),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [

// //                Text(
// //                 "Let's get Started",
// //                 style: TextStyle(
// //                   fontSize: 28.sp,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black87,
// //                 ),
// //               ),
// //                SizedBox(height: 8.h),
// //               Text(
// //                 "Create an account to continue!",
// //                 style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
// //               ),
// //                SizedBox(height: 32.h),

// //               TextField(
// //                 controller: usernameController,
// //                 textInputAction: TextInputAction.next,
// //                 decoration: InputDecoration(
// //                   labelText: "Username",
// //                   hintText: "Create your username",
// //                   errorText: usernameError,
// //                   prefixIcon:  Icon(Icons.person_outline, color: Colors.grey),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r),
// //                     borderSide: BorderSide(color: Colors.grey.shade300),
// //                   ),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r  ),
// //                     borderSide: BorderSide(color: Colors.grey.shade300),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r),
// //                     borderSide:  BorderSide(color: Colors.redAccent, width: 2),
// //                   ),
// //                   filled: true,
// //                   fillColor: Colors.grey.shade50,
// //                 ),
// //               ),
// //                SizedBox(height: 16.h),

// //               TextField(
// //                 controller: emailController,
// //                 keyboardType: TextInputType.emailAddress,
// //                 textInputAction: TextInputAction.next,
// //                 decoration: InputDecoration(
// //                   labelText: "Email Id",
// //                   hintText: "Enter your e-mail",
// //                   errorText: emailError,
// //                   prefixIcon:  Icon(Icons.email_outlined, color: Colors.grey),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r),
// //                     borderSide: BorderSide(color: Colors.grey.shade300),
// //                   ),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r),
// //                     borderSide: BorderSide(color: Colors.grey.shade300),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r),
// //                     borderSide:  BorderSide(color: Colors.redAccent, width: 2),
// //                   ),
// //                   filled: true,
// //                   fillColor: Colors.grey.shade50,
// //                 ),
// //               ),
// //                SizedBox(height: 16.h),

// //               TextField(
// //                 controller: passwordController,
// //                 obscureText: obscure,
// //                 decoration: InputDecoration(
// //                   labelText: "Password",
// //                   hintText: "Create your password",
// //                   errorText: passError,
// //                   prefixIcon:  Icon(Icons.lock_outline, color: Colors.grey),
// //                   suffixIcon: IconButton(
// //                     icon: Icon(
// //                       obscure ? Icons.visibility_off : Icons.visibility,
// //                       color: Colors.grey,
// //                     ),
// //                     onPressed: () => setState(() => obscure = !obscure),
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r),
// //                     borderSide: BorderSide(color: Colors.grey.shade300),
// //                   ),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r),
// //                     borderSide: BorderSide(color: Colors.grey.shade300),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12.r),
// //                     borderSide:  BorderSide(color: Colors.redAccent, width: 2),
// //                   ),
// //                   filled: true,
// //                   fillColor: Colors.grey.shade50,
// //                 ),
// //               ),
// //                SizedBox(height: 24.h),

// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 50.h,
// //                 child: ElevatedButton(
// //                   onPressed: signUp,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.redAccent,
// //                     foregroundColor: Colors.white,
// //                     elevation: 0,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12.r),
// //                     ),
// //                   ),
// //                   child:  Text(
// //                     "Sign Up",
// //                     style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //               ),
// //                SizedBox(height: 20.h),

// //               Center(
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       "Already have an account?",
// //                       style: TextStyle(color: Colors.grey[600]),
// //                     ),
// //                     TextButton(
// //                       onPressed: () {
// //                         Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
// //                       },
// //                       style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
// //                       child:  Text(
// //                         "Login",
// //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //                SizedBox(height: 30.h),

// //               Row(
// //                 children: [
// //                   Expanded(child: Divider(color: Colors.grey.shade300)),
// //                   Padding(
// //                     padding:  EdgeInsets.symmetric(horizontal: 16.h),
// //                     child: Text("OR", style: TextStyle(color: Colors.grey[500])),
// //                   ),
// //                   Expanded(child: Divider(color: Colors.grey.shade300)),
// //                 ],
// //               ),
// //                SizedBox(height: 30.h),

// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 50.h,
// //                 child: OutlinedButton.icon(
// //                   onPressed: () {},
// //                   icon: Image.asset(
// //                     'assets/images/google_logo.png',
// //                     height: 24.h,
// //                     width: 24.w,
// //                     errorBuilder: (_, __, ___) =>
// //                          Icon(Icons.g_mobiledata, color: Colors.red, size: 30.sp),
// //                   ),
// //                   label:  Text(
// //                     "Continue With Google",
// //                     style: TextStyle(
// //                         color: Colors.black87,
// //                         fontSize: 16.sp,
// //                         fontWeight: FontWeight.w500),
// //                   ),
// //                   style: OutlinedButton.styleFrom(
// //                     side: BorderSide(color: Colors.grey.shade300),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12.r),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //                SizedBox(height: 12.h),

// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 50.h,
// //                 child: ElevatedButton.icon(
// //                   onPressed: () {},
// //                   icon:  Icon(Icons.facebook, color: Colors.white, size: 24.sp),
// //                   label:  Text(
// //                     "Continue With Facebook",
// //                     style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 16.sp,
// //                         fontWeight: FontWeight.w500),
// //                   ),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor:  Color(0xFF1877F2),
// //                     foregroundColor: Colors.white,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12.r),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //                SizedBox(height: 20.h),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:async';
// import 'dart:math';
// import 'package:get/get.dart';




// class AuthController extends GetxController {
//   var usernameError = RxnString();
//   var emailError = RxnString();
//   var passError = RxnString();
//   var obscure = true.obs;

//   var otp = ''.obs;
//   var seconds = 30.obs;
//   Timer? timer;
//   var isLoggedIn = false.obs;
//   var userEmail = ''.obs; 

//   void togglePassword() => obscure.value = !obscure.value;

//   void validateAndSignUp(String user, String email, String pass) {
//     usernameError.value = user.isEmpty ? "Please enter username" : null;
    
//     if (email.isEmpty) {
//       emailError.value = "Please enter email";
//     } else if (!email.contains('@')) {
//       emailError.value = "Enter a valid email";
//     } else {
//       emailError.value = null;
//     }
    
//     passError.value = pass.isEmpty 
//         ? "Please enter password" 
//         : (pass.length < 6 ? "Password must be at least 6 characters" : null);

//     if (usernameError.value == null && emailError.value == null && passError.value == null) {
//       userEmail.value = email; 
//       startOtpProcess();
//     }
//   }

//   void startOtpProcess() {
//     otp.value = (10000 + Random().nextInt(89999)).toString();
//     seconds.value = 30;
//     _startTimer();
//     print("Generated OTP: ${otp.value}");
//     showOtpDialog(this);
//   }

//   void _startTimer() {
//     timer?.cancel();
//     timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (seconds.value > 0) {
//         seconds.value--;
//       } else {
//         t.cancel();
//       }
//     });
//   }

//   void verifyOtp(String enteredOtp) {
//     if (enteredOtp == otp.value) {
//       Get.back();
//       isLoggedIn.value = true;
//       Get.offAllNamed('/home');
//       Get.snackbar(
//         "Success",
//         "Account created successfully!",
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 2),
//       );
//     } else {
//       Get.snackbar(
//         "Error",
//         "Invalid OTP ❌",
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 2),
//       );
//     }
//   }

//   @override
//   void onClose() {
//     timer?.cancel();
//     super.onClose();
//   }
// }

// class SignUpScreen extends StatelessWidget {
//   final TextEditingController userCtrl = TextEditingController();
//   final TextEditingController emailCtrl = TextEditingController();
//   final TextEditingController passCtrl = TextEditingController();
//   final AuthController controller = Get.put(AuthController());

//   SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: _buildAppTitle(),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(24.r),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Let's get Started",
//               style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               "Create an account to continue!",
//               style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
//             ),
//             SizedBox(height: 32.h),

//             _buildField("Username", userCtrl, Icons.person_outline, controller.usernameError),
//             SizedBox(height: 16.h),
//             _buildField("Email Id", emailCtrl, Icons.email_outlined, controller.emailError),
//             SizedBox(height: 16.h),
//             _buildPasswordField(),
            
//             SizedBox(height: 24.h),
//             _buildSignUpButton(),
//             SizedBox(height: 20.h),

//             _buildLoginLink(),
//             _buildSocialButtons(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildField(String label, TextEditingController ctrl, IconData icon, RxnString error) {
//     return Obx(() => TextField(
//       controller: ctrl,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: "Enter your $label",
//         errorText: error.value,
//         prefixIcon: Icon(icon, color: Colors.grey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//         ),
//         filled: true,
//         fillColor: Colors.grey.shade50,
//       ),
//     ));
//   }

//   Widget _buildPasswordField() {
//     return Obx(() => TextField(
//       controller: passCtrl,
//       obscureText: controller.obscure.value,
//       decoration: InputDecoration(
//         labelText: "Password",
//         hintText: "Create your password",
//         errorText: controller.passError.value,
//         prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
//         suffixIcon: IconButton(
//           icon: Icon(
//             controller.obscure.value ? Icons.visibility_off : Icons.visibility,
//             color: Colors.grey,
//           ),
//           onPressed: controller.togglePassword,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//         ),
//         filled: true,
//         fillColor: Colors.grey.shade50,
//       ),
//     ));
//   }

//   Widget _buildSignUpButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 50.h,
//       child: ElevatedButton(
//         onPressed: () => controller.validateAndSignUp(
//           userCtrl.text.trim(),
//           emailCtrl.text.trim(),
//           passCtrl.text.trim(),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.redAccent,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//         ),
//         child: Text(
//           "Sign Up",
//           style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoginLink() {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Already have an account?",
//             style: TextStyle(color: Colors.grey[600]),
//           ),
//           TextButton(
//             onPressed: () {
//               Get.to(() => LoginScreen());
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
//             child: Text(
//               "Login",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppTitle() {
//     return RichText(
//       text: const TextSpan(
//         children: [
//           TextSpan(
//             text: 'Fresh',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
//           ),
//           TextSpan(
//             text: 'BOX',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.redAccent),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSocialButtons() {
//     return Column(
//       children: [
//         const Row(children: [
//           Expanded(child: Divider()),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Text("OR", style: TextStyle(color: Colors.grey)),
//           ),
//           Expanded(child: Divider()),
//         ]),
//         SizedBox(height: 30.h),
//         _socialBtn1(
//           "Continue With Google",
//           Colors.white,
//           Colors.black87,
//           iconWidget: Image.asset(
//             'assets/images/google_logo.png',
//             height: 24.h,
//             width: 24.w,
//             errorBuilder: (_, __, ___) =>
//                 const Icon(Icons.g_mobiledata, color: Colors.red, size: 30),
//           ),
//           isOutlined: true,
//         ),
//         SizedBox(height: 12.h),
//         _socialBtn1(
//           "Continue With Facebook",
//           const Color(0xFF1877F2),
//           Colors.white,
//           iconWidget: Image.asset(
//             'assets/images/facebook_logo.png',
//             height: 24.h,
//             width: 24.w,
//             errorBuilder: (_, __, ___) =>
//                 const Icon(Icons.facebook, color: Colors.white, size: 30),
//           ),
//           isOutlined: false,
//         ),
//         SizedBox(height: 20.h),
//       ],
//     );
//   }

//   Widget _socialBtn(String txt, Color bg, Color textCol, IconData icon, {bool isOutlined = false}) {
//     if (isOutlined) {
//       return SizedBox(
//         width: double.infinity,
//         height: 50.h,
//         child: OutlinedButton.icon(
//           onPressed: () {
//             Get.snackbar(
//               "Info",
//               "$txt feature coming soon!",
//               backgroundColor: Colors.orange,
//               colorText: Colors.white,
//             );
//           },
//           icon: Icon(icon, color: textCol, size: 24.sp),
//           label: Text(
//             txt,
//             style: TextStyle(color: textCol, fontSize: 16.sp, fontWeight: FontWeight.w500),
//           ),
//           style: OutlinedButton.styleFrom(
//             side: BorderSide(color: Colors.grey.shade300),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//           ),
//         ),
//       );
//     }
//     return SizedBox(
//       width: double.infinity,
//       height: 50.h,
//       child: ElevatedButton.icon(
//         onPressed: () {
//           Get.snackbar(
//             "Info",
//             "$txt feature coming soon!",
//             backgroundColor: Colors.orange,
//             colorText: Colors.white,
//           );
//         },
//         icon: Icon(icon, color: textCol, size: 24.sp),
//         label: Text(
//           txt,
//           style: TextStyle(color: textCol, fontSize: 16.sp, fontWeight: FontWeight.w500),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: bg,
//           foregroundColor: textCol,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//         ),
//       ),
//     );
//   }
// }
// Widget _socialBtn1(
//   String txt,
//   Color bg,
//   Color textCol, {
//   Widget? iconWidget,
//   bool isOutlined = false,
// }) {
//   if (isOutlined) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50.h,
//       child: OutlinedButton.icon(
//         onPressed: () {
//           Get.snackbar(
//             "Info",
//             "$txt feature coming soon!",
//             backgroundColor: Colors.orange,
//             colorText: Colors.white,
//           );
//         },
//         icon: iconWidget ?? const SizedBox(),
//         label: Text(
//           txt,
//           style: TextStyle(
//               color: textCol, fontSize: 16.sp, fontWeight: FontWeight.w500),
//         ),
//         style: OutlinedButton.styleFrom(
//           side: BorderSide(color: Colors.grey.shade300),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r)),
//         ),
//       ),
//     );
//   }
//   return SizedBox(
//     width: double.infinity,
//     height: 50.h,
//     child: ElevatedButton.icon(
//       onPressed: () {
//         Get.snackbar(
//           "Info",
//           "$txt feature coming soon!",
//           backgroundColor: Colors.orange,
//           colorText: Colors.white,
//         );
//       },
//       icon: iconWidget ?? const SizedBox(),
//       label: Text(
//         txt,
//         style: TextStyle(
//             color: textCol, fontSize: 16.sp, fontWeight: FontWeight.w500),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: bg,
//         foregroundColor: textCol,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r)),
//       ),
//     ),
//   );
// }


// void showOtpDialog(AuthController controller) {
//   List<TextEditingController> otpCtrls = List.generate(5, (_) => TextEditingController());
//   List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());
//   String enteredOtp = '';
// Get.snackbar(
//   "OTP Code",
//   "Your verification code is: ${controller.otp.value}",
//   backgroundColor: Colors.blue,
//   colorText: Colors.white,
//   duration: Duration(seconds: 5),
// );
//   Get.dialog(
//     barrierDismissible: false,
//     Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
//       child: Container(
//         padding: EdgeInsets.all(18.r),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24.r),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "OTP Authentication",
//               style: TextStyle(
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 16.h),
            
//             Obx(() => Text(
//               "An authentication code has been sent to ${controller.userEmail.value}",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.grey[600],
//                 height: 1.5,
//               ),
//             )),
//             SizedBox(height: 24.h),
            
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(5, (i) => SizedBox(
//                 width: 50.w,
//                 height: 50.h,
//                 child: TextField(
//                   controller: otpCtrls[i],
//                   focusNode: focusNodes[i],
//                   textAlign: TextAlign.center,
//                   keyboardType: TextInputType.number,
//                   maxLength: 1,
//                   style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
//                   decoration: InputDecoration(
//                     counterText: "",
//                     filled: true,
//                     fillColor: Colors.grey.shade50,
//                     contentPadding: EdgeInsets.symmetric(vertical: 12.h),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                       borderSide: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                       borderSide: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                       borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//                     ),
//                   ),
//                   onChanged: (v) {
//                     if (v.isNotEmpty && i < 4) {
//                       focusNodes[i + 1].requestFocus();
//                     }
//                     if (i == 4 && v.isNotEmpty) {
//                       enteredOtp = otpCtrls.map((e) => e.text).join();
//                     }
//                     enteredOtp = otpCtrls.map((e) => e.text).join();
//                   },
//                 ),
//               )),
//             ),
//             SizedBox(height: 24.h),
            
//             Obx(() => Column(
     
//                   children: [
//                     Text(
//                       "Didn't receive code. ",
//                       style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
//                     ),
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: controller.seconds.value == 0 ? () {
//                             for (var ctrl in otpCtrls) ctrl.clear();
//                             for (var node in focusNodes) node.unfocus();
//                             focusNodes[0].requestFocus();
//                             controller.startOtpProcess();
//                           } : null,
//                           child: Text(
//                             "Resend",
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: controller.seconds.value == 0 ? Colors.redAccent : Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (controller.seconds.value > 0) ...[
//                       Text(
//                         " (${controller.seconds.value}s)",
//                         style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
//                       ),
//                     ],
//                   ],
//             )),
//             SizedBox(height: 20.h),
            
//             // زر Continue
//             SizedBox(
//               width: double.infinity,
//               height: 50.h,
//               child: ElevatedButton(
//                 onPressed: () {
//                   String otp = otpCtrls.map((e) => e.text).join();
//                   if (otp.length == 5) {
//                     controller.verifyOtp(otp);
//                   } else {
//                     Get.snackbar(
//                       "Error",
//                       "Please enter complete OTP",
//                       backgroundColor: Colors.redAccent,
//                       colorText: Colors.white,
//                       snackPosition: SnackPosition.BOTTOM,
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                 ),
//                 child: Text(
//                   "Continue",
//                   style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   ).then((_) {
//     for (var ctrl in otpCtrls) ctrl.dispose();
//     for (var node in focusNodes) node.dispose();
//   });
// }