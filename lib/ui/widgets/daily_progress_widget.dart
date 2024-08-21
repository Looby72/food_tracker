import 'package:flutter/material.dart';

import '../../controllers/daily_food_controller.dart';
import '../../controllers/nutrient_goal_controller.dart';
import '../../data/routes.dart';

class DailyFoodProgress extends StatelessWidget {
  const DailyFoodProgress(
      {super.key,
      required this.dailyFoodController,
      required this.nutrientController});

  final DailyFoodController dailyFoodController;
  final NutrientGoalController nutrientController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.dailyFood);
      },
      child: Card(
        child: ListenableBuilder(
          listenable: Listenable.merge([
            dailyFoodController,
            nutrientController,
          ]),
          builder: (BuildContext context, Widget? child) {
            final energy = dailyFoodController.summedEnergy;
            final carbs = dailyFoodController.summedCarbs;
            final fats = dailyFoodController.summedFat;
            final proteins = dailyFoodController.summedProtein;
            final energyGoal = nutrientController.energyGoal;
            final carbGoal = nutrientController.carbGoal;
            final fatGoal = nutrientController.fatGoal;
            final proteinGoal = nutrientController.proteinGoal;

            return Column(
              children: [
                ListTile(
                  title: const Text('Energie'),
                  subtitle:
                      Text('${energy.toStringAsFixed(2)} / $energyGoal kJ'),
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
            );
          },
        ),
      ),
    );
  }
}
