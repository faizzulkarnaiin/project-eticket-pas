// ignore_for_file: unnecessary_overrides, avoid_print, avoid_function_literals_in_foreach_calls, unused_local_variable, unnecessary_null_comparison

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/model/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxString userId = ''.obs;
  List<Transkaksi> transaksiDataList = [];
  List<PaymentMethod> paymentDataList = [];
  List<Bus> busDataList = [];
  List<JadwalBus> jadwalDataList = [];
  RxBool status = false.obs;
  RxBool konci = false.obs;

  cekData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var userUid = prefs.getString('userId');
    if (userUid != null) {
      userId.value = userUid;
    }
  }

  getTranskasi() async {
    try {
      print('uid -----> ${userId.value}');
      final transaksi = await fs
          .collection("transaksi")
          .where('userId', isEqualTo: userId.value)
          .get();
      print("dddd");
      print('docs trans ${transaksi.docs}');
      if (transaksi.docs.isNotEmpty) {
        transaksi.docs.forEach((e) async {
          final transaksiId = e.id;
          final transaksiData = e.data() as Map;
          final jadwalRef = transaksiData['jadwalBusId'] as DocumentReference;
          print("ok1");

          final jadwalId = jadwalRef.id;
          final jadwalDocs =
              await fs.collection('jadwal_bus').doc(jadwalId).get();
          final jadwalData = jadwalDocs.data() as Map;
          print("ok2");

          var busRef = jadwalData['busId'] as DocumentReference;
          var busId = busRef.id;
          print("ok3");

          var busDoc = await fs.collection('bus').doc(busId).get();
          var busData = busDoc.data() as Map;

          final paymentRef =
              transaksiData['paymentMethodId'] as DocumentReference;

          final paymentId = paymentRef.id;
          final paymentDocs =
              await fs.collection('metodePembayaran').doc(paymentId).get();
          final paymentData = paymentDocs.data() as Map;
          print("ok");
          if (transaksiData != null) {
            Transkaksi transkaksiItem =
                Transkaksi.fromJson(Map.from(e.data()), e.id);
            JadwalBus jadwalitem = JadwalBus.fromJson(
                Map<String, dynamic>.from(jadwalData), jadwalDocs.id);
            Bus busItem =
                Bus.fromJson(Map<String, dynamic>.from(busData), busDoc.id);
            PaymentMethod paymentItem = PaymentMethod.fromJson(
                Map<String, dynamic>.from(paymentData), paymentDocs.id);
            print("ok4");

            transaksiDataList.add(transkaksiItem);
            jadwalDataList.add(jadwalitem);
            paymentDataList.add(paymentItem);
            busDataList.add(busItem);
            status.value = true;
          }
          print("data ----> $transaksiData");
        });
      } else {
        print('cuk');
        print('cuk ${transaksi.docs.length}');
        print('cuk ${transaksi.docs.isEmpty ? 'd' : 'ce'}');
        konci.value = true;
      }
    } catch (e) {
      print('ada kesalahan : $e');
    }
  }

  @override
  void onInit() async {
    await cekData();
    await getTranskasi();
    super.onInit();
  }
}
