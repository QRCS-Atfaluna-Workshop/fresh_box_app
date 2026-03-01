// import 'package:flutter/material.dart';
// import 'package:pro/products/products_models.dart';
// import 'package:pro/products/products_widgets.dart';


// void main() => runApp(const ProductsApp());

// class ProductsApp extends StatelessWidget {
//   const ProductsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'sans-serif',
//         scaffoldBackgroundColor: AppColors.bg,
//         colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
//         useMaterial3: true,
//       ),
//       home: const MainNavigation(),
//     );
//   }
// }

// class CartState extends ChangeNotifier {
//   final List<CartItem> items = [];
//   void add(ProductsItem food) {
//     final idx = items.indexWhere((e) => e.food.id == food.id);
//     if (idx >= 0) {
//       items[idx].quantity++;
//     } else {
//       items.add(CartItem(food: food));
//     }
//     notifyListeners();
//   }
//   int get totalItems => items.fold(0, (s, e) => s + e.quantity);
// }

// class MainNavigation extends StatefulWidget {
//   const MainNavigation({super.key});

//   @override
//   State<MainNavigation> createState() => _MainNavigationState();
// }

// class _MainNavigationState extends State<MainNavigation> {
//   int _index = 0;
//   final _cart = CartState();

//   @override
//   Widget build(BuildContext context) {
//     final screens = [
//       PopularProductsScreen(cart: _cart),
//       const NotificationsScreen(),
//       const Center(child: Text('Orders')),
//       const MoreScreen(),
//     ];

//     return Scaffold(
//       body: IndexedStack(index: _index, children: screens),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _index,
//         onTap: (i) => setState(() => _index = i),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: AppColors.primary,
//         unselectedItemColor: AppColors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Orders'),
//           BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
//         ],
//       ),
//     );
//   }
// }

// class PopularProductsScreen extends StatefulWidget {
//   final CartState cart;
//   const PopularProductsScreen({super.key, required this.cart});

//   @override
//   State<PopularProductsScreen> createState() => _PopularProductsScreenState();
// }

// class _PopularProductsScreenState extends State<PopularProductsScreen> {
//   final _favorites = <String>{};
//   final List<ProductsItem> _popularItems = [
//     const ProductsItem(id: '1', name: 'Arla DANO Full Cream Milk Powder Instant', description: 'Full Cream Milk', price: 182.0, imageUrl: 'https://images.unsplash.com/photo-1550583724-125581f77833?w=400', discount: 50, weight: '1 KG', category: ProductsCategory.dairy),
//     const ProductsItem(id: '2', name: 'Marinated Grilled Burger', description: 'Juicy beef', price: 120.0, imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400', category: ProductsCategory.burgers),
//     const ProductsItem(id: '3', name: 'Fresh Salad with Letuce', description: 'Garden fresh', price: 80.0, imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400', category: ProductsCategory.salads),
//     const ProductsItem(id: '4', name: 'Fresh Salad Green berry', description: 'Mixed berry', price: 90.0, imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400', discount: 40, category: ProductsCategory.salads),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Popular Food', style: TextStyle(fontWeight: FontWeight.bold))),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.85),
//         itemCount: _popularItems.length,
//         itemBuilder: (_, i) => ProductsCard(
//           item: _popularItems[i],
//           isFavorite: _favorites.contains(_popularItems[i].id),
//           onFavorite: () => setState(() => _favorites.contains(_popularItems[i].id) ? _favorites.remove(_popularItems[i].id) : _favorites.add(_popularItems[i].id)),
//           onAdd: () => setState(() => widget.cart.add(_popularItems[i])),
//           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(item: _popularItems[i]))),
//         ),
//       ),
//     );
//   }
// }

// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: false),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: const [
//           NotificationTile(title: 'Order #345', message: 'Your Order is Confirmed. Please check everything is okay', time: '2:57 PM', icon: Icons.shopping_bag, iconBgColor: Colors.orange, isHighlighted: true),
//           NotificationTile(title: 'Order #345', message: 'Your Order is Delivering to your home', time: '2:33 PM', icon: Icons.phone, iconBgColor: Colors.green),
//           NotificationTile(title: 'Order #345', message: 'Your Order is Confirmed. Please check everything is okay', time: '4:12 AM', icon: Icons.shopping_bag, iconBgColor: Colors.red),
//           NotificationTile(title: 'Order #345', message: 'Your Order is Completed. Please rate the experience', time: '12:07 AM', icon: Icons.star, iconBgColor: Colors.green),
//           NotificationTile(title: 'Order #345', message: 'Your Order is Confirmed. Please check everything is okay', time: '11:51 AM', icon: Icons.shopping_bag, iconBgColor: Colors.red),
//         ],
//       ),
//     );
//   }
// }

// class MoreScreen extends StatelessWidget {
//   const MoreScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(padding: EdgeInsets.all(20), child: Text('More', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   const CircleAvatar(radius: 28, backgroundImage: NetworkImage('https://via.placeholder.com/150')),
//                   const SizedBox(width: 12),
//                   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                     const Text('Shafikul Islam', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                     const Text('01XXXXXXXXXXX', style: TextStyle(fontSize: 13, color: AppColors.grey)),
//                   ]),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             Expanded(
//               child: ListView(
//                 children: [
//                   CustomMenuItem(icon: Icons.edit_outlined, label: 'Edit Profile', iconColor: Colors.blue, onTap: () {}),
//                   CustomMenuItem(icon: Icons.location_on_outlined, label: 'My Address', iconColor: Colors.blue, onTap: () {}),
//                   CustomMenuItem(icon: Icons.shopping_basket_outlined, label: 'My Orders', iconColor: Colors.blue, onTap: () {}),
//                   CustomMenuItem(icon: Icons.flash_on_outlined, label: 'My Wishlist', iconColor: Colors.blue, onTap: () {}),
//                   CustomMenuItem(icon: Icons.chat_bubble_outline, label: 'Chat with us', iconColor: Colors.green, onTap: () {}),
//                   CustomMenuItem(icon: Icons.phone_outlined, label: 'Talk to our Support', iconColor: Colors.orange, onTap: () {}),
//                   CustomMenuItem(icon: Icons.mail_outline, label: 'Mail to us', iconColor: Colors.blue, onTap: () {}),
//                   CustomMenuItem(icon: Icons.facebook_outlined, label: 'Message to facebook page', iconColor: Colors.blue, onTap: () {}),
//                   CustomMenuItem(icon: Icons.power_settings_new, label: 'Log out', iconColor: Colors.red, onTap: () {}),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProductDetailsScreen extends StatelessWidget {
//   final ProductsItem item;
//   const ProductDetailsScreen({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)), title: const Text('Product Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       height: 220, width: 220,
//                       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
//                       child: Image.network(item.imageUrl, fit: BoxFit.contain),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       _thumb(item.imageUrl, isSelected: true),
//                       _thumb(item.imageUrl),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Text(item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text)),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(item.weight, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text)),
//                       Text('৳${item.price.toInt()}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(children: [
//                     const Icon(Icons.grid_view, size: 16, color: AppColors.grey),
//                     const SizedBox(width: 8),
//                     Text(item.categoryName, style: const TextStyle(color: AppColors.grey, fontSize: 14)),
//                   ]),
//                   const SizedBox(height: 12),
//                   Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                     const Icon(Icons.menu, size: 16, color: AppColors.grey),
//                     const SizedBox(width: 8),
//                     Expanded(child: Text('Et quidem faciunt, ut summum bonum sit extremum et rationibus conqui sites de voluptate. Sed ut summum bonum sit id.', style: const TextStyle(fontSize: 14, color: AppColors.grey, height: 1.5))),
//                   ]),
//                   const SizedBox(height: 32),
//                   const Text('You can also check this items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                   const SizedBox(height: 16),
//                   RecommendedCard(item: item),
//                   RecommendedCard(item: item),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Add to Bag', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
//                   SizedBox(width: 8),
//                   Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _thumb(String url, {bool isSelected = false}) {
//     return Container(
//       margin: const EdgeInsets.only(right: 12),
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(border: Border.all(color: isSelected ? AppColors.primary : Colors.grey[300]!, width: 1.5), borderRadius: BorderRadius.circular(8)),
//       child: Image.network(url, width: 40, height: 40, fit: BoxFit.cover),
//     );
//   }
// }
