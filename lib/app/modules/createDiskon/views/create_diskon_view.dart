// ignore_for_file: prefer_const_constructors, avoid_print, use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';

import '../controllers/create_diskon_controller.dart';

class CreateDiskonView extends GetView<CreateDiskonController> {
  const CreateDiskonView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateDiskonView'),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        // Tambahkan SingleChildScrollView di sini
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Column(
                children: [
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
                  Visibility(
                    visible: controller.selectedDiscountType.value ==
                        "Metode Pembayaran",
                    child: Obx(() => controller.status.value
                        ? DropdownButton<String>(
                            value: controller.selectedDiscountType.value,
                            onChanged: (newValue) {
                              controller.selectedDiscountType.value = newValue!;
                              print(controller.selectedDiscountType.value);
                            },
                            items: <String>['Metode Pembayaran', 'Jadwal Bus']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        : CircularProgressIndicator()),
                  ),
                  SizedBox(height: 16),
                  Obx(() => controller.selectedDiscountType.value ==
                          "Jadwal Bus"
                      ? Visibility(
                          visible: controller.selectedDiscountType.value ==
                              "Jadwal Bus",
                          child: Obx(() => controller.status.value
                              ? DropdownButton<String>(
                                  value: controller
                                          .selectedJadwalBusId.value.isEmpty
                                      ? null
                                      : controller.selectedJadwalBusId.value,
                                  hint: Text("Pilih Jadwal"),
                                  onChanged: (String? newValue) {
                                    controller.selectedJadwalBusId.value =
                                        newValue!;
                                    print("Selected Bus ID: $newValue");
                                  },
                                  items: controller.dataJadwal
                                      .map((JadwalBus bus) {
                                    return DropdownMenuItem<String>(
                                      value: bus.id,
                                      child: Text(bus.tujuan),
                                    );
                                  }).toList(),
                                )
                              : CircularProgressIndicator()),
                        )
                      : Text(
                          "Pilihan Bus akan muncul apabila anda memilih jadwal bus")),
                  Obx(() => controller.selectedDiscountType.value ==
                          "Metode Pembayaran"
                      ? Visibility(
                          visible: controller.selectedDiscountType.value ==
                              "Metode Pembayaran",
                          child: Obx(() => controller.status.value
                              ? DropdownButton<String>(
                                  value:
                                      controller.selectedPaymentId.value.isEmpty
                                          ? null
                                          : controller.selectedPaymentId.value,
                                  hint: Text("Pilih Payment"),
                                  onChanged: (String? newValue) {
                                    controller.selectedPaymentId.value =
                                        newValue!;
                                    print("Selected Payment ID: $newValue");
                                  },
                                  items: controller.dataPembayaran
                                      .map((PaymentMethod bus) {
                                    return DropdownMenuItem<String>(
                                      value: bus.id,
                                      child: Text(bus.nama),
                                    );
                                  }).toList(),
                                )
                              : CircularProgressIndicator()),
                        )
                      : Text(
                          "pilihan pembayaran akan muncul apabila anda memilih metode pembayaran")),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.createDiskon(),
                    child: Text("Save Diskon"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
