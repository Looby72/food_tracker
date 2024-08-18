import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../controllers/daily_food_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen(
      {super.key, required this.dailyFoodController, required this.product});

  final Product product;
  final DailyFoodController dailyFoodController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                dailyFoodController.addTodaysDailyFood(product);
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
            Text(
              'Calories (kJ): ${product.nutriments?.getComputedKJ(PerSize.oneHundredGrams) ?? 'N/A'}',
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
            )
          ],
        ),
      ),
    );
  }
}
