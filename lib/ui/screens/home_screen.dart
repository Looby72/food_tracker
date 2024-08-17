import 'package:flutter/material.dart';
import 'package:food_tracker/controllers/settings_controller.dart';
import 'package:food_tracker/ui/screens/settings_screen.dart';
import 'package:food_tracker/ui/widgets/search_bar_widget.dart';

import '../widgets/daily_progress_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.settingsController});

  final SettingsController settingsController;

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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingsScreen(controller: settingsController);
              }));
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProductSearch(),
            //DailyFoodProgress(),
          ],
        ),
      ),
    );
  }
}
