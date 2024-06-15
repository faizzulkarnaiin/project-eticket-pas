// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AdminView'),
          centerTitle: true,
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset("assets/city_bus-bro.webp"),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Bus apk admin view"),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () => Get.toNamed(Routes.BUS),
                            child: Text(" Bus")),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () => Get.toNamed(Routes.JADWAL_BUS),
                            child: Text("Jadwal Bus")),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () => Get.toNamed(Routes.PAYMENY_METHOD),
                            child: Text("payment method")),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () => Get.toNamed(Routes.DISKON),
                            child: Text("Diskon")),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () => Get.toNamed(Routes.QR_SCAN),
                            child: Text("scan qr code")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
