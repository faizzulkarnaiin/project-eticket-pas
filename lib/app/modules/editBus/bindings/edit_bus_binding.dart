import 'package:get/get.dart';

import '../controllers/edit_bus_controller.dart';

class EditBusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditBusController>(
      () => EditBusController(),
    );
  }
}
