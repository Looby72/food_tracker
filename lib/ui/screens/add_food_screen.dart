import 'package:flutter/material.dart';

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
            const Column(
              children: [
                ProductSearch(),
                SizedBox(height: 16.0),
                Expanded(
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
