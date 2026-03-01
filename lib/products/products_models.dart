import 'package:flutter/material.dart';

enum ProductsCategory { dairy, vegetables, burgers, salads }

class ProductsItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int minutes;
  final int? discount;
  final String weight;
  final ProductsCategory category;
  final Color? themeColor;

  const ProductsItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 4.5,
    this.minutes = 30,
    this.discount,
    this.weight = '1 KG',
    this.category = ProductsCategory.salads,
    this.themeColor,
  });

  double get finalPrice => discount != null ? price * (1 - discount! / 100) : price;
  
  String get categoryName {
    switch (category) {
      case ProductsCategory.dairy: return 'Dairy Products';
      case ProductsCategory.vegetables: return 'Vegetables';
      case ProductsCategory.burgers: return 'Burgers';
      case ProductsCategory.salads: return 'Salads';
    }
  }
}

class CartItem {
  final ProductsItem food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});

  double get totalPrice => food.finalPrice * quantity;
}
