// ignore_for_file: avoid_print, prefer_const_constructors, use_super_parameters

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';

import '../controllers/create_jadwal_controller.dart';

class CreateJadwalView extends GetView<CreateJadwalController> {
  const CreateJadwalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CreateJadwalView'),
          centerTitle: true,
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text("Pilih tanggal"),
                  Obx(() => controller.status.value
                      ? DatePicker(
                          maxDate: DateTime(2030),
                          minDate: DateTime(2024),
                          onDateSelected: (value) {
                            controller.tanggal.value =
                                value.toString().substring(0, 10);
                            print(controller.tanggal);
                          },
                        )
                      : CircularProgressIndicator()),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Pilih Bus"),
                  Obx(() => controller.status.value
                      ? DropdownButton<String>(
                          value: controller.selectedBusId.value.isEmpty
                              ? null
                              : controller.selectedBusId.value,
                          hint: Text("Pilih Bus"),
                          onChanged: (String? newValue) {
                            controller.selectedBusId.value = newValue!;
                            print("Selected Bus ID: $newValue");
                          },
                          items: controller.data.map((Bus bus) {
                            return DropdownMenuItem<String>(
                              value: bus.id,
                              child: Text(bus.name),
                            );
                          }).toList(),
                        )
                      : CircularProgressIndicator()),
                  TextField(
                    controller: controller.harga,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "harga",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: controller.tujuan,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "tujuan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color.fromARGB(255, 4, 86, 153), // Background color
                        // textStyle: , // Text color
                        minimumSize: Size(
                            double.infinity, 60), // Lebar se layar, tinggi 50
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5, // Shadow depth
                      ),
                      onPressed: () => controller.saveJadwalBus(),
                      child: Text("saveee", style: TextStyle(
                        color: Colors.white
                      ),))
                ],
              ),
            ),
          ],
        ));
  }
}
