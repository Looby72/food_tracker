import 'package:flutter/material.dart';

import '../../controllers/daily_food_controller.dart';
import '../../data/food_item.dart';

class DailyFoodScreen extends StatelessWidget {
  final DailyFoodController dailyFoodController;

  const DailyFoodScreen({super.key, required this.dailyFoodController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Food'),
      ),
      body: ListenableBuilder(
        listenable: dailyFoodController,
        builder: (BuildContext context, Widget? child) {
          List<FoodItem> foodItems = dailyFoodController.todaysFoodList;
          return ListView.builder(
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(foodItems[index].name),
                subtitle: Text(
                    'Energy: ${foodItems[index].energy.toStringAsFixed(2)} kJ'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    dailyFoodController.removeTodaysDailyFood(foodItems[index]);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}