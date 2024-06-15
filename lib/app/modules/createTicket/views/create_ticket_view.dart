// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, avoid_unnecessary_containers, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';

import '../controllers/create_ticket_controller.dart';

class CreateTicketView extends GetView<CreateTicketController> {
  const CreateTicketView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CreateTicketView'),
          centerTitle: true,
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text('haiii ${controller.userId}'),
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() => controller.statusJ.value == true
                        ? Container(
                            child: Column(
                              children: List.generate(
                                  controller.dataJadwal.length, (index) {
                                JadwalBus dt = controller.dataJadwal[index];
                                Bus bus = controller.dataBusDiJadwal[index];
                                return ListTile(
                                  // selectedColor,
                                  // style: ,
                                  selectedTileColor: Colors.red,
                                  selected:
                                      controller.selectJadwalId.value == dt.id
                                          ? true
                                          : false,
                                  onTap: () {
                                    controller.selectJadwalId.value = dt.id;
                                    controller.getTicketPrice();
                                    print(controller.selectJadwalId.value =
                                        dt.id);
                                    print(
                                        'harga awal : ${controller.hargaAwal}');
                                    // print('dddddd ${dt.tujuan}');
                                  },
                                  leading: Text('Tujuan : ${dt.tujuan}'),
                                  title: Text(dt.jadwalBerangkat),
                                  subtitle: Text('harga : ${dt.harga}'),
                                  trailing: Text('Bus : ${bus.name}'),
                                );
                              }),
                            ),
                          )
                        : CircularProgressIndicator()),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: controller.nama,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "masukkan nama",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() => controller.status.value
                        ? DropdownButton<String>(
                            value: controller.selectedPaymentId.value.isEmpty
                                ? null
                                : controller.selectedPaymentId.value,
                            hint: Text("Pilih Payment"),
                            onChanged: (String? newValue) {
                              controller.selectedPaymentId.value = newValue!;
                              print("Selected Payment ID: $newValue");
                            },
                            items:
                                controller.dataPayment.map((PaymentMethod bus) {
                              return DropdownMenuItem<String>(
                                value: bus.id,
                                child: Text(bus.nama),
                              );
                            }).toList(),
                          )
                        : CircularProgressIndicator()),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() =>
                              Text('harga awal : ${controller.hargaAwal}')),
                          Obx(() => Text(
                              'harga termasuk diskon : ${controller.finalPrice}'))
                        ]),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() => controller.isLoading.value ? Center(
                      child: CircularProgressIndicator(),
                    ) : Text("d")),
                    ElevatedButton(
                        onPressed: () {
                          controller.createTransaction();
                          print("ok");
                        }, child: Text('Bayaar ticket'))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
