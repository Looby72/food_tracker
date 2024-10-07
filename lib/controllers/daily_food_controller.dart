import 'package:flutter/material.dart';

import '../data/food_item.dart';
import '../data/internal_product.dart';
import '../services/daily_food_service.dart';

/// A class where many Widgets can interact with to read the current daily products
/// and add/remove new products to the list of daily products
class DailyFoodController with ChangeNotifier {
  DailyFoodController() {
    // Load the daily products for the current day
    _loadTodaysDailyFood();
  }

  /// The service that is used to store and retrieve the daily products
  final DailyFoodService _dailyFoodService = DailyFoodService();

  /// The list of food that was eaten today
  final List<FoodItem> _todaysFoodList = [];

  /// getter for todays food list
  List<FoodItem> get todaysFoodList => _todaysFoodList;

  /// Checks if a date is the current day
  bool _isToday(DateTime? date) {
    date = date ?? DateTime.now();
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Return the daily food list for a given date
  Future<List<FoodItem>> getDailyFood(DateTime? date) async {
    if (_isToday(date)) {
      _loadTodaysDailyFood();
      return _todaysFoodList;
    } else {
      final List<FoodItem> foodList = [];
      foodList.addAll(await _dailyFoodService.getProducts(date));
      return foodList;
    }
  }

  /// Loads the daily food list for the current day
  Future<void> _loadTodaysDailyFood() async {
    _todaysFoodList.clear();
    _todaysFoodList.addAll(await _dailyFoodService.getProducts(DateTime.now()));
    notifyListeners();
  }

  /// Adds a [FoodItem] to the list of todays eaten food
  /// notifies all listening widgets
  Future<void> _addTodaysDailyFood(FoodItem item) async {
    final date = DateTime.now();
    _todaysFoodList.add(item);
    await _dailyFoodService.saveProducts(_todaysFoodList, date);
    notifyListeners();
  }

  /// Adds an [InternalProduct] to the list of todays eaten food
  void addProductToDailyFood(InternalProduct product, double grams) {
    final food = FoodItem.fromProduct(product: product, grams: grams);
    _addTodaysDailyFood(food);
  }

  /// Adds a [Recipe] to the list of todays eaten food
  void addRecipeToDailyFood(Recipe recipe, double servings) {
    final food = FoodItem.fromRecipe(recipe: recipe, servings: servings);
    _addTodaysDailyFood(food);
  }

  /// Removes a food-item from the list of todays eaten products
  /// notifies all listening widgets
  Future<void> removeTodaysDailyFood(FoodItem item) async {
    final date = DateTime.now();
    _todaysFoodList.remove(item);
    await _dailyFoodService.saveProducts(_todaysFoodList, date);
    notifyListeners();
  }

  /// returnes the summed energy of all products consumed today
  double get summedEnergy => _todaysFoodList.fold(
        0.0,
        (previousValue, element) => previousValue + element.totalEnergy,
      );

  /// returnes the summed carbohydrates of all products consumed today
  double get summedCarbs => _todaysFoodList.fold(
        0.0,
        (previousValue, element) => previousValue + element.totalCarbs,
      );

  /// returnes the summed fat of all products consumed today
  double get summedFat => _todaysFoodList.fold(
        0.0,
        (previousValue, element) => previousValue + element.totalFat,
      );

  /// returnes the summed protein of all products consumed today
  double get summedProtein => _todaysFoodList.fold(
        0.0,
        (previousValue, element) => previousValue + element.totalProtein,
      );
}
