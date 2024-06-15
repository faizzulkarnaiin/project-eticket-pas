import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/qr_scan_controller.dart';

class QrScanView extends GetView<QrScanController> {
  QrScanView({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QrScanView'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController qrController) {
                qrController.scannedDataStream.listen((scanData) async {
                  print('ddddd');
                  await controller.scanQr1(scanData.code.toString());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
