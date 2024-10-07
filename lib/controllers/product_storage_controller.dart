import 'package:flutter/material.dart';

import '../data/internal_product.dart';
import '../services/product_storage_service.dart';

class ProductStorageController with ChangeNotifier {
  final ProductStorageService _productStorageService = ProductStorageService();
  final Map<String, InternalProduct> _productRepository = {};

  ProductStorageController() {
    _loadProducts();
  }

  /// Getter for the product repository
  /// Returns a list of all products in the repository
  List<InternalProduct> get products => _productRepository.values.toList();

  /// Loads the products from the storage
  Future<void> _loadProducts() async {
    _productRepository.clear();
    final products = await _productStorageService.getProducts();
    for (final product in products) {
      _productRepository[product.id] = product;
    }
    notifyListeners();
  }

  /// Add a product to the product storage
  void addProduct(InternalProduct product) {
    _productRepository[product.id] = product;
    _productStorageService.saveProducts(_productRepository.values.toList());
    notifyListeners();
  }
}
