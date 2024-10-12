import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeScannerWidget extends StatefulWidget {
  const BarcodeScannerWidget({super.key});

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScannerWidget> {
  ScanResult? scanResult;
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
        if (scanResult != null && scanResult.rawContent != '')
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Result'),
                  subtitle: Text(scanResult.rawContent),
                ),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: _scan,
          child: const Text('Scan'),
        ),
      ],
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(options: options);
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}
