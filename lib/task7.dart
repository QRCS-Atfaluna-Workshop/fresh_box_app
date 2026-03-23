import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter ScreenUtil", style: TextStyle(fontSize: 20.sp))),
      body: Center(
        child: Container(
          width: 200.w,  
          height: 100.h,  
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              "hello world",
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ),
      ),
    );
  }
}
