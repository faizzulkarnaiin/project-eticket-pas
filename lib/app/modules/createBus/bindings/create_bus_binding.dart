import 'package:get/get.dart';

import '../controllers/create_bus_controller.dart';

class CreateBusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBusController>(
      () => CreateBusController(),
    );
  }
}
