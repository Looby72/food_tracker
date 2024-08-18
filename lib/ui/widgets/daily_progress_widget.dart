import 'package:flutter/material.dart';
import 'package:food_tracker/controllers/daily_food_controller.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:provider/provider.dart';

class DailyFoodProgress extends StatelessWidget {
  const DailyFoodProgress({super.key, required this.dailyFoodController});

  final DailyFoodController dailyFoodController;
  final calorieGoal = 2600;
  final carbGoal = 300;
  final fatGoal = 70;
  final proteinGoal = 100;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => dailyFoodController,
      child: Card(
        child: Consumer<DailyFoodController>(
          builder: (context, controller, child) {
            final calories = controller.todaysFoodList.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.nutriments?.getComputedKJ(PerSize.oneHundredGrams) ??
                      0.0),
            );
            final carbs = controller.todaysFoodList.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.nutriments?.getValue(
                          Nutrient.carbohydrates, PerSize.oneHundredGrams) ??
                      0.0),
            );
            final fat = controller.todaysFoodList.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.nutriments
                          ?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ??
                      0.0),
            );
            final protein = controller.todaysFoodList.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.nutriments?.getValue(
                          Nutrient.proteins, PerSize.oneHundredGrams) ??
                      0.0),
            );

            return Column(
              children: [
                ListTile(
                  title: const Text('Kalorien'),
                  subtitle: Text('$calories / $calorieGoal kJ'),
                ),
                ListTile(
                  title: const Text('Kohlenhydrate'),
                  subtitle: Text('$carbs / $carbGoal g'),
                ),
                ListTile(
                  title: const Text('Fett'),
                  subtitle: Text('$fat / $fatGoal g'),
                ),
                ListTile(
                  title: const Text('Protein'),
                  subtitle: Text('$protein / $proteinGoal g'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
