import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class EditBusController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;

  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController capacity = TextEditingController();
  updateVariables(Bus data) {
    name.text = data.name;
    type.text = data.type;
    capacity.text = data.capacity.toString();
  }

  updateBus(String id) async {
    CollectionReference bus = fs.collection("bus");

    final busData = {
      "name": name.text,
      "type": type.text,
      "capacity": int.parse(capacity.text),
    };

    try {
      await bus.doc(id).update(busData);
      Get.defaultDialog(
          middleText: 'Berhasil Mengupdate bus', title: 'Success');
      Get.offAllNamed(Routes.BUS);
      // await produk.update(prodcutData);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menambahkan Bus', title: 'No');
    }
  }
}
