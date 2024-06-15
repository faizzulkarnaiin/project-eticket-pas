import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class CreatePaymentController extends GetxController {
  TextEditingController namaPembayaran = TextEditingController();

  saveMethodPayment() async {
    FirebaseFirestore fs = FirebaseFirestore.instance;

    CollectionReference payment = fs.collection("metodePembayaran");

    final paymenyMethodData = {
      'nama': namaPembayaran.text,
    };

    try {
      await payment.add(paymenyMethodData).then((value) {
        Get.defaultDialog(
            middleText: 'Berhasil Menambahkan Bus', title: 'Success');
      });
      Get.offAllNamed(Routes.PAYMENY_METHOD);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menambahkan Bus', title: 'No');
    }
  }
}
