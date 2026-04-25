import 'package:get/get.dart';
import '../controller/payment_method_controller.dart';



class PaymentMethodBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodController>(() => PaymentMethodController());
  }
}
