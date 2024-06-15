// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

import '../controllers/paymeny_method_controller.dart';

class PaymenyMethodView extends GetView<PaymenyMethodController> {
  const PaymenyMethodView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PaymenyMethodView'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Center(
                child: Obx(() => controller.status.value
                    ? DataTable(
                        columns: [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Aksi')),
                        ],
                        rows: List.generate(controller.data.length, (index) {
                          var number = index + 1;
                          PaymentMethod dt = controller.data[index];
                          return DataRow(cells: [
                            DataCell(Text("$number")),
                            DataCell(Text(dt.nama)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.EDIT_PAYMENT,
                                          arguments: dt);
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: 'Are You Sure ',
                                          middleText: 'Delete This Paymeny ?',
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
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.CREATE_PAYMENT),
                  child: Text("Create Payment"))
            ],
          ),
        ));
  }
}
