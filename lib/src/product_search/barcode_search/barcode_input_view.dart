import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class BarcodeInputWidget extends StatefulWidget {
  const BarcodeInputWidget({super.key});

  @override
  BarcodeInputWidgetState createState() => BarcodeInputWidgetState();
}

class BarcodeInputWidgetState extends State<BarcodeInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final _barcodeController = TextEditingController();
  Future<ProductResultV3>? _futureProduct;

  //callback function to submit barcode for pressing the submit button
  //checks if the form is valid
  //fetches the product data from the API and stores it as Future<Product>
  //if future is resolved, the future builder will display the product data
  Future<void> _submitBarcode() async {
    if (_formKey.currentState!.validate()) {
      final ProductQueryConfiguration configuration = ProductQueryConfiguration(
        _barcodeController.text,
        language: OpenFoodFactsLanguage.GERMAN,
        fields: [ProductField.ALL],
        version: ProductQueryVersion.v3,
      );
      setState(() {
        _futureProduct = OpenFoodAPIClient.getProductV3(configuration);
      });
    }
  }

  //builder function for displaying the product data
  Widget _buildProductInfo(
      BuildContext context, AsyncSnapshot<ProductResultV3> snapshot) {
    if (snapshot.hasData) {
      final result = snapshot.data!;
      if (result.product == null) {
        return const Text('Product not found');
      } else {
        final product = result.product!;
        return Column(
          children: <Widget>[
            Image.network(product.imageNutritionSmallUrl!),
            Text('Name: ${product.productName}'),
            Text('Barcode: ${product.barcode}'),
            Text(
                'Calories: ${product.nutriments!.getComputedKJ(PerSize.oneHundredGrams)}'),
            Text(
                'Fat: ${product.nutriments!.getValue(Nutrient.fat, PerSize.oneHundredGrams)}'),
            Text(
                'Carbs: ${product.nutriments!.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams)}'),
            Text(
                'Protein: ${product.nutriments!.getValue(Nutrient.proteins, PerSize.oneHundredGrams)}'),
          ],
        );
      }
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    return const CircularProgressIndicator();
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
                      ? const Text('Nothing to see yet')
                      : FutureBuilder<ProductResultV3>(
                          future: _futureProduct,
                          builder: (context, snapshot) {
                            return _buildProductInfo(context, snapshot);
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
