import 'package:flutter/material.dart';
import 'package:food_tracker/ui/widgets/barcode_scanner_widget.dart';

class BarcodeScanScreen extends StatelessWidget {
  const BarcodeScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scan'),
      ),
      body: const Center(
        child: BarcodeScannerWidget(),
      ),
    );
  }
}
