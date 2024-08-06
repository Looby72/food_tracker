import 'package:flutter/material.dart';

import 'product_item.dart';
import 'product_service.dart';

class BarcodeInputWidget extends StatefulWidget {
  const BarcodeInputWidget({super.key});

  @override
  BarcodeInputWidgetState createState() => BarcodeInputWidgetState();
}

class BarcodeInputWidgetState extends State<BarcodeInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final _barcodeController = TextEditingController();
  Future<Product>? _futureProduct;

  Future<void> _submitBarcode() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _futureProduct = ProductService().fetchProduct(_barcodeController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _barcodeController,
                decoration:
                    const InputDecoration(labelText: 'Enter a barcode number'),
                keyboardType: TextInputType.number,
                maxLength: 13,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a barcode';
                  } else if (value.length < 12) {
                    return 'Barcode number must be at least 12 digits';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _submitBarcode,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: (_futureProduct == null)
                      ? null
                      : FutureBuilder<Product>(
                          future: _futureProduct,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final product = snapshot.data!;
                              return Column(
                                children: <Widget>[
                                  Image.network(product.imageUrl),
                                  Text('Name: ${product.name}'),
                                  Text('Barcode: ${product.barcode}'),
                                  Text('Calories: ${product.calories}'),
                                  Text('Fat: ${product.fat}'),
                                  Text('Carbs: ${product.carbs}'),
                                  Text('Protein: ${product.protein}'),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            return const CircularProgressIndicator();
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }
}
