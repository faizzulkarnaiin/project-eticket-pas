import 'package:get/get.dart';

import '../controllers/paymeny_method_controller.dart';

class PaymenyMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymenyMethodController>(
      () => PaymenyMethodController(),
    );
  }
}
