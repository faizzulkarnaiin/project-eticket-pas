// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QrScanController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;

  Future<bool> scanTicket(String transactionId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference transactionRef =
        firestore.collection('transaksi').doc(transactionId);

    try {
      DocumentSnapshot transactionSnapshot = await transactionRef.get();

      if (transactionSnapshot.exists) {
        var data = transactionSnapshot.data() as Map<String, dynamic>?;

        if (data != null && !(data['isScanned'] ?? true)) {
          await transactionRef.update({'isScanned': true});
          return true; // Successfully scanned
        } else {
          return false; // Already scanned or does not exist
        }
      } else {
        return false; // Transaction does not exist
      }
    } catch (e) {
      print('Error scanning ticket: $e');
      return false; // Error occurred
    }
  }

  Future<bool> scanQr(String transactionId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference transactionRef =
        firestore.collection('transactions').doc(transactionId);

    try {
      DocumentSnapshot transactionSnapshot = await transactionRef.get();

      if (transactionSnapshot.exists) {
        var data = transactionSnapshot.data() as Map<String, dynamic>?;

        if (data != null && !(data['isScanned'] ?? true)) {
          await transactionRef.update({'isScanned': true});
          return true; // Successfully scanned
        } else {
          return false; // Already scanned or does not exist
        }
      } else {
        return false; // Transaction does not exist
      }
    } catch (e) {
      print('Error scanning ticket: $e');
      return false; // Error occurred
    }
  }

  Future<void> scanQr1(String transactionId) async {
    try {
      print('konci motor');
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
          print('konci ac');
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
