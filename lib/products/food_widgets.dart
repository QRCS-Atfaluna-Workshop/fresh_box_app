import 'package:flutter/material.dart';
import 'food_models.dart';

class AppColors {
  static const primary = Color(0xFFEE6B51); 
  static const bg = Color(0xFFF8F8F8);
  static const text = Color(0xFF333333);
  static const grey = Color(0xFF9E9E9E);
  static const lightGrey = Color(0xFFF2F2F2);
}

class FoodCard extends StatelessWidget {
  final FoodItem item;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onAdd;

  const FoodCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(item.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              if (item.discount != null)
                Positioned(
                  top: 12, left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.9), borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        const Icon(Icons.local_offer, color: Colors.white, size: 10),
                        const SizedBox(width: 2),
                        Text('${item.discount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.text), maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: AppColors.grey, size: 14),
                Text(' ${item.minutes}', style: const TextStyle(fontSize: 11, color: AppColors.grey)),
                const SizedBox(width: 8),
                const Icon(Icons.star, color: Colors.green, size: 14),
                Text(' ${item.rating}', style: const TextStyle(fontSize: 11, color: AppColors.grey)),
                const Spacer(),
                GestureDetector(
                  onTap: onFavorite,
                  child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, size: 18, color: isFavorite ? Colors.red : AppColors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendedCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onAdd;

  const RecommendedCard({super.key, required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item.id == '5' ? const Color(0xFFFFF0ED) : Colors.white, // تمييز أول عنصر بلون فاتح كما في التصميم
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50), // صورة دائرية كما في التصميم
            child: Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(item.description, style: const TextStyle(color: AppColors.grey, fontSize: 11), maxLines: 1),
                const SizedBox(height: 4),
                Text('\$${item.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemTile({super.key, required this.item, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(item.food.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${item.food.price.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
                    Row(
                      children: [
                        _qtyBtn(Icons.remove, onDecrement),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold))),
                        _qtyBtn(Icons.add, onIncrement),
                      ],
                    ),
                  ],
                ),
                Text(item.food.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.green, size: 14),
                    Text(' ${item.food.rating}', style: const TextStyle(fontSize: 11, color: AppColors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
        child: Icon(icon, size: 16, color: Colors.black54),
      ),
    );
  }
}
