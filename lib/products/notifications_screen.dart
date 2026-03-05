import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Order #345",
      "message": "Your Order is Confirmed. Please check everything is okay",
      "time": "3:57 PM",
      "icon": Icons.menu,
      "color": Colors.orange,
    },
    {
      "title": "Order #345",
      "message": "Your Order is Delivering to your home",
      "time": "2:33 PM",
      "icon": Icons.phone,
      "color": Colors.green,
    },
    {
      "title": "Order #345",
      "message": "Your Order is Confirmed. Please check everything is okay",
      "time": "4:12 AM",
      "icon": Icons.menu,
      "color": Colors.red,
    },
    {
      "title": "Order #345",
      "message": "Your Order is Completed. Please rate the experience",
      "time": "12:07 AM",
      "icon": Icons.star,
      "color": Colors.green,
    },
    {
      "title": "Order #345",
      "message": "Your Order is Confirmed. Please check everything is okay",
      "time": "11:01 AM",
      "icon": Icons.menu,
      "color": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: index == 0
                  ? const Color(0xffE6F4EA)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item["message"],
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                Column(
                  children: [
                    Text(
                      item["time"],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: item["color"].withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item["icon"],
                        size: 18,
                        color: item["color"],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}