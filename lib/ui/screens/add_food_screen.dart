import 'package:flutter/material.dart';

import '../../controllers/product_storage_controller.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/stored_products_widget.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({super.key, required this.productStorageController});

  final ProductStorageController productStorageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: InkWell(
                    onTap: () {
                      // Handle create new product action
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Create new Product'),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      // Handle create new recipe action
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Create new Recipe'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StoredProductsWidget(
              productStorageController: productStorageController,
            ),
          ),
          const ProductSearch(), // Assuming you have a SearchBarWidget defined somewhere
        ],
      ),
    );
  }
}
