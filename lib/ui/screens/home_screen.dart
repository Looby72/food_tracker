import 'package:flutter/material.dart';

import '../../controllers/daily_food_controller.dart';
import '../../controllers/nutrient_goal_controller.dart';
import '../../data/routes.dart';
import '../widgets/daily_progress_widget.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {super.key,
      required this.dailyFoodController,
      required this.nutrientController});

  final DailyFoodController dailyFoodController;
  final NutrientGoalController nutrientController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Routes.settings);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ProductSearch(),
            DailyFoodProgress(
                dailyFoodController: dailyFoodController,
                nutrientController: nutrientController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addFood);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
