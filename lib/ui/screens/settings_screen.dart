import 'package:flutter/material.dart';

import '../widgets/settings_nutrient_goals_widget.dart';
import '../widgets/settings_theme_widget.dart';
import 'base_screen.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Screen(
        title: 'Einstellungen',
        centerTitle: false,
        body: Column(
          children: [
            SettingsNutrientGoals(),
            SizedBox(height: 16),
            SettingsThemeWidget()
          ],
        ));
    // return Consumer<NutrientGoalController>(
    //   builder: (context, nutrientController, child) {
    //     // Create a TextEditingController for each nutrient goal.
    //     final TextEditingController energyController = TextEditingController(
    //         text: nutrientController.energyGoal.toString());
    //     final TextEditingController proteinController = TextEditingController(
    //         text: nutrientController.proteinGoal.toString());
    //     final TextEditingController fatController =
    //         TextEditingController(text: nutrientController.fatGoal.toString());
    //     final TextEditingController carbController =
    //         TextEditingController(text: nutrientController.carbGoal.toString());
    //     return Consumer<SettingsController>(
    //       builder: (context, controller, child) {
    //         return Scaffold(
    //           appBar: AppBar(
    //             title: const Text('Settings'),
    //           ),
    //           body: Padding(
    //             padding: const EdgeInsets.all(16),
    //             child: Column(
    //               children: [
    //                 DropdownButton<ThemeMode>(
    //                   value: controller.themeMode,
    //                   onChanged: controller.updateThemeMode,
    //                   items: const [
    //                     DropdownMenuItem(
    //                       value: ThemeMode.system,
    //                       child: Text('System Theme'),
    //                     ),
    //                     DropdownMenuItem(
    //                       value: ThemeMode.light,
    //                       child: Text('Light Theme'),
    //                     ),
    //                     DropdownMenuItem(
    //                       value: ThemeMode.dark,
    //                       child: Text('Dark Theme'),
    //                     )
    //                   ],
    //                 ),
    //                 const SizedBox(height: 16),
    //                 TextField(
    //                   controller: energyController,
    //                   decoration: const InputDecoration(
    //                     labelText: 'Daily Energy Goal',
    //                   ),
    //                   keyboardType: TextInputType.number,
    //                   onChanged: (value) => nutrientController
    //                       .updateEnergyGoal(int.tryParse(value) ?? 0),
    //                 ),
    //                 const SizedBox(height: 16),
    //                 TextField(
    //                   controller: proteinController,
    //                   decoration: const InputDecoration(
    //                     labelText: 'Daily Protein Goal',
    //                   ),
    //                   keyboardType: TextInputType.number,
    //                   onChanged: (value) => nutrientController
    //                       .updateProteinGoal(int.tryParse(value) ?? 0),
    //                 ),
    //                 const SizedBox(height: 16),
    //                 TextField(
    //                   controller: fatController,
    //                   decoration: const InputDecoration(
    //                     labelText: 'Daily Fat Goal',
    //                   ),
    //                   keyboardType: TextInputType.number,
    //                   onChanged: (value) => nutrientController
    //                       .updateFatGoal(int.tryParse(value) ?? 0),
    //                 ),
    //                 const SizedBox(height: 16),
    //                 TextField(
    //                   controller: carbController,
    //                   decoration: const InputDecoration(
    //                     labelText: 'Daily Carbs Goal',
    //                   ),
    //                   keyboardType: TextInputType.number,
    //                   onChanged: (value) => nutrientController
    //                       .updateCarbGoal(int.tryParse(value) ?? 0),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
