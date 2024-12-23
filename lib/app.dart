import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'controllers/daily_food_controller.dart';
import 'controllers/product_storage_controller.dart';
import 'controllers/settings_controller.dart';
import 'controllers/nutrient_goal_controller.dart';
import 'data/internal_product.dart';
import 'data/routes.dart';
import 'theme.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/product_detail_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/daily_food_screen.dart';
import 'ui/screens/create_prodcut_screen.dart';
import 'ui/screens/add_food_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      // Create a light and dark ColorScheme based on the DynamicColorScheme
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      // Temporarily disable dynamic Themes bc of bugs in the library
      if (lightDynamic != null && darkDynamic != null && false) {
        lightColorScheme = lightDynamic;
        darkColorScheme = darkDynamic;
      } else {
        lightColorScheme = DefaultTheme.lightScheme();
        darkColorScheme = DefaultTheme.darkScheme();
      }
      TextTheme textTheme = createTextTheme(context, 'Roboto', 'Merriweather');
      ThemeData lightTheme = ThemeData.from(
          colorScheme: lightColorScheme,
          textTheme: textTheme,
          useMaterial3: true);
      ThemeData darkTheme = ThemeData.from(
          colorScheme: darkColorScheme,
          textTheme: textTheme,
          useMaterial3: true);

      // Glue the SettingsController to the MaterialApp.
      //
      // The Consumer widget allows you to access the SettingsController and
      // rebuilts the MaterialApp when notifyListeners is called.
      return Consumer<SettingsController>(
          builder: (context, settingsController, child) {
        // Provide the other controllers that do not have to rebuild the MaterialApp
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => DailyFoodController()),
            ChangeNotifierProvider(
                create: (context) => NutrientGoalController()),
            ChangeNotifierProvider(
                create: (context) => ProductStorageController()),
          ],
          child: MaterialApp(
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
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: settingsController.themeMode,

            initialRoute: Routes.home,
            routes: {
              Routes.home: (context) => const HomeScreen(),
              Routes.settings: (context) => const SettingsScreen(),
              Routes.productDetail: (context) {
                final product = ModalRoute.of(context)?.settings.arguments
                    as InternalProduct?;
                return ProductDetailScreen(product: product!);
              },
              Routes.dailyFood: (context) => const DailyFoodScreen(),
              Routes.addFood: (context) => const AddFoodScreen(),
              Routes.createProduct: (context) => const CreateProductScreen(),
            },
          ),
        );
      });
    });
  }
}
