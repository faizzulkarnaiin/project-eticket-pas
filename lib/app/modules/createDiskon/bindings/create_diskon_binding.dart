import 'package:get/get.dart';

import '../controllers/create_diskon_controller.dart';

class CreateDiskonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateDiskonController>(
      () => CreateDiskonController(),
    );
  }
}
