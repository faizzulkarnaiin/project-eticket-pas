// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class CreateJadwalController extends GetxController {
  RxString tanggal = ''.obs;
  RxBool status = true.obs;
  RxString selectedBusId = ''.obs;
  FirebaseFirestore fs = FirebaseFirestore.instance;
  TextEditingController harga = TextEditingController();
  TextEditingController tujuan = TextEditingController();
  List<Bus> data = [];

  getBus() async {
    final bus = await fs.collection("bus").get();
    if (bus.docs.isNotEmpty) {
      print(bus.docs);

      bus.docs.map((e) {
        print(e.id);
        Bus busList = Bus.fromJson(Map.from(e.data()), e.id);
        data.add(busList);
      }).toList();
      status.value = true;
    }
  }

  saveJadwalBus() async {
    FirebaseFirestore fs = FirebaseFirestore.instance;
    DocumentReference busRef = fs.collection("bus").doc(selectedBusId.value);
    CollectionReference jadwal = fs.collection("jadwal_bus");

    final jadwalData = {
      "busId": busRef,
      "harga": int.parse(harga.text),
      "tujuan": tujuan.text,
      "jadwal_berangkat": tanggal.value
    };

    try {
      await jadwal.add(jadwalData).then((value) {
        Get.defaultDialog(
            middleText: 'Berhasil Menambahkan Jadwal', title: 'Success');
      });
      Get.offAllNamed(Routes.JADWAL_BUS);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menambahkan BusJadwal', title: 'No');
    }
  }

  @override
  void onInit() {
    getBus();
    super.onInit();
  }
}
