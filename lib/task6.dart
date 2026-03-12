import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String selectedValue = "اختر من القائمة";
  Color? colorss = Color.fromARGB(255, 151, 38, 38);
                 String dataa = " new data  ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedValue,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu_open_rounded, color: Colors.blue),
              initialValue: selectedValue,
              tooltip: "افتح القائمة",
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: const Color.fromARGB(255, 151, 38, 38),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              color: Colors.white,
              onSelected: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "الخيار الأول",
                  child: Text("الخيار الأول"),
                ),
                const PopupMenuItem(
                  value: "الخيار الثاني",
                  child: Text("الخيار الثاني"),
                ),
                const PopupMenuItem(
                  value: "الخيار الثالث",
                  child: Text("الخيار الثالث"),
                ),
                const PopupMenuItem(
                  value: "الخيار الرابع",
                  child: Text("الخيار الرابع"),
                ),
              ],
            ),
            Container(height: 30, width: 30, color: colorss),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  colorss = Color.fromARGB(255, 182, 199, 25);
                  dataa = "data";
                });
              },
              child: Text(dataa),
            ),
          ],
        ),
      ),
    );
  }
}
