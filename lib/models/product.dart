import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final Color color;
  final IconData icon;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.color,
    required this.icon,
    required this.category,
  });
}

class ProductData {
  static List<Product> getAllProducts() {
    return [
      Product(
        id: '1',
        name: 'Laptop Gaming Pro',
        description: 'Laptop de alta gama para gaming profesional',
        price: 1299.99,
        rating: 4.8,
        color: Colors.blue.shade300,
        icon: Icons.laptop_mac,
        category: 'Electrónica',
      ),
      Product(
        id: '2',
        name: 'Smartphone X Pro',
        description: 'El último smartphone con cámara de 108MP',
        price: 899.99,
        rating: 4.7,
        color: Colors.purple.shade300,
        icon: Icons.phone_android,
        category: 'Electrónica',
      ),
      Product(
        id: '3',
        name: 'Auriculares Bluetooth',
        description: 'Cancelación de ruido activa y 30h de batería',
        price: 199.99,
        rating: 4.6,
        color: Colors.indigo.shade300,
        icon: Icons.headphones,
        category: 'Electrónica',
      ),
      Product(
        id: '4',
        name: 'Camiseta Deportiva',
        description: 'Tela transpirable de alta calidad',
        price: 29.99,
        rating: 4.4,
        color: Colors.green.shade300,
        icon: Icons.checkroom,
        category: 'Ropa',
      ),
      Product(
        id: '5',
        name: 'Zapatillas Running',
        description: 'Máximo confort para corredores',
        price: 89.99,
        rating: 4.7,
        color: Colors.orange.shade300,
        icon: Icons.run_circle,
        category: 'Deportes',
      ),
      Product(
        id: '6',
        name: 'Cafetera Automática',
        description: 'Café perfecto en minutos',
        price: 149.99,
        rating: 4.5,
        color: Colors.brown.shade300,
        icon: Icons.coffee_maker,
        category: 'Hogar',
      ),
      Product(
        id: '7',
        name: 'Bicicleta Montaña',
        description: 'Para aventuras extremas',
        price: 599.99,
        rating: 4.8,
        color: Colors.teal.shade300,
        icon: Icons.directions_bike,
        category: 'Deportes',
      ),
      Product(
        id: '8',
        name: 'Lámpara LED Inteligente',
        description: 'Control por voz y 16 millones de colores',
        price: 39.99,
        rating: 4.3,
        color: Colors.amber.shade300,
        icon: Icons.lightbulb,
        category: 'Hogar',
      ),
    ];
  }
}
