import 'package:openfoodfacts/openfoodfacts.dart';

// A class to represent food
class FoodItem {
  final String name;
  final double carbs;
  final double fats;
  final double proteins;
  final double energy;
  final double grams;

  FoodItem({
    required this.name,
    required this.carbs,
    required this.fats,
    required this.proteins,
    required this.energy,
    required this.grams,
  });

  // create a FoodItem from a [Product] object and the amount in grams
  factory FoodItem.fromProduct(Product product, double grams) {
    return FoodItem(
      name: product.productName ?? 'Unknown',
      carbs: (product.nutriments
                  ?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ??
              0) /
          100 *
          grams,
      fats: (product.nutriments
                  ?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ??
              0) /
          100 *
          grams,
      proteins: (product.nutriments
                  ?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ??
              0) /
          100 *
          grams,
      energy:
          (product.nutriments?.getComputedKJ(PerSize.oneHundredGrams) ?? 0) /
              100 *
              grams,
      grams: grams,
    );
  }

  // create a FoodItem from antoher [FoodItem] object and the amount in grams
  factory FoodItem.fromFoodItem(FoodItem foodItem, double grams) {
    return FoodItem(
      name: foodItem.name,
      carbs: foodItem.carbs / foodItem.grams * grams,
      fats: foodItem.fats / foodItem.grams * grams,
      proteins: foodItem.proteins / foodItem.grams * grams,
      energy: foodItem.energy / foodItem.grams * grams,
      grams: grams,
    );
  }

  // create a FoodItem from a JSON object
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      carbs: json['carbs'],
      fats: json['fats'],
      proteins: json['proteins'],
      energy: json['energy'],
      grams: json['grams'],
    );
  }

  // create a JSON object from a FoodItem
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'carbs': carbs,
      'fats': fats,
      'proteins': proteins,
      'energy': energy,
      'grams': grams,
    };
  }
}

class Recipe {
  final List<FoodItem> ingredients;

  Recipe({
    required this.ingredients,
  });
}
