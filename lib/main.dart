import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'app.dart';
import 'controllers/settings_controller.dart';
import 'services/settings_service.dart';

void main() async {
  // Set up OpenFoodFacts API configuration.
  OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'food_tracker');
  OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
    OpenFoodFactsLanguage.GERMAN
  ];
  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.GERMANY;

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(
    settingsController: settingsController,
  ));
}
