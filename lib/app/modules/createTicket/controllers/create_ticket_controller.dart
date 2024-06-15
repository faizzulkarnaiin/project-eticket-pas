// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreateTicketController extends GetxController {
  TextEditingController nama = TextEditingController();
  TextEditingController umur = TextEditingController();
  TextEditingController jumlahKursi = TextEditingController();
  FirebaseFirestore fs = FirebaseFirestore.instance;
  List<JadwalBus> dataJadwal = [];
  List<Bus> dataBusDiJadwal = [];
  RxBool harga = false.obs;
  List<PaymentMethod> dataPayment = [];
  RxBool status = false.obs;
  RxBool statusJ = false.obs;
  RxString selectJadwalId = ''.obs;
  RxString selectedPaymentId = ''.obs;
  RxString selectedTicket = ''.obs;
  RxInt hargaAwal = 0.obs;
  var uuid = Uuid();
  RxString userId = ''.obs;
  RxDouble finalPrice = 0.0.obs;
  RxBool isLoading = false.obs;
  void cekData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userUid = prefs.getString('userId');
    if (userUid != null) {
      userId.value = userUid;
    }
  }

  getJadwal() async {
    try {
      final jadwalBusSnapshot =
          await FirebaseFirestore.instance.collection("jadwal_bus").get();
      if (jadwalBusSnapshot.docs.isNotEmpty) {
        List<JadwalBus> tempData = [];
        List<Bus> tempBusData = [];
        for (var element in jadwalBusSnapshot.docs) {
          print('Processing jadwal_bus document: ${element.id}');
          var jadwalData = element.data();
          var busRef = jadwalData['busId'] as DocumentReference;
          var busId = busRef.id;

          var busDoc = await FirebaseFirestore.instance
              .collection('bus')
              .doc(busId)
              .get();

          if (busDoc.exists) {
            print('Found corresponding bus document: ${busDoc.id}');
            var busData = busDoc.data();
            if (busData != null) {
              JadwalBus jadwalBusItem = JadwalBus.fromJson(
                  Map<String, dynamic>.from(jadwalData), element.id);
              Bus busItem =
                  Bus.fromJson(Map<String, dynamic>.from(busData), element.id);

              print('Adding JadwalBus item: $jadwalBusItem');
              print('Adding Bus item: $busItem');
              // harga.value = true;

              tempData.add(jadwalBusItem);
              tempBusData.add(busItem);
            } else {
              print('Bus data is null for document: ${busDoc.id}');
            }
          } else {
            print('Bus document does not exist for id: $busId');
          }
        }

        print('Assigning ${tempData.length} JadwalBus items to dataJadwal');
        dataJadwal.assignAll(tempData);

        print('Assigning ${tempBusData.length} Bus items to dataBusDiJadwal');
        dataBusDiJadwal.assignAll(tempBusData);

        statusJ.value = true;
        print('Data loading status set to true');
      } else {
        print('No documents found in jadwal_bus collection.');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  checkDiscounts() async {
    double totalDiscount = 0.0;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // DocumentSnapshot jadwalSnapshot = await firestore
    //     .collection('jadwal_bus')
    //     .doc(selectJadwalId.value)
    //     .get();
    // var tujuanData = jadwalSnapshot.data();
    // String tujuan = tujuanData?['tujuan'] ?? '';

    QuerySnapshot tujuanDiscounts = await firestore
        .collection('diskon')
        .where('type', isEqualTo: 'jadwal_bus')
        .where('jadwalBusId',
            isEqualTo:
                firestore.collection('jadwal_bus').doc(selectJadwalId.value))
        .get();

    for (var doc in tujuanDiscounts.docs) {
      Map<String, dynamic> total = doc.data() as Map<String, dynamic>;

      totalDiscount += total['discountPercentage'];
    }

    // Ambil diskon berdasarkan metode pembayaran
    QuerySnapshot paymentDiscounts = await firestore
        .collection('diskon')
        .where('type', isEqualTo: 'metode_pembayaran')
        .where('metodePembayaranId',
            isEqualTo: firestore
                .collection('metodePembayaran')
                .doc(selectedPaymentId.value))
        .get();

    for (var doc in paymentDiscounts.docs) {
      Map<String, dynamic> total = doc.data() as Map<String, dynamic>;
      totalDiscount += total['discountPercentage'];
    }

    // Diskon tambahan untuk jumlah pembelian di atas tiga
    QuerySnapshot userTransactions = await firestore
        .collection('transaksi')
        .where('userId', isEqualTo: userId.value)
        .get();

    if (userTransactions.docs.length > 3) {
      totalDiscount += 5.0;
    }

    // Pastikan diskon tidak lebih dari 100%
    if (totalDiscount > 100.0) {
      totalDiscount = 100.0;
    }

    return totalDiscount;
  }

  getTicketPrice() async {
    if (selectJadwalId.value != "") {
      DocumentSnapshot jadwalSnapshot =
          await fs.collection('jadwal_bus').doc(selectJadwalId.value).get();
      if (jadwalSnapshot.exists) {
        // var jadwalData = jadwalSnapshot.data();
        hargaAwal.value = jadwalSnapshot['harga'];
        double discount = await checkDiscounts();

        finalPrice.value = hargaAwal.value - (hargaAwal.value * discount / 100);
        harga.value = true;
        // harga.value = false;

        // if (jadwalData != null) {}
      } else {
        throw Exception('Jadwal bus not found');
      }
    } else {
      print('no data hargaaa co');
    }
  }

  getPayment() async {
    final jadwal = await fs.collection("metodePembayaran").get();
    if (jadwal.docs.isNotEmpty) {
      print(jadwal.docs);

      jadwal.docs.map((e) {
        print(e.id);
        PaymentMethod paymentList =
            PaymentMethod.fromJson(Map.from(e.data()), e.id);
        dataPayment.add(paymentList);
      }).toList();
      status.value = true;
    }
  }

  createTransaction() async {
    try {
      isLoading.value = true;
      print("loading mulai co");

      double originalPrice = hargaAwal.value.toDouble();
      print("dd");
      double discount = await checkDiscounts();
      print("ddddd");

      finalPrice.value = originalPrice - (originalPrice * discount / 100);
      print("ddddddd");

      String transactionId = uuid.v4();
      print("dddddddddd");

      CollectionReference transaksi = fs.collection("transaksi");
      // Simpan data transaksi ke Firestore
      print("dddddddddddd");

      DocumentReference jadwal_busRef =
          fs.collection("jadwal_bus").doc(selectJadwalId.value);
      DocumentReference paymentRef =
          fs.collection("metodePembayaran").doc(selectedPaymentId.value);
      print("dddddddddddddddddd");

      final data = {
        "nama": nama.text,
        'userId': userId.value,
        'jadwalBusId': jadwal_busRef,
        'paymentMethodId': paymentRef,
        'transactionId': transactionId,
        'price': finalPrice.value,
        'isScanned': false,
      };
      print("ddddddddddddddddddddddddddddd");

      transaksi.add(data).then((value) => {
            print('val $value'),
            Get.defaultDialog(
              title: 'Success',
              middleText: 'Transaction created successfully',
            ),
            Get.offAllNamed(Routes.USER)
          });

      print("ddddddddddddaaaaaaaaaaaa");

      isLoading.value = false;
      print("loading selse");
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to create transaction: $e',
      );
      isLoading.value = true;
    }
  }

  @override
  void onInit() {
    getJadwal();
    getPayment();
    print('data ${dataBusDiJadwal}');
    print('dataaa ${dataJadwal}');
    cekData();
    super.onInit();
  }
}
