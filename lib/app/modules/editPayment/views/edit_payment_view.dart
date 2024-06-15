// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_super_parameters

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/paymentMethod.dart';

import '../controllers/edit_payment_controller.dart';

class EditPaymentView extends GetView<EditPaymentController> {
  const EditPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PaymentMethod data = Get.arguments;
    controller.updateVariables(data);
    return Scaffold(
        appBar: AppBar(
          title: const Text('EditPaymentView'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text("Create Payment Method"),
                    SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: controller.namaPembayaran,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "nama metode",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Sign in With Google
                        controller.updatepayment(data.id);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}