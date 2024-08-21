import 'package:flutter/material.dart';

import '../../controllers/nutrient_goal_controller.dart';
import '../../controllers/settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen(
      {super.key, required this.controller, required this.nutrientController});

  final SettingsController controller;
  final NutrientGoalController nutrientController;

  @override
  Widget build(BuildContext context) {
    // Create a TextEditingController for each nutrient goal.
    final TextEditingController energyController =
        TextEditingController(text: nutrientController.energyGoal.toString());
    final TextEditingController proteinController =
        TextEditingController(text: nutrientController.proteinGoal.toString());
    final TextEditingController fatController =
        TextEditingController(text: nutrientController.fatGoal.toString());
    final TextEditingController carbController =
        TextEditingController(text: nutrientController.carbGoal.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          children: [
            DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: controller.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: controller.updateThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: energyController,
              decoration: const InputDecoration(
                labelText: 'Daily Energy Goal',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  nutrientController.updateEnergyGoal(int.tryParse(value) ?? 0),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: proteinController,
              decoration: const InputDecoration(
                labelText: 'Daily Protein Goal',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => nutrientController
                  .updateProteinGoal(int.tryParse(value) ?? 0),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: fatController,
              decoration: const InputDecoration(
                labelText: 'Daily Fat Goal',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  nutrientController.updateFatGoal(int.tryParse(value) ?? 0),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: carbController,
              decoration: const InputDecoration(
                labelText: 'Daily Carbs Goal',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  nutrientController.updateCarbGoal(int.tryParse(value) ?? 0),
            ),
          ],
        ),
      ),
    );
  }
}
