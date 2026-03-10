import 'package:flutter/material.dart';
void main() {
  runApp( MyUltimateApp());
}


class MyUltimateApp extends StatefulWidget {
   MyUltimateApp({super.key});

  @override
  State<MyUltimateApp> createState() => _MyUltimateAppState();
}

class _MyUltimateAppState extends State<MyUltimateApp> {
  @override
  Widget build(BuildContext context) {
    return 
     MyMasterComplexUI();
    
  }
}

class MyMasterComplexUI extends StatefulWidget {
   MyMasterComplexUI({super.key});

  @override
  _MyMasterComplexUIState createState() => _MyMasterComplexUIState();
}

class _MyMasterComplexUIState extends State<MyMasterComplexUI> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return 
    
      Scaffold(
        // appBar: AppBar(
        //   title: const Text("MyUltimateApp"),
        //   centerTitle: true,
        //   backgroundColor: Colors.blueAccent,
        // ),

        backgroundColor: Colors.grey.shade200,

        body: Center(
          child: Container(
      color:  Color(0xFF0F172A),
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 40),
      child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 240,
            padding:  EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            decoration:  BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blueAccent, Colors.indigo]),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(80), bottomLeft: Radius.circular(80)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Icon(Icons.grid_view_rounded, color: Colors.white, size: 28),
                    Container(
                      padding:  EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
                 SizedBox(height: 30),
                 Text("Hello, Flutter Hero", style: TextStyle(color: Colors.white70, fontSize: 16)),
                 Text("Your Dashboard", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Transform.translate(
            offset:  Offset(0, -50),
            child: Container(
              margin:  EdgeInsets.symmetric(horizontal: 20),
              padding:  EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset:  Offset(0, 10))],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                           Icon(Icons.auto_awesome, color: Colors.orange, size: 26),
                           SizedBox(height: 8),
                           Text("78", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                           Text("Points", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                           Icon(Icons.bolt, color: Colors.blue, size: 26),
                           SizedBox(height: 8),
                           Text("12", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                           Text("Level", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                           Icon(Icons.workspace_premium, color: Colors.purple, size: 26),
                           SizedBox(height: 8),
                           Text("TOP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                           Text("Rank", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                   SizedBox(height: 30),
                  InkWell(
                    onTap: () {
  setState(() {
    counter++;
  });
},

                    child: Container(
                      padding:  EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding:  EdgeInsets.all(10),
                            decoration:  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                            child:  Icon(Icons.add, color: Colors.white),
                          ),
                           SizedBox(width: 15),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Upgrade Power", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                               Text("Click to test the State", style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                             ],
                           ),
                            Spacer(),
                          Text("$counter%", style:  TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Recent Transactions", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                 SizedBox(height: 20),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin:  EdgeInsets.only(bottom: 15),
                        padding:  EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                             Icon(Icons.shopping_cart, color: Colors.orangeAccent),
                             SizedBox(width: 15),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Amazon Store", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                 Text("Today, 10:24 AM", style: TextStyle(color: Colors.white54, fontSize: 11)),
                               ],
                             ),
                                                          Spacer(),

                             Text("-\$120", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        margin:  EdgeInsets.only(bottom: 15),
                        padding:  EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                             Icon(Icons.account_balance_wallet, color: Colors.greenAccent),
                             SizedBox(width: 15),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Salary Deposit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                 Text("Yesterday", style: TextStyle(color: Colors.white54, fontSize: 11)),
                               ],
                             ),
                             Spacer(),
                             Text("+\$2,500", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                       SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          minimumSize:  Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        ),
                        child:  Text("VIEW ALL REPORTS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
             )       )) );
  }
}