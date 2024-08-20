import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../controllers/daily_food_controller.dart';
import '../../data/food_item.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen(
      {super.key, required this.dailyFoodController, required this.product});

  final Product product;
  final DailyFoodController dailyFoodController;

  @override
  Widget build(BuildContext context) {
    final TextEditingController weightController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final double grams =
                    double.tryParse(weightController.text) ?? 0.0;
                final food = FoodItem.fromProduct(product, grams);
                dailyFoodController.addTodaysDailyFood(food);
                Navigator.pop(context);
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.productName ?? 'No product name available',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            product.imageFrontUrl != null
                ? Image.network(
                    product.imageFrontUrl!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            const Text(
              'Nutrients per  100g',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Energy (kJ): ${product.nutriments?.getComputedKJ(PerSize.oneHundredGrams) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Carbs: ${product.nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fat: ${product.nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Proteins: ${product.nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter weight (g):',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'weight',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
