import 'dart:convert';
import 'package:http/http.dart' as http;

import 'product_item.dart';

class ProductService {
  final String apiUrl = 'https://world.openfoodfacts.net/api/v3/product/';

  ProductService();

  Future<Product> fetchProduct(String barcode) async {
    final response = await http
        .get(Uri.parse(apiUrl + barcode))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final product = Product.fromJson(jsonDecode(response.body));
      return product;
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
