// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_super_parameters, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_bus_controller.dart';

class CreateBusView extends GetView<CreateBusController> {
  const CreateBusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CreateBusView'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text("Create Bus"),
                    SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: controller.busName,
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
                      controller: controller.busType,
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
                      controller: controller.busCapaity,
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
                        controller.saveBus();
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
