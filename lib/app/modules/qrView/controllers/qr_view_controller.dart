// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class QrViewController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  scanQr() async {
    String qr = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Batal", true, ScanMode.QR);

    Get.defaultDialog(middleText: "hasil scan adalah ${qr}");
  }

  Future<void> scanQr1(String transactionId) async {
    try {
      DocumentSnapshot transactionDoc =
          await fs.collection('transaksi').doc(transactionId).get();
      if (transactionDoc.exists) {
        Map<String, dynamic> transactionData =
            transactionDoc.data() as Map<String, dynamic>;

        if (transactionData['isScanned'] == true) {
          Get.defaultDialog(
            title: 'Warning',
            middleText: 'This QR code has already been scanned.',
          );
        } else {
          await fs.collection('transaksi').doc(transactionId).update({
            'isScanned': true,
          });
          Get.defaultDialog(
            title: 'Success',
            middleText: 'QR ($transactionId) code scanned successfully.',
          );
        }
      } else {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Transaction not found.',
        );
      }
    } catch (e) {
      print('Error scanning QR: $e');
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to scan QR code: $e',
      );
    }
  }
}
