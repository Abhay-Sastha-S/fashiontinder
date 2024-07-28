import 'package:flutter/material.dart';

class Product {
  final List<String> images;
  final String name;
  final String description;
  final double price;

  Product({
    required this.images,
    required this.name,
    required this.description,
    required this.price,
  });
}

class DataProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(
      images: [
        'https://via.placeholder.com/300x400',
        'https://via.placeholder.com/300x400/ff0000',
        'https://via.placeholder.com/300x400/00ff00',
      ],
      name: 'Fashion Product 1',
      description: 'Description of fashion product 1. This product is amazing and stylish.',
      price: 49.99,
    ),
    Product(
      images: [
        'https://via.placeholder.com/300x400',
        'https://via.placeholder.com/300x400/0000ff',
        'https://via.placeholder.com/300x400/ffff00',
      ],
      name: 'Fashion Product 2',
      description: 'Description of fashion product 2. Perfect for any occasion.',
      price: 59.99,
    ),
    Product(
      images: [
        'https://via.placeholder.com/300x400',
        'https://via.placeholder.com/300x400/00123f',
        'https://via.placeholder.com/300x400/ff1112',
      ],
      name: 'Fashion Product 3',
      description: 'Description of fashion product 2. Perfect for any occasion.',
      price: 39.99,
    ),
    Product(
      images: [
        'https://via.placeholder.com/300x400',
        'https://via.placeholder.com/300x400/0ff23f',
        'https://via.placeholder.com/300x400/ff11ff',
      ],
      name: 'Fashion Product 4',
      description: 'Description of fashion product 2. Perfect for any occasion.',
      price: 19.99,
    ),
    // Add more products as needed
  ];

  List<Product> get products => _products;

  // Filter state
  Map<String, Set<String>> _selectedFilters = {
    'Brand': {},
    'Color': {},
    'Size': {},
    'Price Range': {},
    'Material': {},
    'Type': {},
  };

  Map<String, Set<String>> get selectedFilters => _selectedFilters;

  void toggleFilter(String category, String value) {
    if (_selectedFilters[category]?.contains(value) ?? false) {
      _selectedFilters[category]?.remove(value);
    } else {
      _selectedFilters[category]?.add(value);
    }
    notifyListeners();
  }

  void onCardSwiped(int index, direction) {
    // Collaborative filtering logic to update product recommendations
    _products.shuffle();
    notifyListeners();
  }
}
