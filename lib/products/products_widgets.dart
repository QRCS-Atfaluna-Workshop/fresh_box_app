import 'package:flutter/material.dart';
import 'package:pro/products/products_models.dart';

class AppColors {
  static const primary = Color(0xFF4CAF50); // اللون الأخضر من التصميم
  static const bg = Color(0xFFF8F8F8);
  static const text = Color(0xFF333333);
  static const grey = Color(0xFF9E9E9E);
  static const lightGrey = Color(0xFFF2F2F2);
  static const secondary = Color(0xFFEE6B51); // اللون البرتقالي
}

class ProductsCard extends StatelessWidget {
  final ProductsItem item;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onAdd;
  final VoidCallback? onTap;

  const ProductsCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAdd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(item.imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
                if (item.discount != null)
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.9), borderRadius: BorderRadius.circular(6)),
                      child: Text('${item.discount}% OFF', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.text), maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: AppColors.grey, size: 14),
                  Text(' ${item.minutes}', style: const TextStyle(fontSize: 11, color: AppColors.grey)),
                  const Spacer(),
                  Text('৳${item.price.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onAdd,
                    child: const CircleAvatar(backgroundColor: AppColors.primary, radius: 12, child: Icon(Icons.add, color: Colors.white, size: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedCard extends StatelessWidget {
  final ProductsItem item;
  final VoidCallback? onTap;

  const RecommendedCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.text), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('৳${item.price.toInt()}', style: const TextStyle(color: AppColors.grey, fontSize: 12, decoration: TextDecoration.lineThrough)),
                  Text('৳${item.price.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.secondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const CustomMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 22),
      title: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.text)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      dense: true,
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconBgColor;
  final bool isHighlighted;

  const NotificationTile({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(time, style: const TextStyle(color: AppColors.grey, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(color: AppColors.grey, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 14,
            backgroundColor: iconBgColor,
            child: Icon(icon, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}
