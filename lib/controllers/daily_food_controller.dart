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

  // The list of products that were eaten today
  final List<Product> _todaysFoodList = [];

  // getter for todays food list
  List<Product> get todaysFoodList => _todaysFoodList;

  // Checks if a date is the current day
  bool _isToday(DateTime? date) {
    date = date ?? DateTime.now();
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // Retrun the daily food list for a given date
  Future<List<Product>> getDailyFood(DateTime? date) async {
    if (_isToday(date)) {
      loadTodaysDailyFood();
      return _todaysFoodList;
    } else {
      final List<Product> foodList = [];
      foodList.addAll(await _dailyFoodService.getProducts(date));
      return foodList;
    }
  }

  // Loads the daily food list for the current day
  Future<void> loadTodaysDailyFood() async {
    _todaysFoodList.clear();
    _todaysFoodList.addAll(await _dailyFoodService.getProducts(DateTime.now()));
    notifyListeners();
  }

  // Adds a product to the list of todays eaten products
  // notify all listening widgets
  Future<void> addTodaysDailyFood(Product product) async {
    final date = DateTime.now();
    _todaysFoodList.add(product);
    await _dailyFoodService.saveProducts(_todaysFoodList, date);
    notifyListeners();
  }

  // Removes a product from the list of todays eaten products
  // notify all listening widgets
  Future<void> removeTodaysDailyFood(Product product) async {
    final date = DateTime.now();
    _todaysFoodList.remove(product);
    await _dailyFoodService.saveProducts(_todaysFoodList, date);
    notifyListeners();
  }
}
