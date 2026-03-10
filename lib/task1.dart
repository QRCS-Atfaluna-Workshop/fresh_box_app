import 'package:flutter/material.dart';

void main() {
  runApp(FirstApp());
}

class FirstApp extends StatefulWidget {
  const FirstApp({super.key});

  @override
  State<FirstApp> createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
    bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                  CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("images/im.jpg"),
              ),
                Row(
                  children: [
                     InkWell(
                                       onTap: () {
                            setState(() {
                              isFavorite = !isFavorite; 
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFavorite ? "Added to favorites!" : "Removed from favorites!",
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ), )          ,       Expanded(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "   Maha         Maha           Maha          Maha          Maha",
                      ),
                    ),
                     InkWell(
                                       onTap: () {
                            setState(() {
                              isFavorite = !isFavorite; 
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFavorite ? "Added to favorites!" : "Removed from favorites!",
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ), )               ],
                ),
              ],
            ),
          ),
         ),
    );
  }
}