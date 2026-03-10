import 'package:flutter/material.dart';

void main() {
  runApp(SecondApp());
}

class SecondApp extends StatelessWidget {
  const SecondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Column(
          children: [
            Expanded(flex: 2, child: Container(color: Colors.redAccent)),
            Expanded(flex: 5, child: Container(color: Colors.blueAccent)),
            Expanded(flex: 3, child: Container(color: Colors.tealAccent)),
          ],
        ),
      );
    
  }
}