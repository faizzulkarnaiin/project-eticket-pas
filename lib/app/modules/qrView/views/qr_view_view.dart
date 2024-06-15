// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/qr_view_controller.dart';

class QrViewView extends GetView<QrViewController> {
  const QrViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final qr = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: const Text('QrViewView'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                Text("isi kode transaksi ${qr}"),
                SizedBox(
                  height: 12,
                ),
                Container(
                    width: 300,
                    height: 300,
                    margin: EdgeInsets.only(bottom: 20),
                    child: QrImageView(
                      
                      data: qr,
                      version: QrVersions.auto,
                      size: 300,
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () => controller.scanQr1(qr),
                      child: Text("Scan QR")),
                )
              ],
            ),
          ),
        ));
  }
}
