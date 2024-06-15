// ignore_for_file: avoid_print


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class EditDiskonController extends GetxController {
  TextEditingController presentasiDiskon = TextEditingController();
  RxString selectedDiscountType = "".obs;
  var selectedJadwalBusId = '';
  var selectedPaymentId = '';
  RxString selectedId = ''.obs;
  RxString p = ''.obs;
  RxBool statusGetP = false.obs;
  RxBool status = false.obs;
  RxBool statusB = true.obs;
  RxBool status1 = false.obs;
  FirebaseFirestore fs = FirebaseFirestore.instance;
  List<PaymentMethod> dataPembayaran = [];
  List<JadwalBus> dataJadwal = [];
  fillControllers(Map<String, dynamic> diskon) {
    selectedDiscountType.value = diskon['type'];
    presentasiDiskon.text = diskon['discountPercentage'].toString();
    if (diskon['type'] == 'jadwal_bus' && diskon['jadwal_bus'] != null) {
      selectedJadwalBusId = diskon['jadwal_bus']['id'] ?? "";
    } else if (diskon['type'] == 'metode_pembayaran' &&
        diskon['metode_pembayaran'] != null) {
      selectedPaymentId = diskon['metodePembayaran']['id'] ?? "";
    }
  }

  updatePaymentDiskon(String id) async {
    CollectionReference diskon = fs.collection("diskon");
    DocumentReference paymentRef =
        fs.collection("metodePembayaran").doc(selectedPaymentId);

    final diskonData = {
      "discountPercentage": int.parse(presentasiDiskon.text),
      'type': 'metode_pembayaran',
      'metodePembayaranId': paymentRef,
      "jadwalBusId": null
    };

    try {
      await diskon.doc(id).update(diskonData);
      Get.defaultDialog(
          middleText: 'Berhasil Mengupdate Diskon', title: 'Success');
      Get.offAllNamed(Routes.DISKON);
      // await produk.update(prodcutData);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Mengupdate Diskon', title: 'No');
    }
  }

  updateTujuanDiskon(String id) async {
    CollectionReference diskon = fs.collection("diskon");
    DocumentReference jadwalRef =
        fs.collection("jadwal_bus").doc(selectedJadwalBusId);

    final diskonData = {
      "discountPercentage": int.parse(presentasiDiskon.text),
      'type': 'jadwal_bus',
      'metodePembayaranId': null  ,
      "jadwalBusId": jadwalRef
    };

    try {
      await diskon.doc(id).update(diskonData);
      Get.defaultDialog(
          middleText: 'Berhasil Mengupdate Diskon', title: 'Success');
      Get.offAllNamed(Routes.DISKON);
      // await produk.update(prodcutData);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Mengupdate dISKON', title: 'No');
    }
  }

  void updateDiskon(e) {
    if (selectedDiscountType.value == 'metode_pembayaran') {
      // Handle metode pembayaran
      updatePaymentDiskon(e);
    } else if (selectedDiscountType.value == 'jadwal_bus') {
      // Handle jadwal bus
      updateTujuanDiskon(e);
    }
  }

  getJadwalBus() async {
    final jadwal = await fs.collection("jadwal_bus").get();
    if (jadwal.docs.isNotEmpty) {
      print(jadwal.docs);

      jadwal.docs.map((e) {
        print(e.id);
        JadwalBus jadwalList = JadwalBus.fromJson(Map.from(e.data()), e.id);
        dataJadwal.add(jadwalList);
      }).toList();
      statusGetP.value = true;
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
      status1.value = true;
    }
  }

  @override
  void onInit() {
    getJadwalBus();
    getPaymentMethod();
    // print('ddddddddddd $dataBus');
    super.onInit();
  }
}
