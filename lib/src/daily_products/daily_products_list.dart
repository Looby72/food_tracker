import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

//class that holds the list of products that were eaten today and provides
//methods to add and load products in a persistent way via shared preferences
class DailyProductsList with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  DailyProductsList() {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    final today = DateTime.now().toIso8601String().split('T').first;
    final key = 'eaten_products_$today';
    final List<String> productJsonList = prefs.getStringList(key) ?? [];
    // convert the json strings to product objects
    _products = productJsonList
        .map((productJson) => Product.fromJson(jsonDecode(productJson)))
        .toList();
    notifyListeners();
  }

  //adds a product to the list of eaten products
  Future<void> addProduct(Product product) async {
    _products.add(product);
    await _saveProducts();
    notifyListeners();
  }

  //persistently safes the products to the shared preferences
  Future<void> _saveProducts() async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    final today = DateTime.now().toIso8601String().split('T').first;
    final key = 'eaten_products_$today';
    final List<String> productJsonList =
        _products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList(key, productJsonList);
  }
}
