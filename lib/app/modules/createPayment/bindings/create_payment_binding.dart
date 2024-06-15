import 'package:get/get.dart';

import '../controllers/create_payment_controller.dart';

class CreatePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePaymentController>(
      () => CreatePaymentController(),
    );
  }
}
