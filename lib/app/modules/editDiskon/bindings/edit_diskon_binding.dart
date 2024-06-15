import 'package:get/get.dart';

import '../controllers/edit_diskon_controller.dart';

class EditDiskonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditDiskonController>(
      () => EditDiskonController(),
    );
  }
}
