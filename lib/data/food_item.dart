import 'internal_product.dart';
import 'package:uuid/uuid.dart';

/// A class to represent a Food item which can be added to the daily eaten food
class FoodItem {
  final String _name;
  final String _id;
  double _totalCarbs;
  double _totalFat;
  double _totalProtein;
  double _totalEnergy;
  double _servings;

  /// private constructor for FoodItem
  FoodItem._({
    required String name,
    required String id,
    required double totalCarbs,
    required double totalFat,
    required double totalProtein,
    required double totalEnergy,
    required double servings,
  })  : _name = name,
        _id = id,
        _totalCarbs = totalCarbs,
        _totalFat = totalFat,
        _totalProtein = totalProtein,
        _totalEnergy = totalEnergy,
        _servings = servings;

  /// create a FoodItem from a [InternalProduct] object and the amount in grams
  FoodItem.fromProduct({
    required InternalProduct product,
    required double grams,
  })  : _name = product.name,
        _id = product.id,
        _servings = grams,
        _totalCarbs = (product.carbsPer100 / 100) * grams,
        _totalFat = (product.fatPer100 / 100) * grams,
        _totalProtein = (product.proteinPer100 / 100) * grams,
        _totalEnergy = (product.energyPer100 / 100) * grams;

  /// create a FoodItem from a [Recipe] object and the amount in servings
  FoodItem.fromRecipe({
    required Recipe recipe,
    required double servings,
  })  : _name = recipe.name,
        _id = recipe.id,
        _servings = servings,
        _totalCarbs = recipe.carbsPerServing * servings,
        _totalFat = recipe.fatPerServing * servings,
        _totalProtein = recipe.proteinPerServing * servings,
        _totalEnergy = recipe.energyPerServing * servings;

  /// create a FoodItem from a JSON object
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem._(
      name: json['name'],
      id: json['id'],
      totalCarbs: json['carbs'],
      totalFat: json['fats'],
      totalProtein: json['proteins'],
      totalEnergy: json['energy'],
      servings: json['servings'],
    );
  }

  // Getters for private fields
  String get name => _name;
  String get id => _id;
  double get totalCarbs => _totalCarbs;
  double get totalFat => _totalFat;
  double get totalProtein => _totalProtein;
  double get totalEnergy => _totalEnergy;
  double get grams => _servings;

  /// Setter for _grams changes the amount of nutrients accordingly
  set grams(double value) {
    _totalCarbs = _totalCarbs / _servings * value;
    _totalFat = _totalFat / _servings * value;
    _totalProtein = _totalProtein / _servings * value;
    _totalEnergy = _totalEnergy / _servings * value;
    _servings = value;
  }

  /// create a JSON object from a FoodItem
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'id': _id,
      'carbs': _totalCarbs,
      'fats': _totalFat,
      'proteins': _totalProtein,
      'energy': _totalEnergy,
      'servings': _servings,
    };
  }
}

/// A class to represent a Recipe can be added as [FoodItem] to the daily eaten food
/// just groups multiple [FoodItem] objects together
class Recipe {
  static const Uuid _uuid = Uuid();

  final String name;
  final String id;
  final List<FoodItem> _ingredients;
  late double _carbsPerServing;
  late double _fatPerServing;
  late double _proteinPerServing;
  late double _energyPerServing;

  Recipe({
    required this.name,
    required List<FoodItem> ingredients,
  })  : _ingredients = ingredients,
        id = 'in_r_${_uuid.v4()}' {
    for (var ingredient in _ingredients) {
      _carbsPerServing += ingredient.totalCarbs;
      _fatPerServing += ingredient.totalFat;
      _proteinPerServing += ingredient.totalProtein;
      _energyPerServing += ingredient.totalEnergy;
    }
  }

  double get carbsPerServing => _carbsPerServing;
  double get fatPerServing => _fatPerServing;
  double get proteinPerServing => _proteinPerServing;
  double get energyPerServing => _energyPerServing;
}
