// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';
import 'package:project_pas_bus_eticket/app/model/jadwalBus.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';
import 'package:project_pas_bus_eticket/app/model/transaksi.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('UserView'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.CREATE_TICKET),
                    child: Text("Buy Tickets")),
                // ElevatedButton(
                //     onPressed: () => controller.getTranskasi(),
                //     child: Text("auah")),
                SizedBox(
                  height: 16,
                ),
                Obx(() => controller.status.value &&
                        controller.konci.value == false
                    ? DataTable(
                        columns: [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('nama pembeli')),
                          DataColumn(label: Text('jadwal bus')),
                          DataColumn(label: Text('nama bus')),
                          DataColumn(label: Text('harga')),
                          DataColumn(label: Text('metode bayar')),
                          DataColumn(label: Text('sudah di scan ?')),
                          DataColumn(label: Text('cek qr')),
                        ],
                        rows: List.generate(controller.transaksiDataList.length,
                            (index) {
                          var number = index + 1;
                          Transkaksi dt = controller.transaksiDataList[index];
                          JadwalBus jadwal = controller.jadwalDataList[index];
                          Bus bus = controller.busDataList[index];
                          PaymentMethod payment =
                              controller.paymentDataList[index];
                          return DataRow(cells: [
                            DataCell(Text("$number")),
                            DataCell(Text(dt.nama)),
                            DataCell(Text(jadwal.jadwalBerangkat)),
                            DataCell(Text(bus.name)),
                            DataCell(Text(jadwal.harga.toString())),
                            DataCell(Text(payment.nama)),
                            DataCell(Text(dt.isScanned ? "Udah" : "Belum")),
                            DataCell(IconButton(
                              icon: Icon(Icons.qr_code),
                              onPressed: () =>
                                  Get.toNamed(Routes.QR_VIEW, arguments: dt.id),
                            )),
                          ]);
                        }),
                      )
                    : controller.konci.value
                        ? Text('antum nih belom beli apa2 ')
                        : CircularProgressIndicator())
              ],
            ),
          ),
        ));
  }
}
