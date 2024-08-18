import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

// A class to store and retrieve daily products from the Phones storage
// (shared preferences).
class DailyFoodService {
  final _prefix = 'eaten_products_';

  // loads the products that were eaten on a day from the shared preferences
  Future<List<Product>> getProducts(DateTime? date) async {
    // create a shared preferences instance
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());

    // get the current date if date parameter is null
    date = date ?? DateTime.now();

    // construct a key for the storage out of the date
    final dateString = date.toIso8601String().split('T').first;
    final key = '$_prefix$dateString';

    // Construct a String List out of the JSON returned from the shared preferences
    final List<String> productJsonList = prefs.getStringList(key) ?? [];

    // convert the json strings to product objects
    return productJsonList
        .map((productJson) => Product.fromJson(jsonDecode(productJson)))
        .toList();
  }

  // persistently safes the products to the shared preferences
  // overrides the products list of the given date
  Future<void> saveProducts(List<Product> products, DateTime? date) async {
    // create a shared preferences instance
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());

    // get the current date if date parameter is null
    date = date ?? DateTime.now();

    // construct a key for the storage out of the date
    final dateString = date.toIso8601String().split('T').first;
    final key = '$_prefix$dateString';

    // convert the products to json strings
    final List<String> productJsonList =
        products.map((product) => jsonEncode(product.toJson())).toList();

    // save the json strings to the shared preferences
    await prefs.setStringList(key, productJsonList);
  }
}
