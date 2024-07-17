import 'package:flutter/material.dart';
import 'package:frontend/pages/scanner_overlay.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:mobile_scanner/mobile_scanner.dart';




class Scanner extends StatefulWidget {
  const Scanner({super.key});


  @override
  State<Scanner> createState() { // Avoid using private types in public APIs.
    return _ScannerState();
  }
}

class _ScannerState extends State<Scanner> {

  final MobileScannerController controller = MobileScannerController();
  
  String? _result;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/home');
            },
          )
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (BarcodeCapture capture) async {
              List<Barcode> barcodes = capture.barcodes;
              final barcode = barcodes.first;
              debugPrint('Barcode found! $barcodes');

              if (barcode.rawValue != null && barcode.rawValue!.contains('/perfilConductor')) {
                setResult(barcode.rawValue);

              if (await canLaunchUrlString(_result!)) {
                  await controller.stop();
                  await launchUrlString(_result!);
                } else {
                  return;
                }
              }
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }

  void setResult(result) {
    setState(() => _result = result);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
