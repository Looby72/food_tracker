import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_tracker/ui/screens/add_food_screen.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'controllers/daily_food_controller.dart';
import 'controllers/product_storage_controller.dart';
import 'controllers/settings_controller.dart';
import 'controllers/nutrient_goal_controller.dart';
import 'data/routes.dart';
import 'services/daily_food_service.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/product_detail_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/daily_food_screen.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Set up the controllers for the app.
    final DailyFoodController dailyFoodController =
        DailyFoodController(DailyFoodService());
    final NutrientGoalController nutrientController = NutrientGoalController();
    final ProductStorageController productStorageController =
        ProductStorageController();

    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          initialRoute: Routes.home,
          routes: {
            Routes.home: (context) => HomeScreen(
                  dailyFoodController: dailyFoodController,
                  nutrientController: nutrientController,
                ),
            Routes.settings: (context) => SettingsScreen(
                  controller: settingsController,
                  nutrientController: nutrientController,
                ),
            Routes.productDetail: (context) {
              final product =
                  ModalRoute.of(context)?.settings.arguments as Product?;
              return ProductDetailScreen(
                  dailyFoodController: dailyFoodController,
                  productStorageController: productStorageController,
                  product: product!);
            },
            Routes.dailyFood: (context) => DailyFoodScreen(
                  dailyFoodController: dailyFoodController,
                ),
            Routes.addFood: (context) => AddFoodScreen(
                productStorageController: productStorageController),
          },
        );
      },
    );
  }
}
