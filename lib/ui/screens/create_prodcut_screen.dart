import 'package:flutter/material.dart';

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

      // Handle the created product (e.g., save it to a database or state management solution)
      print('Product created: ${product.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _carbsController,
                decoration: InputDecoration(labelText: 'Carbs (per 100g)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter carbs';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fatController,
                decoration: InputDecoration(labelText: 'Fat (per 100g)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter fat';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _proteinsController,
                decoration: InputDecoration(labelText: 'Proteins (per 100g)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter proteins';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _energyController,
                decoration: InputDecoration(labelText: 'Energy (per 100g)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter energy';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createProduct,
                child: Text('Create Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
