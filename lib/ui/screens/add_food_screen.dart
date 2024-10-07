import 'package:flutter/material.dart';

import '../../data/routes.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/stored_products_widget.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Food'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Products'),
              Tab(text: 'Recipes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.createProduct);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Create new Product'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: StoredProductsWidget(),
                ),
                const ProductSearch(), // Assuming you have a SearchBarWidget defined somewhere
              ],
            ),
            Center(
              child: Card(
                child: InkWell(
                  onTap: () {
                    // Handle create new recipe action
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Coming Soon'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
