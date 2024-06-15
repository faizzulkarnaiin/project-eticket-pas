// ignore_for_file: use_super_parameters, prefer_const_constructors, unused_import, avoid_print, unused_element

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/controller/auth_controller.dart';
import 'package:project_pas_bus_eticket/app/modules/admin/views/admin_view.dart';
import 'package:project_pas_bus_eticket/app/modules/user/views/user_view.dart';
import 'package:project_pas_bus_eticket/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Obx(() {
      if (controller.role.value == "admin") {
        // print(authController.userRole.value);
        // print(controller.role.value);
        // print('aaaa');

        return AdminView();
      } else {
        print(authController.userRole.value);
        print(controller.role.value);

        // print('yyyyyyyyyy');
        return UserView();
      }
    });
  }
}
