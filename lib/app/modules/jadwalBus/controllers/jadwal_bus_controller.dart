// ignore_for_file: unused_import, avoid_print, annotate_overrides, override_on_non_overriding_member, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unused_local_variable, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class JadwalBusController extends GetxController {
  RxString tanggal = ''.obs;
  RxBool status = false.obs;
  List<JadwalBus> data = [];
  List<JadwalBus> jadwalList = [];
  List<Bus> dataBusDiJadwal = [];
  FirebaseFirestore fs = FirebaseFirestore.instance;

  Future<void> getJadwal() async {
    try {
      final jadwalBusSnapshot =
          await FirebaseFirestore.instance.collection("jadwal_bus").get();
      if (jadwalBusSnapshot.docs.isNotEmpty) {
        List<JadwalBus> tempData = [];
        List<Bus> tempBusData = [];
        for (var element in jadwalBusSnapshot.docs) {
          var jadwalData = element.data();
          var busRef = jadwalData['busId'] as DocumentReference;
          var busId = busRef.id;

          var busDoc = await FirebaseFirestore.instance
              .collection('bus')
              .doc(busId)
              .get();

          if (busDoc.exists) {
            print('ddddd $busDoc');
            print('dddd ${busDoc.exists ? 'dada' : 'dd'}');
            var busData = busDoc.data();
            if (busData != null) {
              JadwalBus jadwalBusItem = JadwalBus.fromJson(
                  Map<String, dynamic>.from(jadwalData), element.id);
              Bus busItem =
                  Bus.fromJson(Map<String, dynamic>.from(busData), busDoc.id);
              tempData.add(jadwalBusItem);
              tempBusData.add(busItem);
            }
          }
        }
        data.assignAll(tempData);
        dataBusDiJadwal.assignAll(tempBusData);
        status.value = true;
        print('Data successfully loaded: ${data.length} items');
      } else {
        print('No documents found in jadwal_bus collection.');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  //   jadwal_bus.docs.map((e) {
  //     print(e.id);
  //     print("ok");
  //     // print();
  //     JadwalBus jadwalList = JadwalBus.fromJson(Map.from(e.data()), e.id);
  //     print("hmmmmm");

  //     data.add(jadwalList);
  //     print("ok2");
  //   }).toList();
  //   status.value = true;
  // }

  // void getJadwal() async {
  //   try {
  //     final jadwalBusSnapshot =
  //       await FirebaseFirestore.instance.collection("jadwal_bus").get();

  //   List<JadwalBus> tempList = [];
  //   for (var jadwalDoc in jadwalBusSnapshot.docs) {
  //     var jadwalData = Map<String, dynamic>.from(jadwalDoc.data() as Map);
  //     DocumentReference busRef = jadwalData['busId'];
  //     print('okkadad');

  //     // Retrieve the referenced bus document
  //     var busSnapshot = await busRef.get();
  //     var busData = Map<String, dynamic>.from(busSnapshot.data() as Map);
  //     print('okkadada');

  //     // Combine data from both documents
  //     var combinedData = {
  //       ...jadwalData,
  //       'busDetails': busData,
  //     };
  //     print('adadokk');

  //     JadwalBus jadwal = JadwalBus.fromJson(combinedData, jadwalDoc.id);

  //     print('okk');
  //     tempList.add(jadwal);
  //   }
  //     print('okk');

  //   jadwalList.assignAll(tempList);
  //     print('okk1');

  //   status.value = true;
  //     print('okk2');
  //   } catch (e) {
  //     print('errr $e');
  //   }

  // }

  deleteJadwal(String id) async {
    try {
      await fs.collection("jadwal_bus").doc(id).delete();
      Get.defaultDialog(
          middleText: 'Berhasil Menghapus bus dengan id $id', title: 'Success');
      Get.offAllNamed(Routes.JADWAL_BUS);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menghapus bus', title: 'Gagal');
    }
  }

  void onInit() {
    getJadwal();
    print('dataaaaa $data');
    print('jadwalList $jadwalList');
    print('ok');
    super.onInit();
  }
}
