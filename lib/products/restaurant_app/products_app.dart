

import 'package:flutter/material.dart';
import 'package:pro/products/restaurant_app/notifications_screen.dart';




class Product {
  final String name;
  final String weight;
  final String price;
  final String category;
  final String description;

  const Product({
    required this.name,
    required this.weight,
    required this.price,
    required this.category,
    required this.description,
  });
}


class MoreScreen extends StatelessWidget {
   const MoreScreen({super.key});
  static const _menuItems = [
    (Icons.edit_outlined, 'Edit Profile'),
    (Icons.location_on_outlined, 'My Address'),
    (Icons.shopping_basket_outlined, 'My Orders'),
    (Icons.flash_on_outlined, 'My Wishlist'),
    (Icons.chat_bubble_outline, 'Chat with us'),
    (Icons.phone_outlined, 'Talk to our Support'),
    (Icons.mail_outline, 'Mail to us'),
    (Icons.facebook_outlined, 'Message to facebook page'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'More',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
CircleAvatar(
  radius: 28,
  backgroundImage: NetworkImage(
    "https://images.unsplash.com/photo-1621761191319-c6fb62004040?q=80&w=1000",
  ),
)
,                   SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Maha Abu Khater',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('0567000000',
                            style: TextStyle(fontSize: 13)),
                    
                      ),
//                     TextField(
//                       decoration: InputDecoration(labelText: "data", labelStyle: TextStyle(fontSize: 13, color: Colors.grey),
//                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
//                     contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 error: errorhint,     ),controller: textcontroller,
//                       onChanged: (value) {
//                    print(value);
//    } 
//    ) , 
//    ElevatedButton(onPressed: 
//    (){
//  if (textcontroller.text.isEmpty) {
//                       errorhint = Text("Please enter a value");
//                     } else {
//                       errorhint = null;
//                     }
//    }
//    , child: Text("data"))
     ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _menuItems.length + 1, 
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, indent: 20, endIndent: 20),
                itemBuilder: (context, index) {
                  if (index == _menuItems.length) {
                    return _MenuItem(
                      icon: Icons.power_settings_new,
                      label: 'Log out',
                      iconColor: Colors.red,
                      onTap: () {},
                    );
                  }
                  final item = _menuItems[index];
                  Color color = Colors.blue;
                  return _MenuItem(
                    icon: item.$1,
                    label: item.$2,
                    iconColor: color,
                    onTap: index == 0
                        ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProductDetailsScreen(
                                  product: Product(
                                    name: 'Aria DANO Full Cream Milk Powder Instant',
                                    weight: '1 KG',
                                    price: '\$182',
                                    category: 'Dairy Products',
                                    description:
                                        'Et quidem faciunt, ut summum bonum sit extremum et rationibus conqui sites de voluptate. Sed ut summum bonum sit id.',
                                  ),
                                ),
                              ),
                            )
                        : () {
                               Navigator.push(context, MaterialPageRoute(builder: (_) =>  NotificationsScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful!'), backgroundColor: Colors.green),
        );
                        }
                        ,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 22),
      title: Text(label, style: const TextStyle(fontSize: 15)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      dense: true,
    );
  }
}


class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  static final _relatedProducts = [
    const Product(
      name: 'Nestle Nido Full Cream Milk Powder Instant',
      weight: '5 KG',
      price: '\$270',
      category: '',
      description: 'Nestle Nido Full Cream Milk Powder InstantNestle Nido Full Cream Milk Powder Instant',
    ),
    const Product(
      name: 'Nestle Nido Full Cream Milk Powder ',
      weight: '',
      price: '\$270',
      category: '',
      description: 'Nestle Nido Full Cream Milk Powder InstantNestle Nido Full Cream Milk Powder Instant',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Product Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
  height: 220,
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.green, width: 2),
    image: DecorationImage(
      image: NetworkImage(
        "https://images.unsplash.com/photo-1621761191319-c6fb62004040?q=80&w=1000",
      ),
      fit: BoxFit.cover,
    ),
  ),
)
                  // Container(
                    
                  ,
              //     Container(
              //       padding: const EdgeInsets.all(2),
                    
              //       height: 220,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         color: product.imageColor,
              //         borderRadius: BorderRadius.circular(12),
              //         border: Border.all(color: Colors.green, width: 2),
              //       ),
              //       child: Image.network(
              //   "https://images.unsplash.com/photo-1621761191319-c6fb62004040?q=80&w=1000",
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              //       //const Center(
              //       //   child: Icon(Icons.image, size: 80, color: Colors.grey),
              //       // ),
              //     ),
                  const SizedBox(height: 12),
                  // Thumbnail row
                  Row(
                    children: List.generate(
                      2,
                      (i) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Image.network(
                "https://images.unsplash.com/photo-1621761191319-c6fb62004040?q=80&w=1000",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
                      
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product.price,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  Text(product.weight,
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.grid_view,
                          size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(product.category,
                          style: const TextStyle(
                              color: Colors.green, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.menu, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(product.description,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('You can also check this items',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 12),
                  ..._relatedProducts.map((p) => _RelatedProductCard(product: p)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Add to Bag'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedProductCard extends StatelessWidget {
  final Product product;

  const _RelatedProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child:Image.network(
                "https://images.unsplash.com/photo-1621761191319-c6fb62004040?q=80&w=1000",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(product.price,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
