// ignore_for_file: unnecessary_overrides, avoid_print

import 'package:get/get.dart';
import 'package:project_pas_bus_eticket/app/controller/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final authController = Get.put(AuthController());
  RxString role = ''.obs;
  // void checkData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? savedRole = prefs.getString('role');
  //   if (savedRole != null) {
  //     role.value = savedRole;
  //   }
  //   print(role.value);
  // }
  void checkData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedRole = prefs.getString('role');
    if (savedRole != null) {
      role.value = savedRole;
    }
    print(role.value);
  }

  @override
  void onInit() {
    checkData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
