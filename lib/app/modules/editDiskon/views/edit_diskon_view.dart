// ignore_for_file: use_super_parameters, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/edit_diskon_controller.dart';

class EditDiskonView extends GetView<EditDiskonController> {
  const EditDiskonView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final diskon = Get.arguments["diskon"];
    controller.fillControllers(diskon);
    final String diskonId = diskon['id'];
    return Scaffold(
        appBar: AppBar(
          title: const Text('EditDiskonView'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                // Obx(() => controller.selectedDiscountType.value != ""
                //     ? Text(
                //         "Selected Discount Type: ${controller.selectedDiscountType.value}")
                //     : Text("g")),
                // Obx(() => controller.selectedJadwalBusId != ""
                //     ? Text(
                //         "Selected Discount Type: ${controller.selectedJadwalBusId}")
                //     : Text("g")),
                // Obx(() => controller.selectedPaymentId != ""
                //     ? Text(
                //         "Selected Discount Type: ${controller.selectedPaymentId}")
                //     : Text("g ada")),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: controller.presentasiDiskon,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: "Persentasi Diskon",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Obx(() => controller.statusB.value
                //     ? DropdownButton<String>(
                //         value: controller.selectedDiscountType.value,
                //         onChanged: (newValue) {
                //           controller.selectedDiscountType.value = newValue!;
                //           print(controller.selectedDiscountType.value);
                //         },
                //         items: <String>['Metode Pembayaran', 'Jadwal Bus']
                //             .map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //       )
                //     : CircularProgressIndicator()),
                SizedBox(height: 16),
                // Visibility(
                //   visible: controller.selectedDiscountType.value ==
                //       "Metode Pembayaran",
                //   child: Obx(() => controller.status.value
                //       ? DropdownButton<String>(
                //           value: controller.selectedDiscountType.value,
                //           onChanged: (newValue) {
                //             controller.selectedDiscountType.value = newValue!;
                //             print(controller.selectedDiscountType.value);
                //           },
                //           items: <String>['Metode Pembayaran', 'Jadwal Bus']
                //               .map<DropdownMenuItem<String>>((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //         )
                //       : CircularProgressIndicator()),
                // ),
                SizedBox(height: 16),
                // Obx(() => controller.selectedDiscountType.value == "jadwal_bus"
                //     ? Visibility(
                //         visible: controller.selectedDiscountType.value ==
                //             "Jadwal Bus",
                //         child: Obx(() => controller.statusGetP.value
                //             ? DropdownButton<String>(
                //                 value:
                //                     controller.p.value.isEmpty
                //                         ? null
                //                         : controller.p.value,
                //                 hint: Text("Pilih Jadwal"),
                //                 onChanged: (String? newValue) {
                //                   controller.selectedJadwalBusId.value =
                //                       newValue!;
                //                   print("Selected Bus ID: $newValue");
                //                 },
                //                 items:
                //                     controller.dataJadwal.map((JadwalBus bus) {
                //                   return DropdownMenuItem<String>(
                //                     value: bus.id,
                //                     child: Text(bus.tujuan),
                //                   );
                //                 }).toList(),
                //               )
                //             : CircularProgressIndicator()),
                //       )
                //     : Text(
                //         "Pilihan Bus akan muncul apabila anda memilih jadwal bus")),
                // Obx(() => controller.selectedDiscountType.value ==
                //         "metode_pembayaran"
                //     ? Visibility(
                //         visible: controller.selectedDiscountType.value ==
                //             "Metode Pembayaran",
                //         child: Obx(() => controller.status1.value
                //             ? DropdownButton<String>(
                //                 value:
                //                     controller.selectedPaymentId.value.isEmpty
                //                         ? null
                //                         : controller.selectedPaymentId.value,
                //                 hint: Text("Pilih Payment"),
                //                 onChanged: (String? newValue) {
                //                   controller.selectedPaymentId.value =
                //                       newValue!;
                //                   print("Selected Payment ID: $newValue");
                //                 },
                //                 items: controller.dataPembayaran
                //                     .map((PaymentMethod bus) {
                //                   return DropdownMenuItem<String>(
                //                     value: bus.id,
                //                     child: Text(bus.nama),
                //                   );
                //                 }).toList(),
                //               )
                //             : CircularProgressIndicator()),
                //       )
                //     : Text(
                //         "pilihan pembayaran akan muncul apabila anda memilih metode pembayaran")),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () => controller.updateDiskon(diskonId),
                  child: Text("Save update"),
                ),
              ],
            ),
          ),
        ));
  }
}
