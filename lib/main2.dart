import 'package:flutter/material.dart';

class CryptoTask extends StatelessWidget {
  const CryptoTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          width: 350,
          color: Color(0xFF1A1A1A),
          child: Column(
            children: [
               Positioned(
                top: 20,
                left: 20,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("VIP MEMBER", style: TextStyle(color: Colors.amber)),
                ),
              ),

              Image.network(
                "https://images.unsplash.com/photo-1621761191319-c6fb62004040?q=80&w=1000",
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    Row(
                      children: [
                         Text(
                          "Your Current Total Crypto Balance in Bitcoin Wallet",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Icon(Icons.account_balance_wallet, color: Colors.blue),
                      ],
                    ),
                     Text("0.456 BTC",
                        style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),

                    Row(
                      children: [
                         Container(
                          height: 50,
                          color: Colors.blue,
                          child: Center(child: Text("Send Crypto Money Now", style: TextStyle(color: Colors.white))),
                        ),
                         SizedBox(
                          height: 50,
                          child: Center(child: Text("Receive Crypto", style: TextStyle(color: Colors.blue))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

