// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';
import '../controllers/diskon_controller.dart';

class DiskonView extends GetView<DiskonController> {
  const DiskonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DiskonView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              Obx(() => controller.status.value
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: controller.diskonTempList.length,
                        itemBuilder: (context, index) {
                          var diskon = controller.diskonTempList[index];
                          var type = diskon['type'];
                          var discountPercentage = diskon['discountPercentage'];
                          var relatedItem = type == 'jadwal_bus'
                              ? diskon['jadwal_bus']
                              : diskon['metode_pembayaran'];
                          var id = diskon['id'];

                          return ListTile(
                            onTap: () {},
                            leading: IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'Are You Sure?',
                                  middleText: 'Delete This Diskon?',
                                  confirm: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey),
                                    onPressed: () {
                                      controller.deleteDiskon(id);
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () => Get.back(),
                                    child: const Text(
                                      'No',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            title: Text('Type: $type'),
                            subtitle: Text(
                                'Discount Percentage: $discountPercentage %'),
                            trailing: Container(
                              width: 300,
                              child: Row(
                                children: [
                                  Text(
                                    'Related Item: ${relatedItem != null ? relatedItem['nama'] ?? relatedItem['tujuan'] : 'No Related Item'}',
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.EDIT_DISKON,
                                          arguments: {"diskon": diskon});
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const CircularProgressIndicator()),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.CREATE_DISKON),
                child: const Text("Create Diskon"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
