// ignore_for_file: unnecessary_overrides, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

class PaymenyMethodController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool status = false.obs;
  List<PaymentMethod> data = [];

  getPayment() async {
    final payment = await fs.collection("metodePembayaran").get();
    if (payment.docs.isNotEmpty) {
      print(payment.docs);

      payment.docs.map((e) {
        print(e.id);
        PaymentMethod paymentList =
            PaymentMethod.fromJson(Map.from(e.data()), e.id);
        data.add(paymentList);
      }).toList();
      status.value = true;
    }
  }

  deleteBus(String id) async {
    try {
      await fs.collection("metodePembayaran").doc(id).delete();
      Get.defaultDialog(
          middleText: 'Berhasil Menghapus metodePaymenyt dengan id $id',
          title: 'Success');
      Get.offAllNamed(Routes.PAYMENY_METHOD);
    } catch (e) {
      Get.defaultDialog(
          middleText: 'Gagal Menghapus metodePaymenyt', title: 'Gagal');
    }
  }

  @override
  void onInit() {
    getPayment();
    print('data paymeny $data]');
    super.onInit();
  }
}
