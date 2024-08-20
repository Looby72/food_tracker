import 'package:flutter/material.dart';

import '../data/food_item.dart';
import '../services/daily_food_service.dart';

// A class where many Widgets can interact with to read the current daily products
// and add/remove new products to the list of daily products
class DailyFoodController with ChangeNotifier {
  DailyFoodController(this._dailyFoodService) {
    // Load the daily products for the current day
    loadTodaysDailyFood();
  }

  // The service that is used to store and retrieve the daily products
  final DailyFoodService _dailyFoodService;

  // The list of food that was eaten today
  final List<FoodItem> _todaysFoodList = [];

  // getter for todays food list
  List<FoodItem> get todaysFoodList => _todaysFoodList;

  // Checks if a date is the current day
  bool _isToday(DateTime? date) {
    date = date ?? DateTime.now();
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // Return the daily food list for a given date
  Future<List<FoodItem>> getDailyFood(DateTime? date) async {
    if (_isToday(date)) {
      loadTodaysDailyFood();
      return _todaysFoodList;
    } else {
      final List<FoodItem> foodList = [];
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

  // Adds a product to the list of todays eaten food
  // notify all listening widgets
  Future<void> addTodaysDailyFood(FoodItem product) async {
    final date = DateTime.now();
    _todaysFoodList.add(product);
    await _dailyFoodService.saveProducts(_todaysFoodList, date);
    notifyListeners();
  }

  // Removes a food-item from the list of todays eaten products
  // notify all listening widgets
  Future<void> removeTodaysDailyFood(FoodItem product) async {
    final date = DateTime.now();
    _todaysFoodList.remove(product);
    await _dailyFoodService.saveProducts(_todaysFoodList, date);
    notifyListeners();
  }

  // returnes the summed energy of all products consumed today
  double get summedEnergy => _todaysFoodList.fold(
        0.0,
        (previousValue, element) => previousValue + element.energy,
      );

  // returnes the summed carbohydrates of all products consumed today
  double get summedCarbs => _todaysFoodList.fold(
        0.0,
        (previousValue, element) => previousValue + element.carbs,
      );

  // returnes the summed fat of all products consumed today
  double get summedFat => _todaysFoodList.fold(
        0.0,
        (previousValue, element) => previousValue + element.fats,
      );

  // returnes the summed protein of all products consumed today
  double get summedProtein => _todaysFoodList.fold(
        0.0,
        (previousValue, element) => previousValue + element.proteins,
      );
}
