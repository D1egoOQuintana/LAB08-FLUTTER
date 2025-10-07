import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategoryData {
  static List<Category> getCategories() {
    return [
      Category(
        id: '1',
        name: 'Electrónica',
        icon: Icons.laptop,
        color: Colors.blue,
      ),
      Category(
        id: '2',
        name: 'Ropa',
        icon: Icons.checkroom,
        color: Colors.pink,
      ),
      Category(
        id: '3',
        name: 'Hogar',
        icon: Icons.home,
        color: Colors.orange,
      ),
      Category(
        id: '4',
        name: 'Deportes',
        icon: Icons.sports_soccer,
        color: Colors.green,
      ),
    ];
  }
}
