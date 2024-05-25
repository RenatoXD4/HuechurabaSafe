import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_qrcode_scanner/flutter_web_qrcode_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  String? scannedUrl = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        scannedUrl == null
            ? Container()
            : Center(
                child: Text(
                  scannedUrl!,
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
        FlutterWebQrcodeScanner(
          cameraDirection: CameraDirection.back,
          onGetResult: (result) {
            setState(() {
              scannedUrl = result;
            });
            _onQRViewCreated(controller);
          },
          stopOnFirstResult: true,
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          onError: (error) {
            if (kDebugMode) {
              print(error.message);
            }
          },
          onPermissionDeniedError: () {
            //show alert dialog or something
          },
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        scannedUrl = scanData.code!;
      });

      if (await canLaunchUrlString(scannedUrl!)) {
        await launchUrlString(scannedUrl!);
      } else {
        Text('No se puede validar la url:$scannedUrl');
      }

      // Reanudar la cámara después de lanzar el enlace
      controller.resumeCamera();
    });
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
