import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/internal_product.dart';
import '../../data/product_query.dart';
import '../../data/routes.dart';

class BarcodeScannerWidget extends StatefulWidget {
  const BarcodeScannerWidget({super.key});

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScannerWidget> {
  String? scanResult;
  final ScanOptions options = const ScanOptions(
    strings: {
      'cancel': 'Abbrechen',
      'flash_on': '',
      'flash_off': '',
    },
    restrictFormat: [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.code128
    ],
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;

    return Column(
      children: [
        Card(
          child: InkWell(
            onTap: _scan,
            child: const Padding(
                padding: EdgeInsets.all(16.0), child: Text('Scan a Barcode')),
          ),
        ),
        if (scanResult != null && scanResult != '') Text(scanResult)
      ],
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(options: options);

      if (result.type == ResultType.Cancelled) {
        setState(() {
          scanResult = null;
        });
        return;
      }
      final product = await queryByBarcode(result.rawContent);

      // check if the widget is still mounted
      // we have to do this because the scan method is async and the widget
      // could be disposed before the result is returned
      if (!mounted) return;

      if (product != null) {
        final intProduct = InternalProduct.fromProduct(product: product);
        Navigator.pushNamed(context, Routes.productDetail,
            arguments: intProduct);
      } else {
        setState(() {
          scanResult = 'Product not found :(';
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        scanResult = e.code == BarcodeScanner.cameraAccessDenied
            ? 'The user did not grant the camera permission!'
            : 'Unknown error: $e';
      });
    }
  }
}
