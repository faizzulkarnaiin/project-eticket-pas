import 'package:get/get.dart';

import '../controllers/jadwal_bus_controller.dart';

class JadwalBusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalBusController>(
      () => JadwalBusController(),
    );
  }
}
