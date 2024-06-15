// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class BusController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool status = false.obs;
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

  deleteBus(String id) async {
    try {
      await fs.collection("bus").doc(id).delete();
      Get.defaultDialog(
          middleText: 'Berhasil Menghapus bus dengan id $id', title: 'Success');
      Get.offAllNamed(Routes.BUS);

    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menghapus bus', title: 'Gagal');
    }
  }

  @override
  void onInit() {
    getBus();
    super.onInit();
  }
}
