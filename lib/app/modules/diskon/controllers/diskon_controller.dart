// ignore_for_file: annotate_overrides, avoid_print, unused_local_variable, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/diskon.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class DiskonController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List tempDiskon = [];
  List<JadwalBus> tempJadwalBus = [];
  List<PaymentMethod> tempMetodePembayaran = [];
  RxBool status = false.obs;
  List<DiscountModel> diskonList = [];
  List<Map<String, dynamic>> diskonTempList = [];
  // Future<void> getDiskon() async {
  //   try {
  //     final diskonSnapshot =
  //         await FirebaseFirestore.instance.collection("diskon").get();
  //     if (diskonSnapshot.docs.isNotEmpty) {
  //       for (var element in diskonSnapshot.docs) {
  //         print('lalala');
  //         var diskonData = element.data();
  //         print('lalala2');

  //         if (diskonData.containsKey('metodePembayaranId')) {
  //           var metodePembayaranRef =
  //               diskonData['metodePembayaranId'] as DocumentReference;
  //           var pembayaranId = metodePembayaranRef.id;
  //           var metodePembayaranDoc = await FirebaseFirestore.instance
  //               .collection('metodePembayaran')
  //               .doc(pembayaranId)
  //               .get();
  //           var metodePembayaranData = metodePembayaranDoc.data();
  //           if (metodePembayaranData != null) {
  //             PaymentMethod paymentItem = PaymentMethod.fromJson(
  //                 Map<String, dynamic>.from(metodePembayaranData), element.id);
  //             tempMetodePembayaran.add(paymentItem);
  //             print('tfadadawda');
  //           }
  //         }
  //         if (diskonData.containsKey('jadwalBusId')) {
  //           var jadwalBusRef = diskonData['jadwalBusId'] as DocumentReference;
  //           var jadwalId = jadwalBusRef.id;
  //           var jadwalBusDoc = await FirebaseFirestore.instance
  //               .collection('jadwal_bus')
  //               .doc(jadwalId)
  //               .get();
  //           print('laaaalaladddd $jadwalBusDoc');
  //           var jadwalBusData = jadwalBusDoc.data();
  //           if (jadwalBusData != null) {
  //             JadwalBus jadwaltItem = JadwalBus.fromJson(
  //                 Map<String, dynamic>.from(jadwalBusData), element.id);
  //             print('adadatf');
  //             tempJadwalBus.add(jadwaltItem);
  //           }
  //         }

  //         print('dddddddddddddddddd');
  //         DiscountModel diskonItem = DiscountModel.fromJson(
  //             Map<String, dynamic>.from(diskonData), element.id);
  //         print('tf333');

  //         tempDiskon.add(diskonItem);
  //         status.value = true;
  //       }

  //       status.value = true;
  //       tempDiskon.assignAll(tempDiskon);
  //       tempJadwalBus.assignAll(tempJadwalBus);
  //       tempMetodePembayaran.assignAll(tempMetodePembayaran);
  //       status.value = true;
  //     } else {
  //       print('No documents found in diskon collection.');
  //     }
  //   } catch (e) {
  //     print('Terjadi kesalahan saat mengambil data diskon: $e');
  //   }
  // }
  Future<void> getDiskon() async {
    try {
      QuerySnapshot diskonSnapshot = await firestore.collection('diskon').get();

      for (var doc in diskonSnapshot.docs) {
        Map<String, dynamic> diskonData = doc.data() as Map<String, dynamic>;
        print('doc $doc');
        print('disc $diskonData');
        print('idddddddd ${doc.id}');
        diskonData['id'] = doc.id;
        if (diskonData['type'] == 'jadwal_bus' &&
            diskonData['jadwalBusId'] != null) {
          DocumentReference jadwalRef =
              diskonData['jadwalBusId'] as DocumentReference;
          DocumentSnapshot jadwalDoc = await jadwalRef.get();
          if (jadwalDoc.exists) {
            diskonData['jadwal_bus'] = jadwalDoc.data();
            diskonData['jadwal_bus']['id'] = jadwalDoc.id;
          }
        } else if (diskonData['type'] == 'metode_pembayaran' &&
            diskonData['metodePembayaranId'] != null) {
          DocumentReference metodeRef =
              diskonData['metodePembayaranId'] as DocumentReference;
          DocumentSnapshot metodeDoc = await metodeRef.get();
          if (metodeDoc.exists) {
            diskonData['metode_pembayaran'] = metodeDoc.data();
            diskonData['metode_pembayaran']['id'] = metodeDoc.id;
          }
        }
        print('masukkin status');
        diskonTempList.add(diskonData);
        print('masukkin data $diskonTempList');
        print('length ${diskonTempList.length}');
        print('status2 $status');
      }
      print('status $status');
      status.value = true;
    } catch (e) {
      Get.defaultDialog(
          middleText: 'Gagal Mengambil Diskon: $e', title: 'Error');
    }
  }

  deleteDiskon(String id) async {
    try {
      await fs.collection("diskon").doc(id).delete();
      Get.defaultDialog(
          middleText: 'Berhasil Menghapus Diskon dengan id $id',
          title: 'Success');
      Get.offAllNamed(Routes.DISKON);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menghapus Diskon', title: 'Gagal');
    }
  }

  void onInit() {
    getDiskon();
    print('dataaaaa $tempDiskon');
    print('jadwalList $tempJadwalBus');
    print('diskonTempList ------------> $diskonTempList');

    print('pay $tempMetodePembayaran');
    print('ok');
    print('diskonTempList ------------> $diskonTempList');
    print('status $status');
    super.onInit();
    print('diskonTempList ------------> $diskonTempList');
  }
}
