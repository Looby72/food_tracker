import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/internal_product.dart';

/// A service to store and retrieve products from the SharedPreferences
class ProductStorageService {
  final _productKey = 'products';
  //final _recipeKey = 'recipes';

  /// Save a list of [InternalProduct] to the storage
  Future<void> saveProducts(List<InternalProduct> products) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());

    // convert the products to json strings
    final List<String> productJsonList =
        products.map((product) => jsonEncode(product.toJson())).toList();

    // save the json strings to the shared preferences
    await prefs.setStringList(_productKey, productJsonList);
  }

  /// Get a list of [InternalProduct] from the storage
  Future<List<InternalProduct>> getProducts() async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());

    // Construct a String List out of the JSON returned from the shared preferences
    final List<String> productJsonList = prefs.getStringList(_productKey) ?? [];

    // convert the json strings to product objects
    return productJsonList
        .map((productJson) => InternalProduct.fromJson(jsonDecode(productJson)))
        .toList();
  }
}
