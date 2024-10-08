import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:uuid/uuid.dart';

/// A class for the internal representation of a product
class InternalProduct {
  static const Uuid _uuid = Uuid();

  final String name;
  final String id;
  final String? imageUrl;
  final String? brand;
  final double proteinPer100;
  final double carbsPer100;
  final double fatPer100;
  final double energyPer100;

  /// unnamed constructor for InternalProduct to create an instance by hand
  InternalProduct({
    required this.name,
    required this.proteinPer100,
    required this.carbsPer100,
    required this.fatPer100,
    required this.energyPer100,
  })  : id = 'in_p_${_uuid.v4()}',
        imageUrl = null,
        brand = null;

  /// Create the internal representation of a product from a [Product] object
  InternalProduct.fromProduct({required Product product})
      : name = product.productName ?? 'UnknownName',
        id = product.barcode != null
            ? 'ex_p_${product.barcode}'
            : 'ex_p_${_uuid.v4()}',
        imageUrl = product.imageFrontUrl,
        brand = product.brands,
        proteinPer100 = (product.nutriments
                ?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ??
            0),
        carbsPer100 = (product.nutriments
                ?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ??
            0),
        fatPer100 = (product.nutriments
                ?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ??
            0),
        energyPer100 =
            (product.nutriments?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0);

  InternalProduct.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        proteinPer100 = json['protein'],
        carbsPer100 = json['carbs'],
        fatPer100 = json['fat'],
        energyPer100 = json['energy'],
        imageUrl = json['imageUrl'],
        brand = json['brand'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'protein': proteinPer100,
      'carbs': carbsPer100,
      'fat': fatPer100,
      'energy': energyPer100,
      'imageUrl': imageUrl,
      'brand': brand,
    };
  }
}
