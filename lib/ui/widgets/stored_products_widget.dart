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
        Text('Verlauf',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer)),
        const SizedBox(height: 16.0),
        Expanded(
          child: Consumer<ProductStorageController>(
            builder: (context, productStorageController, child) {
              final products = productStorageController.products;

              if (products.isEmpty) {
                return const Center(child: Text('No products found.'));
              } else {
                return ListView.separated(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[products.length - 1 - index];
                    return Container(
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                        subtitle: Text(product.brand ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant)),
                        onTap: () {
                          // Navigate to the product detail screen
                          Navigator.pushNamed(context, Routes.productDetail,
                              arguments: product);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4.0),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
