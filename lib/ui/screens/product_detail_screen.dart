import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/daily_food_controller.dart';
import '../../controllers/product_storage_controller.dart';
import '../../data/internal_product.dart';
import 'base_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final InternalProduct product;

  @override
  Widget build(BuildContext context) {
    final TextEditingController weightController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Screen(
      title: 'Produktdetails',
      centerTitle: false,
      actions: [
        Consumer<DailyFoodController>(
          builder: (context, dailyFoodController, child) {
            return Consumer<ProductStorageController>(
              builder: (context, productStorageController, child) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      final double grams = double.parse(weightController.text);
                      dailyFoodController.addProductToDailyFood(product, grams);
                      productStorageController.addProduct(product);
                      Navigator.pop(context);
                    }
                  },
                );
              },
            );
          },
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
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
                  Text(
                    'Nährwerte pro 100g',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Energie (kcal): ${product.energyPer100}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Kohlenhydrate: ${product.carbsPer100}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Fett: ${product.fatPer100}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Proteine: ${product.proteinPer100}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Gewicht eingeben (g):',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Form(
                    key: formKey,
                    child: TextFormField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Gewicht',
                        ),
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null) {
                            return 'Bitte eine gültige Zahl eingeben';
                          }
                          return null;
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
