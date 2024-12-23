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
  }
}
