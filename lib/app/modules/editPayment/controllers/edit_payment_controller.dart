import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class EditPaymentController extends GetxController {
 FirebaseFirestore fs = FirebaseFirestore.instance;

  TextEditingController namaPembayaran  = TextEditingController();
   updateVariables(PaymentMethod data) {
    namaPembayaran.text = data.nama;
  }

  updatepayment(String id) async {
    CollectionReference payment = fs.collection("metodePembayaran");

    final paymentData = {
      "nama": namaPembayaran.text,
     
    };

    try {
      await payment.doc(id).update(paymentData);
      Get.defaultDialog(
          middleText: 'Berhasil Mengupdate paymeny method', title: 'Success');
      Get.offAllNamed(Routes.PAYMENY_METHOD);
      // await produk.update(prodcutData);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menambahkan Bus', title: 'No');
    }
  }
}
