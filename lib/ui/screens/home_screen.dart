import 'package:flutter/material.dart';
import 'package:food_tracker/controllers/daily_food_controller.dart';
import 'package:food_tracker/ui/widgets/search_bar_widget.dart';

import '../../data/routes.dart';
import '../widgets/daily_progress_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.dailyFoodController});

  final DailyFoodController dailyFoodController;

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
            DailyFoodProgress(dailyFoodController: dailyFoodController),
          ],
        ),
      ),
    );
  }
}
