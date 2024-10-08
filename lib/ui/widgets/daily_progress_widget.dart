import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/daily_food_controller.dart';
import '../../controllers/nutrient_goal_controller.dart';
import '../../data/routes.dart';

class DailyFoodProgress extends StatelessWidget {
  const DailyFoodProgress({super.key});

  /// Calculate the progress of a value compared to a goal.
  double calculateProgress(double value, double goal) {
    return (value / goal).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.dailyFood);
      },
      child: Card(
        child: Consumer<DailyFoodController>(
          builder: (context, dailyFoodController, child) {
            final energy = dailyFoodController.summedEnergy;
            final carbs = dailyFoodController.summedCarbs;
            final fats = dailyFoodController.summedFat;
            final proteins = dailyFoodController.summedProtein;

            return Consumer<NutrientGoalController>(
              builder: (context, nutrientController, child) {
                final energyGoal = nutrientController.energyGoal;
                final carbGoal = nutrientController.carbGoal;
                final fatGoal = nutrientController.fatGoal;
                final proteinGoal = nutrientController.proteinGoal;

                return Column(
                  children: [
                    ListTile(
                      title: const Text('Energie'),
                      subtitle:
                          Text('${energy.toStringAsFixed(2)} / $energyGoal kcal'),
                      trailing: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value:
                                calculateProgress(energy, energyGoal.toDouble()),
                          ),
                          Text(
                              '${(calculateProgress(energy, energyGoal.toDouble()) * 100).toStringAsFixed(0)}%'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text('Kohlenhydrate'),
                      subtitle: Text('${carbs.toStringAsFixed(2)} / $carbGoal g'),
                      trailing: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: calculateProgress(carbs, carbGoal.toDouble()),
                          ),
                          Text(
                              '${(calculateProgress(carbs, carbGoal.toDouble()) * 100).toStringAsFixed(0)}%'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text('Fett'),
                      subtitle: Text('${fats.toStringAsFixed(2)} / $fatGoal g'),
                      trailing: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: calculateProgress(fats, fatGoal.toDouble()),
                          ),
                          Text(
                              '${(calculateProgress(fats, fatGoal.toDouble()) * 100).toStringAsFixed(0)}%'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text('Proteine'),
                      subtitle:
                          Text('${proteins.toStringAsFixed(2)} / $proteinGoal g'),
                      trailing: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: calculateProgress(
                                proteins, proteinGoal.toDouble()),
                          ),
                          Text(
                              '${(calculateProgress(proteins, proteinGoal.toDouble()) * 100).toStringAsFixed(0)}%'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
