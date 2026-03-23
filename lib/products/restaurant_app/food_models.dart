class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int minutes;
  final int? discount;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 4.5,
    this.minutes = 30,
    this.discount,
  });

  double get finalPrice => discount != null ? price * (1 - discount! / 100) : price;
}

class CartItem {
  final FoodItem food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});

  double get totalPrice => food.finalPrice * quantity;
}
