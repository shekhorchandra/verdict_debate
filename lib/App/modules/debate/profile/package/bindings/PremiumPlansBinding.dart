import 'package:get/get.dart';
import '../controller/PremiumPlansController.dart';

class PremiumPlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PremiumPlansController>(() => PremiumPlansController());
  }
}