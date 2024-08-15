import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:provider/provider.dart';
import 'daily_products_list.dart'; // Importieren Sie die DailyProductsList Klasse

class DailyFoodList extends StatelessWidget {
  const DailyFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyProductsList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Heutige Produkte'),
        ),
        body: Consumer<DailyProductsList>(
          builder: (context, dailyProductsList, child) {
            return ListView.builder(
              itemCount: dailyProductsList.products.length,
              itemBuilder: (context, index) {
                final product = dailyProductsList.products[index];
                return ListTile(
                  title: Text(product.productName ?? 'Unbekanntes Produkt'),
                  subtitle: Text(product.brands ?? 'Unbekannte Marke'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class DailyFoodProgress extends StatelessWidget {
  const DailyFoodProgress({super.key});

  final calorieGoal = 2600;
  final carbGoal = 300;
  final fatGoal = 70;
  final proteinGoal = 100;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyProductsList(),
      child: Card(
        child: Consumer<DailyProductsList>(
          builder: (context, dailyProductsList, child) {
            final calories = dailyProductsList.products.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.nutriments?.getComputedKJ(PerSize.oneHundredGrams) ??
                      0.0),
            );
            final carbs = dailyProductsList.products.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.nutriments?.getValue(
                          Nutrient.carbohydrates, PerSize.oneHundredGrams) ??
                      0.0),
            );
            final fat = dailyProductsList.products.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.nutriments
                          ?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ??
                      0.0),
            );
            final protein = dailyProductsList.products.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.nutriments?.getValue(
                          Nutrient.proteins, PerSize.oneHundredGrams) ??
                      0.0),
            );

            return Column(
              children: [
                ListTile(
                  title: const Text('Kalorien'),
                  subtitle: Text('$calories / $calorieGoal kJ'),
                ),
                ListTile(
                  title: const Text('Kohlenhydrate'),
                  subtitle: Text('$carbs / $carbGoal g'),
                ),
                ListTile(
                  title: const Text('Fett'),
                  subtitle: Text('$fat / $fatGoal g'),
                ),
                ListTile(
                  title: const Text('Protein'),
                  subtitle: Text('$protein / $proteinGoal g'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
