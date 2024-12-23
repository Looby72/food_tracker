import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/daily_food_controller.dart';
import '../../data/food_item.dart';
import 'base_screen.dart';

class DailyFoodScreen extends StatelessWidget {
  const DailyFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Daily Food',
      centerTitle: false,
      body: Consumer<DailyFoodController>(
        builder: (context, dailyFoodController, child) {
          List<FoodItem> foodItems = dailyFoodController.todaysFoodList;
          return ListView.builder(
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(foodItems[index].name),
                subtitle: Text(
                    'Energy: ${foodItems[index].totalEnergy.toStringAsFixed(2)} kcal'),
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
