import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/daily_food_controller.dart';
import '../../controllers/product_storage_controller.dart';
import '../../data/internal_product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final InternalProduct product;

  @override
  Widget build(BuildContext context) {
    final TextEditingController weightController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          Consumer<DailyFoodController>(
            builder: (context, dailyFoodController, child) {
              return Consumer<ProductStorageController>(
                builder: (context, productStorageController, child) {
                  return IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      final double grams =
                          double.tryParse(weightController.text) ?? 0.0;
                      dailyFoodController.addProductToDailyFood(product, grams);
                      productStorageController.addProduct(product);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            product.imageUrl != null
                ? Image.network(
                    product.imageUrl!,
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
              'Energy (kJ): ${product.energyPer100}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Carbs: ${product.carbsPer100}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fat: ${product.fatPer100}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Proteins: ${product.proteinPer100}',
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
