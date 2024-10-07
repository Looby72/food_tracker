import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'controllers/settings_controller.dart';

void main() async {
  // Set up OpenFoodFacts API configuration.
  OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'food_tracker_app');
  OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
    OpenFoodFactsLanguage.GERMAN
  ];
  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.GERMANY;

  // ensure that SharedPreferences can be accessed
  WidgetsFlutterBinding.ensureInitialized();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController();

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    ChangeNotifierProvider(
        create: (context) => settingsController, child: const MyApp()),
  );
}
