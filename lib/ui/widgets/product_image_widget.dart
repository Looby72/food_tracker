import 'package:flutter/material.dart';

class ProductImg extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  const ProductImg({
    super.key,
    this.imageUrl,
    this.width = 100.0,
    this.height = 100.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl ?? '',
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Image.asset(
            'assets/images/app_logo_foreground.png',
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/app_logo_foreground.png',
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
