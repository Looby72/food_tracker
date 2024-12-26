import 'package:flutter/material.dart';

import '../../data/routes.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/stored_products_widget.dart';
import 'base_screen.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Screen(
        title: 'Essen aufzeichnen',
        appBarBottom: const TabBar(
          tabs: [
            Tab(text: 'Produkte'),
            Tab(text: 'Rezepte'),
          ],
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                const ProductSearch(),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Theme.of(context).colorScheme.tertiary,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.createProduct);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Manuell hinzufügen',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiary)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Expanded(
                  child: StoredProductsWidget(),
                ),
              ],
            ),
            Center(
              child: Card(
                child: InkWell(
                  onTap: () {
                    // Handle create new recipe action
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Coming Soon',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface)),
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
