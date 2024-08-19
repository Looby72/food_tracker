import 'package:flutter/material.dart';

import '../../controllers/daily_food_controller.dart';

class DailyFoodProgress extends StatelessWidget {
  const DailyFoodProgress({super.key, required this.dailyFoodController});

  final DailyFoodController dailyFoodController;
  final calorieGoal = 2600;
  final carbGoal = 300;
  final fatGoal = 70;
  final proteinGoal = 100;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: dailyFoodController,
      builder: (BuildContext context, Widget? child) {
        final kjs = dailyFoodController.cumulatedKj;
        final carbs = dailyFoodController.cumulatedCarbs;
        final fats = dailyFoodController.cumulatedFat;
        final proteins = dailyFoodController.cumulatedProtein;

        return Card(
          child: Column(
            children: [
              ListTile(
                title: const Text('Kalorien'),
                subtitle: Text('${kjs.toStringAsFixed(2)} / $calorieGoal kJ'),
              ),
              ListTile(
                title: const Text('Kohlenhydrate'),
                subtitle: Text('${carbs.toStringAsFixed(2)} / $carbGoal g'),
              ),
              ListTile(
                title: const Text('Fett'),
                subtitle: Text('${fats.toStringAsFixed(2)} / $fatGoal g'),
              ),
              ListTile(
                title: const Text('Protein'),
                subtitle:
                    Text('${proteins.toStringAsFixed(2)} / $proteinGoal g'),
              ),
            ],
          ),
        );
      },
    );
  }
}
