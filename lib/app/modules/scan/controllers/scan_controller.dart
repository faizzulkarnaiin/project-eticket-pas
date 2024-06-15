// ignore_for_file: unnecessary_overrides

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  scanQr() async {
    String qr = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Batal", true, ScanMode.QR);

    Get.defaultDialog(middleText: "hasil scan adalah ${qr}");
  }
}
