class Product {
  final String name;
  final String barcode;
  final String imageUrl;
  final double calories;
  final double fat;
  final double carbs;
  final double protein;

  Product._({
    required this.name,
    required this.barcode,
    required this.imageUrl,
    required this.calories,
    required this.fat,
    required this.carbs,
    required this.protein,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'code': String barcode,
        'product': {
          'product_name': String name,
          'image_url': String imageUrl,
          'nutriments': {
            'energy': dynamic calories,
            'fat': dynamic fat,
            'carbohydrates': dynamic carbs,
            'proteins': dynamic protein,
          },
        },
      } =>
        Product._(
          name: name,
          barcode: barcode,
          imageUrl: imageUrl,
          calories: (calories is int) ? calories.toDouble() : calories,
          fat: (fat is int) ? fat.toDouble() : fat,
          carbs: (carbs is int) ? carbs.toDouble() : carbs,
          protein: (protein is int) ? protein.toDouble() : protein,
        ),
      _ => throw const FormatException(
          'Failed to load Product (unexpected JSON format)'),
    };
  }
}
