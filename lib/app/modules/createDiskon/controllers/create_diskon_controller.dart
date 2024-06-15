// ignore_for_file: avoid_print, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class CreateDiskonController extends GetxController {
  TextEditingController presentasiDiskon = TextEditingController();
  RxString selectedDiscountType = "Metode Pembayaran".obs;
  List<PaymentMethod> dataPembayaran = [];
  List<JadwalBus> dataJadwal = [];
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool status = true.obs;
  RxString selectedJadwalBusId = ''.obs;
  RxString selectedPaymentId = ''.obs;

  getJadwalBus() async {
    final jadwal = await fs.collection("jadwal_bus").get();
    if (jadwal.docs.isNotEmpty) {
      print(jadwal.docs);

      jadwal.docs.map((e) {
        print(e.id);
        JadwalBus jadwalList = JadwalBus.fromJson(Map.from(e.data()), e.id);
        dataJadwal.add(jadwalList);
      }).toList();
      status.value = true;
    }
  }

  getPaymentMethod() async {
    final payment = await fs.collection("metodePembayaran").get();
    if (payment.docs.isNotEmpty) {
      print(payment.docs);

      payment.docs.map((e) {
        print(e.id);
        PaymentMethod paymentList =
            PaymentMethod.fromJson(Map.from(e.data()), e.id);
        dataPembayaran.add(paymentList);
      }).toList();
      status.value = true;
    }
  }

  void createDiskon() {
    if (selectedDiscountType.value == 'Metode Pembayaran') {
      // Handle metode pembayaran
      createMetodePembayaranDiskon();
    } else if (selectedDiscountType.value == 'Jadwal Bus') {
      // Handle jadwal bus
      createJadwalBusDiskon();
    }
  }

  // Fungsi untuk membuat diskon untuk metode pembayaran
  void createMetodePembayaranDiskon() async {
    DocumentReference pembayaranRef =
        fs.collection("metodePembayaran").doc(selectedPaymentId.value);
    CollectionReference diskon = fs.collection("diskon");
    Map<String, dynamic> diskonData = {
      'discountPercentage': int.parse(presentasiDiskon.text),
      'type': 'metode_pembayaran',
      'metodePembayaranId': pembayaranRef,
      "jadwalBusId": null
    };

    try {
      await diskon.add(diskonData).then((value) {
        Get.defaultDialog(
            middleText: 'Berhasil Menambahkan Diskon', title: 'Success');
      });
      Get.offAllNamed(Routes.DISKON);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menambahkan Diskon', title: 'No');
    }
  }

  createJadwalBusDiskon() async {
    DocumentReference jadwalRef =
        fs.collection("jadwal_bus").doc(selectedJadwalBusId.value);
    CollectionReference diskon = fs.collection("diskon");

    Map<String, dynamic> diskonData = {
      'discountPercentage': int.parse(presentasiDiskon.text),
      'type': 'jadwal_bus',
      'jadwalBusId': jadwalRef,
      "metodePembayaranId": null
    };
    try {
      await diskon.add(diskonData).then((value) {
        Get.defaultDialog(
            middleText: 'Berhasil Menambahkan Diskon', title: 'Success');
      });
      Get.offAllNamed(Routes.DISKON);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menambahkan Diskon', title: 'No');
    }
  }

  @override
  void onInit() {
    getJadwalBus();
    getPaymentMethod();
    super.onInit();
  }
}

class DiscountService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveDiscount(Map<String, dynamic> discountData) async {
    CollectionReference discounts = _firestore.collection("discounts");

    try {
      await discounts.add(discountData).then((value) {
        print('Berhasil Menambahkan Diskon');
      });
    } catch (e) {
      print('Gagal Menambahkan Diskon: $e');
    }
  }
}
