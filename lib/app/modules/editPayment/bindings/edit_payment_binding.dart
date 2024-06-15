import 'package:get/get.dart';

import '../controllers/edit_payment_controller.dart';

class EditPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPaymentController>(
      () => EditPaymentController(),
    );
  }
}
