
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;
var isLoding = false.obs;
  void increment() {
    count++;
  }
void data(){
  isLoding.value=true;
  Future.delayed(const Duration(seconds: 8),(){
    isLoding.value=false;
  });


}
}


class CounterScreen extends StatelessWidget {
  final CounterController controller = Get.put(CounterController());

   CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.data();
    return Scaffold(
      appBar: AppBar(title: Text("GetX Counter")),
      body: Column(
        children: [
          Center(
            child: Obx(() => Text(
                  "${controller.count}",
                  style: TextStyle(fontSize: 40),
                )),
          ), Obx(() {
            if (controller.isLoding.value) {
              return CircularProgressIndicator();
            } else {
              return Text("Data Loaded");
            }
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
