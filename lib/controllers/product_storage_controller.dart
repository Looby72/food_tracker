import 'package:flutter/material.dart';

import '../data/internal_product.dart';
import '../services/product_storage_service.dart';

class ProductStorageController with ChangeNotifier {
  final ProductStorageService _productStorageService;
  late Map<String, InternalProduct> _productRepository;

  ProductStorageController(this._productStorageService) {
    _productRepository = {};
    _loadProducts();
  }

  /// Loads the products from the storage
  Future<void> _loadProducts() async {
    _productRepository.clear();
    final products = await _productStorageService.getProducts();
    for (final product in products) {
      _productRepository[product.id] = product;
    }
    notifyListeners();
  }
}
