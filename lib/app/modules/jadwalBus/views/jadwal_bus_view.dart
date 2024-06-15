  // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_super_parameters, unused_import

  import 'package:date_picker_plus/date_picker_plus.dart';
  import 'package:flutter/material.dart';

  import 'package:get/get.dart';
  import 'package:project_pas_bus_eticket/app/model/bus.dart';
  import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
  import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

  import '../controllers/jadwal_bus_controller.dart';

  class JadwalBusView extends GetView<JadwalBusController> {
    const JadwalBusView({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('JadwalBusView'),
            centerTitle: true,
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Obx(() => controller.status.value
                    ? DataTable(
                        columns: [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Jadwal')),
                          DataColumn(label: Text('harga')),
                          DataColumn(label: Text('tujuan')),
                          DataColumn(label: Text('nama bus')),
                          DataColumn(label: Text('Aksi')),
                        ],
                        rows: List.generate(controller.data.length, (index) {
                          var number = index + 1;
                          JadwalBus dt = controller.data[index];
                          Bus bus = controller.dataBusDiJadwal[index];
                          return DataRow(cells: [
                            DataCell(Text("$number")),
                            DataCell(Text(dt.jadwalBerangkat)),
                            DataCell(Text(dt.harga.toString())),
                            DataCell(Text(dt.tujuan.toString())),
                            DataCell(Text(bus.name)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.EDIT_JADWAL,
                                            arguments: {
                                              "dt" : dt,
                                              "bus" : bus
                                            });
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: 'Are You Sure ',
                                          middleText: 'Delete This Bus ?',
                                          confirm: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey),
                                              onPressed: () {
                                                controller.deleteJadwal(dt.id);
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          cancel: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.red),
                                              onPressed: () => Get.back(),
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )));
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            )),
                          ]);
                        }),
                      )
                    : Center(child: CircularProgressIndicator())),
                    SizedBox(height: 70,),
                  ElevatedButton(onPressed: () => Get.toNamed(Routes.CREATE_JADWAL), child: Text("Create jadwal"))
                  ],
                ),
              ),
            ],
          ));
    }
  }
