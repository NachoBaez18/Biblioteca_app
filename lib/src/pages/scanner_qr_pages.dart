import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../models/accionLibroResponse.dart';
import '../provider/provider.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  // Barcode? barcode;

  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: builQrView(context),
        ),
      ),
    );
  }

  Widget builQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: const Color(0xff317183),
        borderLength: 20,
        borderRadius: 10,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    final provider = Provider.of<FilterListProvider>(context, listen: false);
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((barcode) {
      print(barcode.code);
      provider.librosPendientes = accionLibroResponseFromMap(barcode.code!);
      if (barcode.code != '' || barcode.code != null) {
        Navigator.pushReplacementNamed(context, 'accion_alumno');
      }
    });
  }
}
