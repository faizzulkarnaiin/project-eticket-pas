import 'package:get/get.dart';

import '../controllers/create_jadwal_controller.dart';

class CreateJadwalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateJadwalController>(
      () => CreateJadwalController(),
    );
  }
}
