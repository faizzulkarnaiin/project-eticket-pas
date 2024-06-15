// ignore_for_file: use_super_parameters, prefer_const_constructors, unused_local_variable, avoid_print

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
// ignore: unused_import
import 'package:project_pas_bus_eticket/app/model/newBus.dart';
import 'package:project_pas_bus_eticket/app/modules/createJadwal/controllers/create_jadwal_controller.dart';

import '../controllers/edit_jadwal_controller.dart';

class EditJadwalView extends GetView<EditJadwalController> {
  const EditJadwalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final JadwalBus jadwalBus = Get.arguments['dt'];
    final Bus bus = Get.arguments['bus'];
    controller.updateVariables(bus, jadwalBus);
    print('dddddadadadad ${controller.dataBus}');
    final srt = Get.put(CreateJadwalController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('EditJadwalView'),
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
                  SizedBox(
                    height: 16,
                  ),
                  Obx(() => controller.status.value
                      ? TextField(
                          controller: controller.dateController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: "Enter Date" //label text of field
                              ),
                          readOnly: true,
                          onChanged: (value) async {
                            controller.tanggal.value =
                                value.toString().substring(0, 10);
                            controller.dateController.text =
                                value.toString().substring(0, 10);
                            print(controller.tanggal.value);
                            print(controller.dateController.text);
                          },
                          onTap: () async {
                            //when click we have to show the datepicker

                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(
                                    int.parse(
                                        controller.tanggal.value.split('-')[0]),
                                    int.parse(
                                        controller.tanggal.value.split('-')[1]),
                                    int.parse(controller.tanggal.value
                                        .split('-')[2])),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              print(
                                  'ini dia ${DateTime(int.parse(controller.tanggal.value.split('-')[0]), int.parse(controller.tanggal.value.split('-')[1]), int.parse(controller.tanggal.value.split('-')[2]))}');
                              print(pickedDate);
                              controller.tanggal.value =
                                  pickedDate.toString().substring(0, 10);
                              controller.dateController.text =
                                  pickedDate.toString().substring(0, 10);
                              print('ini tanggal ${controller.tanggal.value}');
                              print(controller.dateController.text);
                            } else {
                              print('ga ada konci');
                            }
                          },
                        )
                      : CircularProgressIndicator()),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(() => controller.status.value
                      ? DropdownButton<String>(
                          value: controller.selectedBusId.value,
                          hint: Text("Pilih Bus"),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectBusId.value = newValue;
                              print("Selected Bus ID: $newValue");
                            }
                          },
                          items: controller.dataBusNew.map((Bus bus) {
                            return DropdownMenuItem(
                              value: bus.id,
                              child: Text(bus.name),
                            );
                          }).toList(),
                        )
                      : CircularProgressIndicator()),
                  SizedBox(
                    height: 16,
                  ),
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
                      onPressed: () => controller.updateJadwal(jadwalBus.id),
                      child: Text(
                        "saveee",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
