// ignore_for_file: avoid_print, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/newBus.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class EditJadwalController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;

  RxString tanggal = ''.obs;
  RxBool status = false.obs;
  RxBool statusJ = false.obs;
  RxString selectedBusId = ''.obs;
  RxString selectBusId = ''.obs;
  TextEditingController harga = TextEditingController();
  TextEditingController namaBus = TextEditingController();
  TextEditingController tujuan = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<Bus> dataBus = [];
  List<Bus> dataBusNew = [];
  List<JadwalBus> dataJadwalBus = [];
  
 getBus() async {
    final bus = await fs.collection("bus").get();
    if (bus.docs.isNotEmpty) {
      print(bus.docs);

      bus.docs.map((e) {
        print(e.id);
        Bus busList = Bus.fromJson(Map.from(e.data()), e.id);
        dataBusNew.add(busList);
      }).toList();
      status.value = true;
    }
  }

  updateVariables(Bus data, JadwalBus dataJadwal) {
    tanggal.value = dataJadwal.jadwalBerangkat;
    selectedBusId.value = data.id;
    dateController.text = dataJadwal.jadwalBerangkat;
    // selectBusId.value = data.id;
    namaBus.text = data.name;
    harga.text = dataJadwal.harga.toString();
    tujuan.text = dataJadwal.tujuan;
  }

  updateJadwal(String id) async {
    CollectionReference jadwal = fs.collection("jadwal_bus");
    DocumentReference busRef = fs.collection("bus").doc(selectedBusId.value);

    final jadwalData = {
      "busId": busRef,
      "harga": int.parse(harga.text),
      "tujuan": tujuan.text,
      "jadwal_berangkat": tanggal.value
    };

    try {
      await jadwal.doc(id).update(jadwalData);
      Get.defaultDialog(
          middleText: 'Berhasil Mengupdate Jadwal', title: 'Success');
      Get.offAllNamed(Routes.JADWAL_BUS);
      // await produk.update(prodcutData);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Mengupdate Jadwal', title: 'No');
    }
  }
  @override
  void onInit() {
    getBus();
    print('ddddddddddd $dataBus');
    super.onInit();
  }
}
