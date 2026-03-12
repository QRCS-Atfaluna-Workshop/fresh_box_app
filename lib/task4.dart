import 'package:flutter/material.dart';

void main() {
  runApp( FourthApp());
}

class FourthApp extends StatefulWidget {
   const FourthApp({super.key});

  @override
  State<FourthApp> createState() => _FourthAppState();
}

class _FourthAppState extends State<FourthApp> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return
    //  MaterialApp(
    //   debugShowCheckedModeBanner: false,
      // home: 
      Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Store"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),

        backgroundColor: Colors.grey.shade200,

        body: Center(
          child: Container(
            width: 350,

            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.store),               const SizedBox(width: 5),
                    const Text(
                      "Flutter Store",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                      ],
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
                      ), )   ],
                ),
             


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                         "https://images.unsplash.com/photo-1621761191319-c6fb62004040?q=80&w=1000",
                        height: 120,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [

                          Text(
                            "Hand-Painted Ceramic Bowl",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            "Beautiful handmade ceramic bowl perfect for your kitchen and home decoration.",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [

                    const Text(
                      "\$80.90",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        onPressed: () {

                           ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(    
                              "Added to cart!",
                            ),
                          ),
                        );
                        },

                        icon: const Icon(Icons.shopping_cart,
                            color: Colors.white),

                        label: const Text(
                          "Add To Cart",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
            
        ]    ),
          ),
     
      ),
    );
  }
}