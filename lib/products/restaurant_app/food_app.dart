import 'package:flutter/material.dart';
import 'package:pro/products/restaurant_app/food_details_screen.dart';
import 'food_models.dart';
import 'food_widgets.dart';



class CartState extends ChangeNotifier {
  final List<CartItem> items = [
    CartItem(
      food: const FoodItem(
        id: '1',
        name: 'Fresh Sandwich',
        description: 'Fresh',
        price: 10.0,
        imageUrl:
            'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=200',
        rating: 4.5,
        minutes: 30,
        discount: 30,
      ),
    ),
    CartItem(
      food: const FoodItem(
        id: '2',
        name: 'Grilled Sandwich',
        description: 'Grilled',
        price: 10.0,
        imageUrl:
            'https://images.unsplash.com/photo-1550507992-eb63ffee0847?w=200',
        rating: 4.5,
        minutes: 30,
        discount: 40,
      ),
    ),
  ];

  void add(FoodItem food) {
    final idx = items.indexWhere((e) => e.food.id == food.id);
    if (idx >= 0) {
      items[idx].quantity++;
    } else {
      items.add(CartItem(food: food));
    }
    notifyListeners();
  }

  void increment(String id) {
    items.firstWhere((e) => e.food.id == id).quantity++;
    notifyListeners();
  }

  void decrement(String id) {
    final idx = items.indexWhere((e) => e.food.id == id);
    if (items[idx].quantity > 1) {
      items[idx].quantity--;
    } else {
      items.removeAt(idx);
    }
    notifyListeners();
  }

  int get totalItems => items.fold(0, (s, e) => s + e.quantity);
  double get subtotal => items.fold(0, (s, e) => s + e.totalPrice);
  double get deliveryFee => 5.0;
  double get discount => 8.0;
  double get total => subtotal + deliveryFee - discount;
}

class PopularFoodScreen extends StatefulWidget {
  const PopularFoodScreen({super.key});

  @override
  State<PopularFoodScreen> createState() => _PopularFoodScreenState();
}

class _PopularFoodScreenState extends State<PopularFoodScreen> {
  final _cart = CartState();
  final _favorites = <String>{};

  final List<FoodItem> _popularItems = [
    const FoodItem(
      id: '1',
      name: 'Coco berry Salad',
      description: 'Fresh berries',
      price: 10.0,
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
      rating: 4.5,
      minutes: 30,
      discount: 50,
    ),
    const FoodItem(
      id: '2',
      name: 'Marinated Grilled Burger',
      description: 'Juicy beef',
      price: 12.0,
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      rating: 4.5,
      minutes: 30,
    ),
    const FoodItem(
      id: '3',
      name: 'Fresh Salad with Letuce',
      description: 'Garden fresh',
      price: 8.0,
      imageUrl:
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400',
      rating: 4.5,
      minutes: 30,
    ),
    const FoodItem(
      id: '4',
      name: 'Fresh Salad Green berry',
      description: 'Mixed berry',
      price: 9.0,
      imageUrl:
          'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400',
      rating: 4.5,
      minutes: 30,
      discount: 40,
    ),
  ];

  final List<FoodItem> _recommendedItems = [
    const FoodItem(
      id: '5',
      name: 'Fresh Veg-Salad',
      description: 'Fresh Salad with Green berry',
      price: 8.99,
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200',
    ),
    const FoodItem(
      id: '6',
      name: 'Veg Biryani',
      description: 'Fresh Salad with Green berry',
      price: 12.99,
      imageUrl:
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=200',
    ),
    const FoodItem(
      id: '7',
      name: 'Fresh Veg-Salad',
      description: 'Fresh Salad with Green berry',
      price: 8.99,
      imageUrl:
          'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Popular Food',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [_iconBtn(Icons.search), const SizedBox(width: 16)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio:.55,
            ),
            itemCount: _popularItems.length,
            itemBuilder: (_, i) => FoodCard(
              item: _popularItems[i],
              isFavorite: _favorites.contains(_popularItems[i].id),
              onFavorite: () => setState(
                () => _favorites.contains(_popularItems[i].id)
                    ? _favorites.remove(_popularItems[i].id)
                    : _favorites.add(_popularItems[i].id),
              ),
              onAdd: () => setState(() => _cart.add(_popularItems[i])),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FoodDetailScreen(
                    item: _popularItems[i],
                    cart: _cart,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.text,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._recommendedItems.map(
            (item) => RecommendedCard(
              item: item,
              onAdd: () => setState(() => _cart.add(item)),
            ),
          ),
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: ElevatedButton(
              onPressed: () {  Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen(cart: _cart)),
              );},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Go to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
                       ),
           ),
         
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Icon(icon, color: AppColors.text, size: 20),
    );
  }
}

class CartScreen extends StatefulWidget {
  final CartState cart;
  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _iconBtn(
          Icons.chevron_left,
          onTap: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [_iconBtn(Icons.search), const SizedBox(width: 16)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...cart.items.map(
            (ci) => CartItemTile(
              item: ci,
              onIncrement: () => setState(() => cart.increment(ci.food.id)),
              onDecrement: () => setState(() => cart.decrement(ci.food.id)),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Recipient Address',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              '9224 Jailyn Terrace, block 2, North Maryjaneton, Tanzania, 4387242',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Order Review',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _reviewRow('Full Vegie Salad (1 items)', 10.0),
          _reviewRow('Toasted Sandwich (1 items)', 10.0),
          _reviewRow('Delivery Fee', 5.0),
          _reviewRow('Discount', -8.0),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '\$${cart.total.toInt()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Process to Payment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewRow(String label, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.grey, fontSize: 14),
          ),
          Text(
            '\$${price.toInt()}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
          ],
        ),
        child: Icon(icon, color: AppColors.text, size: 20),
      ),
    );
  }
}
