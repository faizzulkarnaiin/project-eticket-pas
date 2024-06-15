import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class CreateBusController extends GetxController {
  TextEditingController busName = TextEditingController();
  TextEditingController busType = TextEditingController();
  TextEditingController busCapaity = TextEditingController();

  saveBus() async {
    FirebaseFirestore fs = FirebaseFirestore.instance;

    CollectionReference bus = fs.collection("bus");

    final busData = {
      'name': busName.text,
      'type': busType.text,
      'capacity': int.parse(busCapaity.text)
    };

    try {
      await bus.add(busData).then((value) {
        Get.defaultDialog(
            middleText: 'Berhasil Menambahkan Bus', title: 'Success');
      });
      Get.offAllNamed(Routes.BUS);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menambahkan Bus', title: 'No');
    }
  }
}
