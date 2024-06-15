// ignore_for_file: use_super_parameters, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/model/bus.dart';

import '../controllers/edit_bus_controller.dart';

class EditBusView extends GetView<EditBusController> {
  const EditBusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Bus data = Get.arguments;
    controller.updateVariables(data);

    return Scaffold(
        appBar: AppBar(
          title: const Text('EditBusView'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text("Update Bus"),
                    SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: controller.name,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "nama bus",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: controller.type,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "tipe bus",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: controller.capacity,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "kapasitas bus",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Sign in With Google
                        controller.updateBus(data.id);
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
