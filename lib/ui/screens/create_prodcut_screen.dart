import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_storage_controller.dart';
import '../../data/internal_product.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _proteinsController = TextEditingController();
  final _energyController = TextEditingController();

  void _createProduct() {
    if (_formKey.currentState!.validate()) {
      final product = InternalProduct(
        name: _nameController.text,
        carbsPer100: double.parse(_carbsController.text),
        fatPer100: double.parse(_fatController.text),
        proteinPer100: double.parse(_proteinsController.text),
        energyPer100: double.parse(_energyController.text),
      );

      // Add the product to the product storage
      Provider.of<ProductStorageController>(context, listen: false)
          .addProduct(product);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Produkt erstellen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Produktname eingeben';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _carbsController,
                decoration: const InputDecoration(
                    labelText: 'Kohlenhydrate (g pro 100g)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'Bitte eine gültige Zahl eingeben';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fatController,
                decoration:
                    const InputDecoration(labelText: 'Fett (g pro 100g)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'Bitte eine gültige Zahl eingeben';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _proteinsController,
                decoration:
                    const InputDecoration(labelText: 'Proteine (g pro 100g)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'Bitte eine gültige Zahl eingeben';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _energyController,
                decoration:
                    const InputDecoration(labelText: 'Energie (kJ pro 100g)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'Bitte eine gültige Zahl eingeben';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createProduct,
                child: const Text('Produkt erstellen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
