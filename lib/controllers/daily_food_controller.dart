import 'package:flutter/material.dart';
import 'package:food_tracker/services/daily_food_service.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

// A class where many Widgets can interact with to read the current daily products
// and add/remove new products to the list of daily products
class DailyFoodController with ChangeNotifier {
  DailyFoodController(this._dailyFoodService) {
    // Load the daily products for the current day
    loadTodaysDailyFood();
  }

  final DailyFoodService _dailyFoodService;

  // The list of products that were eaten on a specific day
  final Map<String, List<Product>> _dailyFood = {};

  // The list of products that were eaten today
  List<Product> get todaysFoodList => _dailyFood[_getDateKey(null)] ?? [];

  // Generates a key for the daily food map out of a DateTime object
  String _getDateKey(DateTime? date) {
    // get the current date if date parameter is null
    date = date ?? DateTime.now();

    return date.toIso8601String().split('T').first;
  }

  // Updates the daily food Map on a specific day (sync with the shared preferences)
  // If no date is provided, the current date is used
  Future<void> loadDailyFood(DateTime? date) async {
    final List<Product> foodList = [];
    foodList.addAll(await _dailyFoodService.getProducts(date));
    _dailyFood[_getDateKey(date)] = foodList;
  }

  // Updates the daily food Map on the current day (sync with the shared preferences)
  // notify all listening widgets
  Future<void> loadTodaysDailyFood() async {
    final date = DateTime.now();
    final List<Product> foodList = [];
    foodList.addAll(await _dailyFoodService.getProducts(date));
    notifyListeners();
  }

  // Adds a product to the list of todays eaten products
  // notify all listening widgets
  Future<void> addTodaysDailyFood(Product product) async {
    final date = DateTime.now();
    final List<Product> todaysFoodList = _dailyFood[_getDateKey(date)] ?? [];
    todaysFoodList.add(product);
    await _dailyFoodService.saveProducts(todaysFoodList, date);
    _dailyFood[_getDateKey(date)] = todaysFoodList;
    notifyListeners();
  }

  // Removes a product from the list of todays eaten products
  // notify all listening widgets
  Future<void> removeTodaysDailyFood(Product product) async {
    final date = DateTime.now();
    final List<Product> todaysFoodList = _dailyFood[_getDateKey(date)] ?? [];
    todaysFoodList.remove(product);
    await _dailyFoodService.saveProducts(todaysFoodList, date);
    _dailyFood[_getDateKey(date)] = todaysFoodList;
    notifyListeners();
  }
}
