
import 'package:flutter/material.dart';

void main() {
  runApp(const ThirdthApp());
}

class ThirdthApp extends StatefulWidget {
  const ThirdthApp({super.key});

  @override
  State<ThirdthApp> createState() => _ThirdthAppState();
}

class _ThirdthAppState extends State<ThirdthApp> {
    bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.grey[200], 
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("images/im.jpg"),
              ),
              const SizedBox(height: 15), 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hello Flutter",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 5),
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
                      ), )                 ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), 
                    ),
                  ),
                  onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Edit Profile Clicked!",
                              ),
                            ),
                          );
                
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
