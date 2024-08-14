import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'daily_products_list.dart'; // Importieren Sie die DailyProductsList Klasse

class DailyFood extends StatelessWidget {
  const DailyFood({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyProductsList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Heutige Produkte'),
        ),
        body: Consumer<DailyProductsList>(
          builder: (context, dailyProductsList, child) {
            return ListView.builder(
              itemCount: dailyProductsList.products.length,
              itemBuilder: (context, index) {
                final product = dailyProductsList.products[index];
                return ListTile(
                  title: Text(product.productName ?? 'Unbekanntes Produkt'),
                  subtitle: Text(product.brands ?? 'Unbekannte Marke'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
