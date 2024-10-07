import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_storage_controller.dart';
import '../../data/routes.dart';

class StoredProductsWidget extends StatelessWidget {
  const StoredProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Deine Produkte',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Expanded(
          child: Consumer<ProductStorageController>(
            builder: (context, productStorageController, child) {
              final products = productStorageController.products;

              if (products.isEmpty) {
                return const Center(child: Text('No products found.'));
              } else {
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.brand ?? ''),
                      onTap: () {
                        // Navigate to the product detail screen
                        Navigator.pushNamed(context, Routes.productDetail,
                            arguments: product);
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
