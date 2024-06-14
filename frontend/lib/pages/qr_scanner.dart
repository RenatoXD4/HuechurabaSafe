import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
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
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  
  late QRViewController controller;
  MobileScannerController cameraController = MobileScannerController();
  String? scannedUrl = '';

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Scanner'),
          actions: [
            IconButton(
              icon: const Icon(Icons.flash_on),
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              icon: const Icon(Icons.cameraswitch),
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: MobileScanner(
         controller: cameraController,
            onDetect: (barcode) async {
              final Object code = barcode.raw ?? 'Failed to scan Barcode';
              print('Barcode found! $code');

              setState(() {
                scannedUrl = code as String?;
              });

              if (await canLaunchUrlString(scannedUrl!)) {
                await launchUrlString(scannedUrl!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No se puede validar la URL: $scannedUrl')),
                );
              }

              // Reanudar la cámara después de lanzar el enlace
              cameraController.stop();
            },
          ),
      );
    }





  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
