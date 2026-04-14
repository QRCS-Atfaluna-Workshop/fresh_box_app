import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class UserController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    username.value = box.read('username') ?? 'Guest';
    email.value = box.read('email') ?? 'guest@example.com';
  }

  void updateUser(String newUsername, String newEmail) {
    username.value = newUsername;
    email.value = newEmail;
    box.write('username', newUsername);
    box.write('email', newEmail);
  }
}


class Screen1 extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الصفحة الأولى")),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("اسم المستخدم: ${userController.username.value}"),
                Text("البريد الإلكتروني: ${userController.email.value}"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => Screen2());
                  },
                  child: Text("تعديل"),
                ),
              ],
            )),
      ),
    );
  }
}





class Screen2 extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تعديل البيانات")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "اسم المستخدم الجديد"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "البريد الإلكتروني الجديد"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "تأكيد الحفظ",
                  middleText: "هل تريد حفظ التغييرات؟",
                  textConfirm: "نعم",
                  textCancel: "إلغاء",
                  onConfirm: () {
                    userController.updateUser(
                      usernameController.text,
                      emailController.text,
                    );
                    Get.back(); 
                    Get.back();
                  },
                );
              },
              child: Text("حفظ"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  await GetStorage.init();
  runApp(MyApp222());
}

class MyApp222 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen1(),
    );
  }
}
