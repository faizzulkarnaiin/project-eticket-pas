// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

import '../controllers/bus_controller.dart';

class BusView extends GetView<BusController> {
  const BusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BusView'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Obx(() => controller.status.value
                  ? DataTable(
                      columns: [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('capacity')),
                        DataColumn(label: Text('type')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: List.generate(controller.data.length, (index) {
                        var number = index + 1;
                        Bus dt = controller.data[index];
                        return DataRow(cells: [
                          DataCell(Text("$number")),
                          DataCell(Text(dt.name)),
                          DataCell(Text(dt.capacity.toString())),
                          DataCell(Text(dt.type.toString())),
                          DataCell(Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.EDIT_BUS, arguments: dt);
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: 'Are You Sure ',
                                        middleText: 'Delete This Bus ?',
                                        confirm: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey),
                                            onPressed: () {
                                              controller.deleteBus(dt.id);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        cancel: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
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
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.CREATE_BUS),
                  child: Text("Create Bus"))
            ],
          ),
        ));
  }
}
